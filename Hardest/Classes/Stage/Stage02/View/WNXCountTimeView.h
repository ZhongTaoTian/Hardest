//
//  WNXCountTimeView.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/21.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import <UIKit/UIKit.h>

@interface WNXCountTimeView : UIView

@property (nonatomic, copy) void(^TimeOutBlock)(void);

@property (nonatomic, assign) BOOL notHasTimeOut;

- (void)startAnimationWithCompletion:(void (^)(BOOL))completion;

- (void)startCalculateByTimeWithTimeOut:(void(^)())timeOutBlock outTime:(NSTimeInterval)outTime;
- (void)startCalculateTime;

- (void)stopCalculateByTimeWithTimeBlock:(void(^)(int second, int ms))timeBlock;

- (void)cleanData;

- (void)pause;
- (void)continueGame;

@end
