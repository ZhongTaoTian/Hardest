//
//  WNXStage18PokerView.h
//  Hardest
//
//  Created by sfbest on 16/5/18.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXStage18PokerView : UIView

@property (nonatomic, copy) void (^startCountTime)();
@property (nonatomic, copy) void (^showNextPoker)();
@property (nonatomic, copy) void (^selectSamePokerSucess)();

@property (nonatomic, assign) BOOL isFail;

- (BOOL)showPokerView;

- (BOOL)selectSamePokerWithIndex:(NSInteger)index;

@end
