//
//  WXNSoundToolsManger.h
//  Hardest
//
//  Created by sfbest on 16/2/25.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoundNamesHeader.h"

typedef NS_ENUM(NSInteger, SoundPlayType) {
    SoundPlayTypeMuteHight = 0,
    SoundPlayTypeLow,
    SoundPlayTypeMiddle,
    SoundPlayTypeMute
};

@interface WNXSoundToolManager : NSObject

@property (nonatomic, assign) SoundPlayType bgMusicType;
@property (nonatomic, assign) SoundPlayType soundType;

- (void)pauseBgMusic;
- (void)stopBgMusic;
- (void)playBgMusicWihtPlayAgain:(BOOL)playAgain;

- (void)playSoundWithSoundName:(NSString *)soundName;

+ (instancetype)sharedSoundToolManager;

@end
