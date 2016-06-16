//
//  WNXDiceView.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/23.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXDiceView : UIView

@property (nonatomic, copy) void (^shakeDiceFinish)();

- (void)startShakeDiceWithFirstDiceNumber:(int)number1 secoundDiceNumber:(int)number2 thridDiceNumber:(int)number3 shakeDuration:(NSInteger)duration;

- (void)pause;
- (void)resume;

- (void)removeData;

@end
