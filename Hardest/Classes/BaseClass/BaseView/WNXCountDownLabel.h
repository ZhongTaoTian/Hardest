//
//  WNXCountDownLabel.h
//  Hardest
//
//  Created by sfbest on 16/3/4.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNXStrokeLabel.h"

@interface WNXCountDownLabel : WNXStrokeLabel

- (instancetype)initWithFrame:(CGRect)frame startTime:(double)time textSize:(CGFloat)size;

- (void)startCountDownWithCompletion:(void (^)(void))completion;
- (void)pause;
- (void)continueWork;
- (void)clean;
- (void)setTextColor:(UIColor *)textColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;;

@end
