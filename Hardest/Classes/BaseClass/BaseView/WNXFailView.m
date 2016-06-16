//
//  WNXFailView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/22.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXFailView.h"

@interface WNXFailView ()

@property (weak, nonatomic) IBOutlet UIImageView *redBgView;
@property (weak, nonatomic) IBOutlet UIImageView *shadowView;
@property (weak, nonatomic) IBOutlet UIImageView *peopleView;
@property (weak, nonatomic) IBOutlet UIImageView *outView;

@end

@implementation WNXFailView

- (void)awakeFromNib {
    self.redBgView.transform = CGAffineTransformMakeTranslation(ScreenWidth, 0);
    self.shadowView.transform = CGAffineTransformMakeTranslation(ScreenWidth, 0);
    self.peopleView.transform = CGAffineTransformMakeTranslation(ScreenWidth, 0);
    self.outView.transform = CGAffineTransformMakeTranslation(ScreenWidth, 0);
}

- (void)showFailViewWithAnimatonFinishBlock:(void (^)())completion {
    
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundOutSpoonName];
    [UIView animateWithDuration:0.15 animations:^{
        self.redBgView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.peopleView.transform = CGAffineTransformIdentity;
            self.shadowView.transform = CGAffineTransformIdentity;
            self.outView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundOutName];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.25 animations:^{
                    self.peopleView.transform = CGAffineTransformMakeTranslation(-ScreenWidth - 50, 0);
                    self.shadowView.transform = CGAffineTransformMakeTranslation(-ScreenWidth - 50, 0);
                    self.outView.transform = CGAffineTransformMakeTranslation(-ScreenWidth, 0);
                } completion:^(BOOL finished) {
                    completion();
                }];
            });
        }];
    }];
}

@end
