//
//  WNXStage18PokerView.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/18.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import <UIKit/UIKit.h>

@interface WNXStage18PokerView : UIView

@property (nonatomic, copy) void (^startCountTime)();
@property (nonatomic, copy) void (^showNextPoker)();
@property (nonatomic, copy) void (^selectSamePokerSucess)(BOOL isPass);

@property (nonatomic, assign) BOOL isFail;

- (BOOL)showPokerView;

- (BOOL)selectSamePokerWithIndex:(NSInteger)index;

- (void)resumeData;

@end
