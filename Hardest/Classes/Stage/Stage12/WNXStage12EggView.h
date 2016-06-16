//
//  WNXStage12EggView.h
//  Hardest
//
//  Created by MacBook on 16/5/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import <UIKit/UIKit.h>

@interface WNXStage12EggView : UIView

@property (nonatomic, copy) void (^failBlock)(NSInteger index);
@property (nonatomic, copy) void (^nextDropEggBlock)();
@property (nonatomic, copy) void (^passStageBlock)();

@property (nonatomic, weak) UIButton *redButton;
@property (nonatomic, weak) UIButton *yellowButton;
@property (nonatomic, weak) UIButton *blueButton;


- (void)showEgg;
- (void)pause;
- (void)resume;

- (void)failWithIndex:(NSInteger)index;

- (NSInteger)grabWithIndex:(NSInteger)index;

- (void)cleanData;

@end
