//
//  WNXReadyGoView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//
//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXReadyGoView.h"

@interface WNXReadyGoView ()

@property (nonatomic, strong) UIImageView *readyView;
@property (nonatomic, strong) UIImage *readyImage;
@property (nonatomic, strong) UIImage *goImage;

@end

@implementation WNXReadyGoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.readyView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 250) * 0.5, 0, 250, 95)];
        self.readyImage = [UIImage imageNamed:@"ready"];
        self.goImage = [UIImage imageNamed:@"go"];
        self.readyView.image = self.readyImage;
        [self addSubview:self.readyView];
    }
    
    return self;
}

+ (void)showReadyGoViewWithSuperView:(UIView *)superView completion:(void (^)(void))completion {
    CGFloat startY = 200;
    if (!iPhone5) {
        startY = 150;
    }
    WNXReadyGoView *readyGoView = [[WNXReadyGoView alloc] initWithFrame:CGRectMake(ScreenWidth, startY, ScreenWidth, 95)];
    [superView addSubview:readyGoView];
    [superView bringSubviewToFront:readyGoView];
    
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundReadyGoName];
    
    [UIView animateWithDuration:0.3 animations:^{
        readyGoView.frame = CGRectMake(0, startY, ScreenWidth, 95);
        
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            readyGoView.readyView.image = readyGoView.goImage;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [UIView animateWithDuration:0.3 animations:^{
                    readyGoView.frame = CGRectMake(-ScreenWidth, startY, ScreenWidth, 95);
                } completion:^(BOOL finished) {
                    
                    if (completion) {
                        completion();
                    }
                    [readyGoView removeFromSuperview];
                }];
            });
        });
    
    }];
    
}

@end
