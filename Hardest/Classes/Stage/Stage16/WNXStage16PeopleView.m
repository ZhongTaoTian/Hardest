//
//  WNXStage16PeopleView.m
//  Hardest
//
//  Created by MacBook on 16/5/15.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage16PeopleView.h"

@interface WNXStage16PeopleView ()

@property (weak, nonatomic) IBOutlet UIImageView *upIV;
@property (weak, nonatomic) IBOutlet UIImageView *downIV;


@end

@implementation WNXStage16PeopleView

- (void)ullUpsWithIndex:(NSInteger)index {
    if (index == 1) {
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundManDownName];
        self.upIV.hidden = YES;
        self.downIV.hidden = NO;
    } else {
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundManUpName];
        self.upIV.hidden = NO;
        self.downIV.hidden = YES;
    }
}

- (void)resumeData {
    self.upIV.hidden = NO;
    self.downIV.hidden = YES;
}

@end
