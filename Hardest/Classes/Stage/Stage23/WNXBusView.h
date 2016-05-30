//
//  WNXBusView.h
//  Hardest
//
//  Created by sfbest on 16/5/27.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXBusView : UIView

@property (nonatomic, copy) void (^busPassFinish)();
@property (nonatomic, copy) void (^guessSucess)();
@property (nonatomic, copy) void (^stopCountTime)();

//- (void)showBusWithFinish:(void(^)())finish;

- (void)showBus;

- (BOOL)guessWithIndex:(NSInteger)index;

- (void)showCorrectBus;

- (void)pause;
- (void)resume;
- (void)removeData;

@end
