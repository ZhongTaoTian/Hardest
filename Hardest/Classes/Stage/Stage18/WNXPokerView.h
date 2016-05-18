//
//  WNXPokerView.h
//  Hardest
//
//  Created by sfbest on 16/5/17.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

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
