//
//  WNXStage20DiceView.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/23.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXStage20DiceView : UIView

@property (nonatomic, copy) void (^shakeDiceFinsih)();

- (int)startShakeDice;

- (void)pause;
- (void)resume;

- (void)removeData;

@end
