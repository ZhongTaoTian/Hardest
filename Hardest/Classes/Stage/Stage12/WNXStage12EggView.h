//
//  WNXStage12EggView.h
//  Hardest
//
//  Created by MacBook on 16/5/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXStage12EggView : UIView

@property (nonatomic, copy) void (^failBlocl)(int index);

- (void)showEggWithIndex:(int)index;

@end
