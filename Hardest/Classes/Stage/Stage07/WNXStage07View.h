//
//  WNXStage07View.h
//  Hardest
//
//  Created by sfbest on 16/4/9.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXStage07View : UIView

@property (nonatomic, copy) void(^sucessBlock)(int glassCount);
@property (nonatomic, copy) void(^failBlock)();

- (void)start;

- (void)hitGlass;

@end
