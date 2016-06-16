//
//  WNXStateView.h
//  Hardest
//
//  Created by MacBook on 16/4/1.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,WNXResultStateType) {
    WNXResultStateTypeOK = 0,
    WNXResultStateTypeGood = 1,
    WNXResultStateTypeGreat = 2,
    WNXResultStateTypePerfect = 3,
    WNXResultStateTypeBad = 4
};

@interface WNXStateView : UIView

@property (nonatomic, assign) WNXResultStateType type;

- (void)showStateViewWithType:(WNXResultStateType)type;
- (void)hideStateView;

- (void)showStateViewWithType:(WNXResultStateType)type stageViewHiddenFinishBlock:(void (^)(void))stageViewHiddenFinishBlock;

- (void)showBadStateWithFinish:(void(^)())finish;

- (void)removeData;

@end
