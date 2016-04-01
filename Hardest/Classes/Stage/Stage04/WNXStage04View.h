//
//  WNXStage04View.h
//  Hardest
//
//  Created by sfbest on 16/3/31.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXStage04View : UIView

@property (nonatomic, copy) void(^stopTime)(int count);
@property (nonatomic, copy) void(^showResult)();
@property (nonatomic, copy) void(^stopAnimationDidFinish)();
@property (nonatomic, copy) void(^passStage)();

- (void)start;

- (void)runLeft;
- (void)runRight;

@end
