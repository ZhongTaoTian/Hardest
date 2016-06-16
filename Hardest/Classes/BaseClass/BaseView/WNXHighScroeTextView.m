//
//  WNXHighScroeTextImageView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/17.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXHighScroeTextView.h"

@interface WNXHighScroeTextView ()
{
    BOOL _isRecur;
}

@property (nonatomic, strong) UIImageView *highScroeIV1;
@property (nonatomic, strong) UIImageView *highScroeIV2;
@property (nonatomic, strong) UIImageView *highScroeIV3;
@property (nonatomic, strong) UIImageView *highScroeIV4;

@end

@implementation WNXHighScroeTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.highScroeIV1 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth, (frame.size.height - 54) * 0.5, 320, 54)];
        self.highScroeIV1.image = [UIImage imageNamed:@"high_score"];
        self.alpha = 0.8;
        [self addSubview:self.highScroeIV1];
        
        self.highScroeIV2 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth, (frame.size.height - 54) * 0.5, 320, 54)];
        self.highScroeIV2.image = [UIImage imageNamed:@"high_score"];
        self.alpha = 0.8;
        [self addSubview:self.highScroeIV2];
        
        self.highScroeIV3 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth, (frame.size.height - 120) * 0.5, 712, 120)];
        self.highScroeIV3.image = [UIImage imageNamed:@"high_score"];
        self.highScroeIV3.alpha = 0.4;
        [self addSubview:self.highScroeIV3];

        self.highScroeIV4 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth, (frame.size.height - 120) * 0.5, 712, 120)];
        self.highScroeIV4.image = [UIImage imageNamed:@"high_score"];
        self.highScroeIV4.alpha = 0.4;
        [self addSubview:self.highScroeIV4];
        
        self.hidden = YES;
        _isRecur = YES;
    }
    
    return self;
}

- (void)showHighScroeTextView {
    self.hidden = NO;
    
    [self imageView1Animation];
    [self imageView3Animation];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self imageView2Animation];
        [self imageView4Animation];
    });
}

- (void)imageView1Animation {
    self.highScroeIV1.transform = CGAffineTransformIdentity;
    if (_isRecur) {
        [UIView animateWithDuration:6 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.highScroeIV1.transform = CGAffineTransformMakeTranslation(-712 * 2, 0);
        } completion:^(BOOL finished) {
            [self imageView1Animation];
        }];
    }
}

- (void)imageView2Animation {
    self.highScroeIV2.transform = CGAffineTransformIdentity;
    if (_isRecur) {
        [UIView animateWithDuration:6 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.highScroeIV2.transform = CGAffineTransformMakeTranslation(-712 * 2, 0);
        } completion:^(BOOL finished) {
            [self imageView2Animation];
        }];
    }
}


- (void)imageView3Animation {
    self.highScroeIV3.transform = CGAffineTransformIdentity;
    if (_isRecur) {
        [UIView animateWithDuration:6 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.highScroeIV3.transform = CGAffineTransformMakeTranslation(-712 * 2, 0);
        } completion:^(BOOL finished) {
            [self imageView3Animation];
        }];
    }
}

- (void)imageView4Animation {
    self.highScroeIV4.transform = CGAffineTransformIdentity;
    if (_isRecur) {
        [UIView animateWithDuration:6 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.highScroeIV4.transform = CGAffineTransformMakeTranslation(-712 * 2, 0);
        } completion:^(BOOL finished) {
            [self imageView4Animation];
        }];
    }
}

- (void)hideHighScroeTextView {
    _isRecur = NO;
    self.hidden = YES;
}

@end
