//
//  WNXCountDownLabel.h
//  Hardest
//
//  Created by sfbest on 16/3/4.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXCountDownLabel : UILabel

- (instancetype)initWithFrame:(CGRect)frame startTime:(double)time textSize:(CGFloat)size;

- (void)startCountDownWithCompletion:(void (^)(void))completion;

@end
