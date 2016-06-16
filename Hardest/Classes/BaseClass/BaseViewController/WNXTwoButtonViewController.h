//
//  WNXTwoButtonViewController.h
//  Hardest
//
//  Created by MacBook on 16/3/27.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXBaseGameViewController.h"

@interface WNXTwoButtonViewController : WNXBaseGameViewController

@property (nonatomic, strong) UIImageView *backgroundIV;

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

- (void)setButtonActivate:(BOOL)isActivate;

@end
