//
//  WNXStage23PeopleView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/27.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage23PeopleView.h"

@interface WNXStage23PeopleView ()

@property (nonatomic, strong) UIImageView *leftIV;
@property (nonatomic, strong) UIImageView *middleIV;
@property (nonatomic, strong) UIImageView *rightIV;

@end

@implementation WNXStage23PeopleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        
        self.leftIV = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth / 3 - 88) * 0.5, 0, 88, 90)];
        self.leftIV.image = [UIImage imageNamed:@"12_Bboy-iphone4"];
        [self addSubview:self.leftIV];
        
        self.middleIV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth / 3 + (ScreenWidth / 3 - 88) * 0.5, 0, 88, 90)];
        self.middleIV.image = [UIImage imageNamed:@"12_Rgirl-iphone4"];
        [self addSubview:self.middleIV];
        
        self.rightIV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth / 3 * 2 + (ScreenWidth / 3 - 88) * 0.5, 0, 88, 90)];
        self.rightIV.image = [UIImage imageNamed:@"12_Yboy-iphone4"];
        [self addSubview:self.rightIV];
    }
    
    return self;
}

- (void)clickIndex:(NSInteger)index {
    if (index == 0) {
        
        [UIView animateWithDuration:0.15 animations:^{
            self.leftIV.transform = CGAffineTransformMakeScale(1.3, 1.3);
        } completion:^(BOOL finished) {
            self.leftIV.transform = CGAffineTransformIdentity;
        }];
        
    } else if (index == 1) {
        
        [UIView animateWithDuration:0.15 animations:^{
            self.middleIV.transform = CGAffineTransformMakeScale(1.3, 1.3);
        } completion:^(BOOL finished) {
            self.middleIV.transform = CGAffineTransformIdentity;
        }];
        
    } else {
    
        [UIView animateWithDuration:0.15 animations:^{
            self.rightIV.transform = CGAffineTransformMakeScale(1.3, 1.3);
        } completion:^(BOOL finished) {
            self.rightIV.transform = CGAffineTransformIdentity;
        }];
        
    }
}

@end
