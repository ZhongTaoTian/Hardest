//
//  WNXDropEggView.h
//  Hardest
//
//  Created by sfbest on 16/5/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXDropEggView : UIView

@property (nonatomic, copy) void (^failBlock)(NSInteger index);

- (void)showDropEggWithSpeed:(int)speed;

- (void)stopDropEgg;
- (void)pause;
- (void)resume;

- (NSInteger)grabEgg;

- (void)cleanData;

@end
