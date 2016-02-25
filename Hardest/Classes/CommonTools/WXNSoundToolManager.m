//
//  WXNSoundToolsManger.m
//  Hardest
//
//  Created by sfbest on 16/2/25.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WXNSoundToolManager.h"
#import <AVFoundation/AVFoundation.h>

#define kMusicType @"kMusicType"
#define kSoundType @"kSoundType"

@interface WXNSoundToolManager()

@property (nonatomic, strong) AVAudioPlayer *bgPlayer;
@property (nonatomic, strong) NSMutableDictionary *soundIDs;

@end

@implementation WXNSoundToolManager

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

static WXNSoundToolManager *instance = nil;

+ (instancetype)sharedSoundToolManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WXNSoundToolManager alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
        
        self.bgMusicType = [[NSUserDefaults standardUserDefaults] integerForKey:kMusicType];
        self.bgMusicType = [[NSUserDefaults standardUserDefaults] integerForKey:kSoundType];
        
        [self loadBgMusic];
        [self loadSounds];
    }
    
    return self;
}

- (void)setBgMusicType:(SoundPlayType)bgMusicType {
    _bgMusicType = bgMusicType;
    [[NSUserDefaults standardUserDefaults] setInteger:bgMusicType forKey:kMusicType];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.bgPlayer.volume = [self volumeOfSoundPlayType:bgMusicType];
    
}

- (void)setSoundType:(SoundPlayType)soundType {
    _soundType = soundType;
    [[NSUserDefaults standardUserDefaults] setInteger:soundType forKey:kSoundType];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
    
    [self loadBgMusic];
    
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

- (void)loadBgMusic {
    if (self.bgPlayer) return;
    
    NSURL *bgMusicURL = [[NSBundle mainBundle] URLForResource:kBgMusicURLName withExtension:nil];
    
    self.bgPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:bgMusicURL error:nil];
    self.bgPlayer.numberOfLoops = -1;
    self.bgPlayer.volume = [[NSUserDefaults standardUserDefaults] integerForKey:kMusicType];
    AudioSessionAddPropertyListener(kAudioSessionProperty_CurrentHardwareOutputVolume,
                                    audioVolumeChange, NULL);
}

- (void)playSoundWithSoundName:(NSString *)soundName {
    
    if (self.soundType == SoundPlayTypeMute) return;
    
    if (![self currentVolumn]) return;
    
    [self loadSounds];
    
    SystemSoundID soundID = [self.soundIDs[soundName] unsignedIntValue];
    
    AudioServicesPlaySystemSound(soundID);
}

#pragma mark -
#pragma mark 私有方法

- (float)volumeOfSoundPlayType:(SoundPlayType)type {
    float volume;
    
    switch (type) {
        case SoundPlayTypeMuteHight:
            volume = 1.0;
            break;
        case SoundPlayTypeMiddle:
            volume= 0.65;
            break;
        case SoundPlayTypeLow:
            volume = 0.35;
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
        [[WXNSoundToolManager sharedSoundToolManager] playBgMusicWihtPlayAgain:YES];
    } else {
        [[WXNSoundToolManager sharedSoundToolManager] pauseBgMusic];
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
    AudioSessionSetProperty(kAudioSessionProperty_AudioInputAvailable,
                            sizeof(float),
                            &volumn);
}

#pragma clang diagnostic pop

@end
