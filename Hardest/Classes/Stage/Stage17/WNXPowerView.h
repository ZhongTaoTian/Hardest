//
//  WNXPowerView.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/16.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXPowerView : UIView

@property (nonatomic, copy) void(^failBlock)();

- (void)startWithCount:(int)count;
- (int)stopCount;

- (void)pause;
- (void)resume;

- (void)resumeData;

@end
