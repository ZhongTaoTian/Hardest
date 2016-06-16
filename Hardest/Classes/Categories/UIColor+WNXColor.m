//
//  UIColor+WNXColor.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/4/7.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "UIColor+WNXColor.h"

@implementation UIColor (WNXColor)

+ (instancetype)colorWithR:(int)red g:(int)green b:(int)blue {
    UIColor *color = [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1];
    return color;
}

+ (instancetype)random {
    return [UIColor colorWithR:arc4random_uniform(256) g:arc4random_uniform(256) b:arc4random_uniform(256)];
}

@end
