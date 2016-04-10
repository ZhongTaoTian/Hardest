//
//  WNXStage07View.h
//  Hardest
//
//  Created by sfbest on 16/4/9.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXStage07View : UIView

@property (nonatomic, copy) void(^sucessBlock)(int glassCount, BOOL isPass);
@property (nonatomic, copy) void(^failBlock)();
@property (nonatomic, copy) void (^stopTimeBlock)();


- (void)start;

- (void)hitGlass;

- (void)cleadData;

@end
