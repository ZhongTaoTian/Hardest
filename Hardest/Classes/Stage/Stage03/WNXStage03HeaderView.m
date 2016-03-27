//
//  WNXStage03HeaderView.m
//  Hardest
//
//  Created by MacBook on 16/3/27.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage03HeaderView.h"

@interface WNXStage03HeaderView ()

@property (nonatomic, strong) UIImageView *headerIV;


@end

@implementation WNXStage03HeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.headerIV = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 200) * 0.5, 20, 200, 200)];
        self.headerIV.image = [UIImage imageNamed:@"23_boyhead-iphone4"];
        self.headerIV.layer.anchorPoint = CGPointMake(0.5, 0.7);
        [self addSubview:self.headerIV];
        
        UIImageView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerIV.frame) - 42, 320, 113)];
        bottomImageView.image = [UIImage imageNamed:@"23_boybody-iphone4"];
        [self insertSubview:bottomImageView belowSubview:self.headerIV];
    }
    
    return self;
}

- (void)test {
    [UIView animateWithDuration:5 animations:^{
        self.headerIV.transform = CGAffineTransformMakeRotation(M_PI_4 + M_PI_4 / 4);
    }];
}

- (void)test1 {
    [UIView animateWithDuration:5 animations:^{
        self.headerIV.transform = CGAffineTransformMakeRotation(-M_PI_4 - M_PI_4 / 4);
    }];
}

@end
