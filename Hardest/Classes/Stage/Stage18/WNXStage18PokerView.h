//
//  WNXStage18PokerView.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/18.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

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
