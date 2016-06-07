//
//  WNXCockroachView.h
//  Hardest
//
//  Created by sfbest on 16/6/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXCockroachView : UIView

@property (nonatomic, copy) void (^startCountTime)();
@property (nonatomic, copy) void (^showHitFinish)();

@property (nonatomic, assign) BOOL failed;

- (void)shake;
- (void)stopShake;

- (void)cockroachRunWithFail:(void (^)())finish;

- (BOOL)hitCockroach;

- (void)stopMove;
- (void)removeData;

@end
