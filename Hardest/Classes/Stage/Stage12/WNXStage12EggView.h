//
//  WNXStage12EggView.h
//  Hardest
//
//  Created by MacBook on 16/5/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXStage12EggView : UIView

@property (nonatomic, copy) void (^failBlock)(NSInteger index);
@property (nonatomic, copy) void (^nextDropEggBlock)();
@property (nonatomic, copy) void (^passStageBlock)();

@property (nonatomic, weak) UIButton *redButton;
@property (nonatomic, weak) UIButton *yellowButton;
@property (nonatomic, weak) UIButton *blueButton;


- (void)showEgg;
- (void)pause;
- (void)resume;

- (void)failWithIndex:(NSInteger)index;

- (NSInteger)grabWithIndex:(NSInteger)index;

- (void)cleanData;

@end
