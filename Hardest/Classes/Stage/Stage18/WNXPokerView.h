//
//  WNXPokerView.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/17.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WNXPokerType) {
    WNXPokerTypeHearts = 0,   // 红桃
    WNXPokerTypeDiamonds = 1, // 方块
    WNXPokerTypeSpade = 2,    // 黑桃
    WNXPokerTypeClubs         // 梅花
};

@interface WNXPokerView : UIView

- (void)setPokerWithType:(WNXPokerType)type number:(int)number;
    
@end
