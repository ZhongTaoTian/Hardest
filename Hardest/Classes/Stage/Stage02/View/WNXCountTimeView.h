//
//  WNXCountTimeView.h
//  Hardest
//
//  Created by sfbest on 16/3/21.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXCountTimeView : UIView

@property (nonatomic, copy) void(^TimeOutBlock)(void);

- (void)startAnimationWithCompletion:(void (^)(BOOL))completion;

- (void)startCalculateByTimeWithTimeOut:(void(^)())timeOutBlock;

- (void)stopCalculateByTimeWithTimeBlock:(void(^)(int second, int ms))timeBlock;

- (void)cleanData;

@end
