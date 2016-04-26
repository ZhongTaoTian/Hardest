//
//  WNXStage10View.h
//  Hardest
//
//  Created by MacBook on 16/4/23.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXStage10View : UIView

@property (nonatomic, copy) void (^AnimationFinishBlock)(BOOL isFrist);
@property (nonatomic, copy) void (^StopCountTimeBlock)();
@property (nonatomic, copy) void (^NextBlock)();
@property (nonatomic, copy) void (^FailBlock)();
@property (nonatomic, copy) void (^PassStageBlock)();

- (void)startRotation;
- (BOOL)clickWithIndex:(int)index;

@end
