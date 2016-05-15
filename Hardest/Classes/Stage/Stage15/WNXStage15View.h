//
//  WNXStage15View.h
//  Hardest
//
//  Created by sfbest on 16/5/12.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXStage15View : UIView

@property (nonatomic, copy) void (^buttonActivate)();
@property (nonatomic, copy) void (^passStage)();

- (BOOL)jumpToNextRowWithIndex:(int)index;

@end
