//
//  WNXStage24View.h
//  Hardest
//
//  Created by sfbest on 16/6/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXStage24View : UIView

@property (nonatomic, copy) void (^startCountTime)(BOOL isFrist);
@property (nonatomic, copy) void (^finish)();
@property (nonatomic, copy) void (^fail)();

- (void)startAppearCockroach;
- (void)showNextVovkroach;

- (BOOL)hitCockroachWithIndex:(NSInteger)index;

- (void)removeFromSuperview;

@end
