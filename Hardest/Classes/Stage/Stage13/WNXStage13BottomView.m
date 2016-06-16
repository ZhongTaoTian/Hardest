//
//  WNXStage13BottomView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/4.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage13BottomView.h"

@interface WNXStage13BottomView ()

@property (nonatomic, strong) UIImageView *leftIV;
@property (nonatomic, strong) UIImageView *middleIV;
@property (nonatomic, strong) UIImageView *rightIV;

@property (nonatomic, strong) UIImageView *manIV;
@property (nonatomic, strong) UIImageView *childIV;
@property (nonatomic, strong) UIImageView *oldIV;

@end

@implementation WNXStage13BottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = NO;
        
        self.leftIV = [[UIImageView alloc] init];
        [self addSubview:self.leftIV];
        
        self.middleIV = [[UIImageView alloc] init];
        [self addSubview:self.middleIV];
        
        self.rightIV = [[UIImageView alloc] init];
        [self addSubview:self.rightIV];
        
        self.manIV = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth / 3 - 90) * 0.5, -94, 90, 94)];
        self.manIV.image = [UIImage imageNamed:@"11_Rbt-iphone4"];
        self.manIV.hidden = YES;
        self.manIV.transform = CGAffineTransformMakeScale(0, 0);
        [self addSubview:self.manIV];
        
        self.childIV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth / 3 + (ScreenWidth / 3 - 90) * 0.5, -94, 90, 94)];
        self.childIV.image = [UIImage imageNamed:@"11_Ybt-iphone4"];
        self.childIV.hidden = YES;
        self.childIV.transform = CGAffineTransformMakeScale(0, 0);
        [self addSubview:self.childIV];
        
        self.oldIV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth / 3 * 2 + (ScreenWidth / 3 - 90) * 0.5, -94, 90, 94)];
        self.oldIV.image = [UIImage imageNamed:@"11_Bbt-iphone4"];
        self.oldIV.hidden = YES;
        self.oldIV.transform = CGAffineTransformMakeScale(0, 0);
        [self addSubview:self.oldIV];
    }
    
    return self;
}

- (void)changeBottomImageViewWihtIndex:(NSInteger)index type:(WNXStage13BottomType)type {
    if (type == WNXStage13BottomTypeNone) {
        if (index == 0) {
            self.leftIV.image = nil;
        } else if (index == 1) {
            self.middleIV.image = nil;
        } else {
            self.rightIV.image = nil;
        }
    } else if (type == WNXStage13BottomTypePeople) {
        if (index == 0) {
            self.leftIV.image = [UIImage imageNamed:@"11_Rbt_icon-iphone4"];
            self.leftIV.frame = CGRectMake(8, 9, self.frame.size.width / 3 - 16, self.frame.size.height - 18);
        } else if (index == 1) {
            self.middleIV.image = [UIImage imageNamed:@"11_Ybt_icon-iphone4"];
            self.middleIV.frame = CGRectMake(ScreenWidth / 3 + 8, 9, self.frame.size.width / 3 - 16, self.frame.size.height - 18);
        } else {
            self.rightIV.image = [UIImage imageNamed:@"11_Bbt_icon-iphone4"];
            self.rightIV.frame = CGRectMake(ScreenWidth / 3 * 2 + 8, 9, self.frame.size.width / 3 - 16, self.frame.size.height - 18);
        }
    } else if (type == WNXStage13BottomTypeTick) {
        if (index == 0) {
            self.leftIV.image = [UIImage imageNamed:@"11_tick-iphone4"];
            self.leftIV.frame = CGRectMake(20, 30, ScreenWidth / 3 - 40, self.frame.size.height - 60);
        } else if (index == 1) {
            self.middleIV.image = [UIImage imageNamed:@"11_tick-iphone4"];
            self.middleIV.frame = CGRectMake(20 + ScreenWidth / 3, 30, ScreenWidth / 3 - 40, self.frame.size.height - 60);
        } else {
            self.rightIV.image = [UIImage imageNamed:@"11_tick-iphone4"];
            self.rightIV.frame = CGRectMake(20 + ScreenWidth / 3 * 2, 30, ScreenWidth / 3 - 40, self.frame.size.height - 60);
        }
    }
}

- (void)showPeopleImageViewWithIndex:(NSInteger)index {
    if (index == 0) {
        self.manIV.transform = CGAffineTransformMakeScale(0, 0);
        self.manIV.hidden = NO;
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.manIV.transform = CGAffineTransformIdentity;
        } completion:nil];
    } else if (index == 1) {
        self.childIV.transform = CGAffineTransformMakeScale(0, 0);
        self.childIV.hidden = NO;
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.childIV.transform = CGAffineTransformIdentity;
        } completion:nil];
    } else {
        self.oldIV.transform = CGAffineTransformMakeScale(0, 0);
        self.oldIV.hidden = NO;
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.oldIV.transform = CGAffineTransformIdentity;
        } completion:nil];
    }
}

- (void)hidePeopleImageViewWithIndex:(NSInteger)index {
    if (index == 0) {
        self.manIV.hidden = YES;
    } else if (index == 1) {
        self.childIV.hidden = YES;
    } else {
        self.oldIV.hidden = YES;
    }
}

- (void)cleanData {
    [self changeBottomImageViewWihtIndex:0 type:WNXStage13BottomTypePeople];
    [self changeBottomImageViewWihtIndex:1 type:WNXStage13BottomTypePeople];
    [self changeBottomImageViewWihtIndex:2 type:WNXStage13BottomTypePeople];
    
    self.manIV.hidden = YES;
    self.childIV.hidden = YES;
    self.oldIV.hidden = YES;
}

@end
