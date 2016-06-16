//
//  WXNSoundToolsManger.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/2/25.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXSoundToolManager.h"
#import <AVFoundation/AVFoundation.h>

#define kMusicType @"kMusicType"
#define kSoundType @"kSoundType"

@interface WNXSoundToolManager()
{
    BOOL _loadData;
}

@property (nonatomic, strong) AVAudioPlayer *bgPlayer;
@property (nonatomic, strong) NSMutableDictionary *soundIDs;

@end

@implementation WNXSoundToolManager

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

static WNXSoundToolManager *instance = nil;

+ (instancetype)sharedSoundToolManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WNXSoundToolManager alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
        _loadData = YES;
        
        self.bgMusicType = [[NSUserDefaults standardUserDefaults] integerForKey:kMusicType];
        self.soundType = [[NSUserDefaults standardUserDefaults] integerForKey:kSoundType];
        
        [self loadSounds];
    }
    
    return self;
}

- (AVAudioPlayer *)bgPlayer {
    if (!_bgPlayer) {
        
        NSURL *bgMusicURL = [[NSBundle mainBundle] URLForResource:kBgMusicURLName withExtension:nil];
        
        _bgPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:bgMusicURL error:nil];
        [_bgPlayer prepareToPlay];
        _bgPlayer.numberOfLoops = -1;
        
        _bgPlayer.volume = [self volumeOfSoundPlayType:[[NSUserDefaults standardUserDefaults] integerForKey:kMusicType]];
        
        AudioSessionAddPropertyListener(kAudioSessionProperty_CurrentHardwareOutputVolume,
                                        audioVolumeChange, NULL);
    }
    
    return _bgPlayer;
}

- (void)setBgMusicType:(SoundPlayType)bgMusicType {
    _bgMusicType = bgMusicType;
    
    [[NSUserDefaults standardUserDefaults] setInteger:bgMusicType forKey:kMusicType];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.bgPlayer.volume = [self volumeOfSoundPlayType:bgMusicType];

    if (!_loadData) {
        if (bgMusicType == SoundPlayTypeMute) {
            [self.bgPlayer stop];
        } else {
            [self.bgPlayer play];
        }
    }
    _loadData = NO;
}

- (void)setSoundType:(SoundPlayType)soundType {
    _soundType = soundType;
    
    [[NSUserDefaults standardUserDefaults] setInteger:soundType forKey:kSoundType];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    switch (soundType) {
        case SoundPlayTypeHight:
            [self setSoundVolumn:1.0f];
            break;
        case SoundPlayTypeMiddle:
            [self setSoundVolumn:0.65];
        case SoundPlayTypeLow:
            [self setSoundVolumn:0.35];
        default:
            [self setSoundVolumn:0];
            break;
    }
}

- (void)playBgMusicWihtPlayAgain:(BOOL)playAgain {
    if ([self currentVolumn] == 0) {
        [self.bgPlayer pause];
        return;
    }
    
    if (self.bgMusicType == SoundPlayTypeMute) {
        [self.bgPlayer stop];
        return;
    }
    
    if ([self isOtherMusicPlaying]) {
        [self.bgPlayer stop];
        return;
    }
    
    if (playAgain) {
        [self.bgPlayer stop];
    }
    
    [self.bgPlayer play];
}

- (void)pauseBgMusic {
    [self.bgPlayer pause];
}

-  (void)stopBgMusic {
    [self.bgPlayer stop];
}

- (void)playSoundWithSoundName:(NSString *)soundName {
    
    if (self.soundType == SoundPlayTypeMute) return;
    
    if (![self currentVolumn]) return;
    
    [self loadSounds];
    
    SystemSoundID soundID = [self.soundIDs[soundName] unsignedIntValue];
    
    AudioServicesPlaySystemSound(soundID);
}

- (void)setBackgroundMusicVolume:(float)volume {
    [self.bgPlayer setVolume:volume];
}

#pragma mark -
#pragma mark 私有方法

- (float)volumeOfSoundPlayType:(SoundPlayType)type {
    float volume;
    
    switch (type) {
        case SoundPlayTypeHight:
            volume = 1.0;
            break;
        case SoundPlayTypeMiddle:
            volume= 0.65;
            break;
        case SoundPlayTypeLow:
            volume = 0.35;
            break;
        case SoundPlayTypeMute:
            volume = 0;
            break;
        default:
            break;
    }
    
    return volume;
}

#pragma mark 音量改变
void audioVolumeChange(void *inUserData, AudioSessionPropertyID inPropertyID,
                       UInt32 inPropertyValueSize, const void *inPropertyValue)
{
    // 1.获得音量
    Float32 value = *(Float32 *)inPropertyValue;
    
    // 2.根据当前音量决定播放还是暂停背景音乐
    if (value > 0) {
        [[WNXSoundToolManager sharedSoundToolManager] playBgMusicWihtPlayAgain:YES];
    } else {
        [[WNXSoundToolManager sharedSoundToolManager] pauseBgMusic];
    }
}

- (void)loadSounds {
    if (self.soundIDs) return;
    
    self.soundIDs = [NSMutableDictionary dictionary];
    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:kSoundURLName withExtension:nil];
    NSBundle *soundBundle = [NSBundle bundleWithURL:bundleURL];
    NSArray *boundsURLs = [soundBundle URLsForResourcesWithExtension:@"mp3" subdirectory:nil];

    for (NSURL *soundURL in boundsURLs) {
        [self loadSoundWithURL:soundURL];
    }
}

- (void)loadSoundWithURL:(NSURL *)url {
    NSString *soundPath = [url.path lastPathComponent];

    if ([self.soundIDs objectForKey:soundPath]) return;
    
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    [self.soundIDs setObject:@(soundID) forKey:soundPath];
}

#pragma mark 是否有其他音乐正在播放
- (BOOL)isOtherMusicPlaying {
    UInt32 playing;
    UInt32 dataSize = sizeof(UInt32);
    
    AudioSessionGetProperty(kAudioSessionProperty_OtherAudioIsPlaying,
                            &dataSize,
                            &playing);
    
    return playing;
}

#pragma mark 获得当前的音量
- (float)currentVolumn {
    float volume;
    UInt32 dataSize = sizeof(float);

    AudioSessionGetProperty (kAudioSessionProperty_CurrentHardwareOutputVolume,
                             &dataSize,
                             &volume);
    return volume;
}

- (void)setSoundVolumn:(float) volumn {
//    [[AVAudioSession sharedInstance] setValue:@(volumn) forKey:@"outputVolume"];
    AudioSessionSetProperty(kAudioSessionProperty_CurrentHardwareOutputVolume,
                            sizeof(float),
                            &volumn);
}

#pragma clang diagnostic pop

@end
