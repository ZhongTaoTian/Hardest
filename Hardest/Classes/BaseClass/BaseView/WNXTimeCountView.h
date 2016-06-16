//
//  WNXTimeCountView.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/28.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXTimeCountView : UIView

- (void)startAnimationWithCompletion:(void (^)(BOOL finished))completion;

- (void)startCalculateTime;
- (NSTimeInterval)stopCalculateTime;
- (NSTimeInterval)pasueTime;

- (void)pause;
- (void)resumed;

- (void)cleadData;

@end
