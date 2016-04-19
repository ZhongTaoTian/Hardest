//
//  WNXStage09BobmView.h
//  Hardest
//
//  Created by sfbest on 16/4/12.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXStage09BobmView : UIView

@property (nonatomic, copy) void (^nextBlock)();
@property (nonatomic, copy) void (^passBlock)(NSTimeInterval score);
@property (nonatomic, copy) void (^failBlock)();

- (void)showBobm;

- (void)stopCountWithIndex:(int)index;

- (void)cleanData;

- (void)pause;

- (void)resume;

@end
