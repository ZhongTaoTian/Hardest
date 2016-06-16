//
//  WNXBreakGlassView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/4/9.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXBreakGlassView.h"

@interface WNXBreakGlassView ()

@property (weak, nonatomic) IBOutlet UIImageView *bottomIV;
@property (weak, nonatomic) IBOutlet UIImageView *topIV;
@property (weak, nonatomic) IBOutlet UIImageView *lightIV;

@end

@implementation WNXBreakGlassView

- (void)showBreakGlass {
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomIV.alpha = 0;
        self.topIV.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
