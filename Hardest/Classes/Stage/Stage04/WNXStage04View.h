//
//  WNXStage04View.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/31.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import <UIKit/UIKit.h>

@interface WNXStage04View : UIView

@property (nonatomic, copy) void(^stopTime)(int count);
@property (nonatomic, copy) void(^showResult)();
@property (nonatomic, copy) void(^stopAnimationDidFinish)();
@property (nonatomic, copy) void(^passStage)();
@property (nonatomic, copy) void(^failBlock)();
@property (nonatomic, copy) void(^btnToFront)();
@property (nonatomic, weak) UIImageView *bgIV;

- (void)start;

- (void)runLeft;
- (void)runRight;

- (void)playAgain;

@end
