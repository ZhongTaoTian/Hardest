//
//  WNXStage21FractionView.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/24.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXStage21FractionView : UIView

@property (nonatomic, copy) void (^showNumberAnimationFinish)();

- (int)showNumber;

- (void)pause;
- (void)resume;

- (void)removeData;

@end
