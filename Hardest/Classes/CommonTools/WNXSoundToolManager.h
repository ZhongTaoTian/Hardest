//
//  WXNSoundToolsManger.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/2/25.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoundNamesHeader.h"

typedef NS_ENUM(NSInteger, SoundPlayType) {
    SoundPlayTypeHight = 0,
    SoundPlayTypeMiddle,
    SoundPlayTypeLow,
    SoundPlayTypeMute
};

@interface WNXSoundToolManager : NSObject

@property (nonatomic, assign) SoundPlayType bgMusicType;
@property (nonatomic, assign) SoundPlayType soundType;

- (void)pauseBgMusic;
- (void)stopBgMusic;
- (void)playBgMusicWihtPlayAgain:(BOOL)playAgain;

- (void)playSoundWithSoundName:(NSString *)soundName;

- (void)setBackgroundMusicVolume:(float)volume;

+ (instancetype)sharedSoundToolManager;

@end
