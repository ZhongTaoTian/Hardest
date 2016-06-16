//
//  WNXCountDownLabel.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/4.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//
//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import <UIKit/UIKit.h>
#import "WNXStrokeLabel.h"

@interface WNXCountDownLabel : WNXStrokeLabel

- (instancetype)initWithFrame:(CGRect)frame startTime:(double)time textSize:(CGFloat)size;

- (void)startCountDownWithCompletion:(void (^)(void))completion;
- (void)pause;
- (void)continueWork;
- (void)clean;
- (void)setTextColor:(UIColor *)textColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;;

@end
