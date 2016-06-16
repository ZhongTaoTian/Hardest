//
//  WNXSettingViewController.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/2/26.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXSettingViewController.h"

@interface WNXSettingViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMargin;
@property (weak, nonatomic) IBOutlet UIButton *bgMusicButton;
@property (weak, nonatomic) IBOutlet UIButton *soundButton;
@property (weak, nonatomic) IBOutlet UIButton *other1Button;
@property (weak, nonatomic) IBOutlet UIButton *other2Button;
@property (weak, nonatomic) IBOutlet UIButton *other3Button;

@end

@implementation WNXSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundImageWihtImageName:@"setting_bg"];
    
    [self startSetTopMargin];
    
    [self setButtonsTitle];
}

- (void)setButtonsTitle {
    
    [self.bgMusicButton setTitle:[NSString stringWithFormat:@"MUSIC %@", [self buttonTitleWihtSoundPlayType:[[WNXSoundToolManager sharedSoundToolManager] bgMusicType]]] forState:UIControlStateNormal];
    [self.soundButton setTitle:[NSString stringWithFormat:@"SOUND %@", [self buttonTitleWihtSoundPlayType:[[WNXSoundToolManager sharedSoundToolManager] soundType]]] forState:UIControlStateNormal];
}

- (void)startSetTopMargin {
    if (iPhone5) {
        self.topMargin.constant = 120;
    } else {
        self.topMargin.constant = 120 - ScreenHeightDifference - 10;
    }
    
    [self.view setNeedsLayout];
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    if (sender.tag == 10) {
        NSString *subTitle = [self nextButtonTitleWihtSoundPlayType:[[WNXSoundToolManager sharedSoundToolManager] bgMusicType]];
        [sender setTitle:[NSString stringWithFormat:@"MUSIC %@", subTitle] forState:UIControlStateNormal];
        [[WNXSoundToolManager sharedSoundToolManager] setBgMusicType:[self typeWihtSoundPlayType:[[WNXSoundToolManager sharedSoundToolManager] bgMusicType]]];
    } else if (sender.tag == 11) {
        NSString *subTitle = [self nextButtonTitleWihtSoundPlayType:[[WNXSoundToolManager sharedSoundToolManager] soundType]];
        [sender setTitle:[NSString stringWithFormat:@"SOUND %@", subTitle] forState:UIControlStateNormal];
        [[WNXSoundToolManager sharedSoundToolManager] setSoundType:[self typeWihtSoundPlayType:[[WNXSoundToolManager sharedSoundToolManager] soundType]]];
    }
    
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundCliclName];
}


- (NSString *)nextButtonTitleWihtSoundPlayType:(SoundPlayType)type {
    
    if (type == 0) {
        return @"[MED]";
    } else if (type == 1) {
        return @"[LOW]";
    } else if (type == 2) {
        return @"[OFF]";
    } else {
        return @"[HIGH]";
    }
}

- (NSString *)buttonTitleWihtSoundPlayType:(SoundPlayType)type {
    if (type == 0) {
        return @"[HIGH]";
    } else if (type == 1) {
        return @"[MED]";
    } else if (type == 2) {
        return @"[LOW]";
    } else {
        return @"[OFF]";
    }
}

- (SoundPlayType)typeWihtSoundPlayType:(SoundPlayType)type {
    if (type == SoundPlayTypeHight) {
        return SoundPlayTypeMiddle;
    } else if (type == SoundPlayTypeMiddle) {
        return SoundPlayTypeLow;
    } else if (type == SoundPlayTypeLow) {
        return SoundPlayTypeMute;
    } else {
        return SoundPlayTypeHight;
    }
}

@end
