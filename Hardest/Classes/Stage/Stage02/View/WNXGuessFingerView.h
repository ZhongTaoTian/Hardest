//
//  WNXGuessFingerView.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/21.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXGuessFingerView : UIView

@property (nonatomic, copy) void (^animationFinish)(int winIndex);

- (void)startAnimationWithDuration:(NSTimeInterval)duration;

- (void)showResultAnimationCompletion:(void (^)())completion;

- (void)cleanData;

@end
