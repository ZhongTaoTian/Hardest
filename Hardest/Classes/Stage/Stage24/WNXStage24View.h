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

- (void)startAppearCockroach;

- (BOOL)hitCockroachWithIndex:(NSInteger)index;

@end
