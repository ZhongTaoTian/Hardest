//
//  WNXStage12BottomView.h
//  Hardest
//
//  Created by MacBook on 16/5/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WNXStage12BottomViewType) {
    WNXStage12BottomViewTypeNormal = 0,
    WNXStage12BottomViewTypeFail,
    WNXStage12BottomViewTypeSucess
};

@interface WNXStage12BottomView : UIView

- (void)changeBottomWihtIndex:(NSInteger)index imageType:(WNXStage12BottomViewType)imageType;

@end
