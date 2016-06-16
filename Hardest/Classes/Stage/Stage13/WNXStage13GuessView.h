//
//  WNXStage13GuessView.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/5.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WNXStage13GuessType) {
    WNXStage13GuessTypeMan = 0,
    WNXStage13GuessTypeChild,
    WNXStage13GuessTypeOld
};

@interface WNXStage13GuessView : UIView

@property (nonatomic, copy) void (^startCountTime)();
@property (nonatomic, copy) void (^timeOut)();
@property (nonatomic, copy) void (^nextCountWithError)();
@property (nonatomic, copy) void (^nextCountWithSucess)(BOOL isPass);

- (void)startGuess;

- (BOOL)guessPeopleWithGuessType:(WNXStage13GuessType)type;

- (void)showFailWithIsShowPeople:(BOOL)showPeople AnimationFinish:(void (^)(void))finish;

- (void)stopAnimationWithTimeOver;

- (void)stopAnimationWithFinish:(void (^)())finish;

- (void)pause;
- (void)resume;
- (void)cleanData;

@end
