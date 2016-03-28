//
//  WNXFeatherView.m
//  Hardest
//
//  Created by sfbest on 16/3/9.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXFeatherView.h"

@interface WNXFeatherView ()
{
    NSTimer *_timer;
}

@end

@implementation WNXFeatherView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.image = [UIImage imageNamed:@"01-btfeather"];
        self.alpha = 0;
    }
    
    return self;
}

- (void)attack:(int)index {
    self.alpha = 1;
    
    [UIView animateWithDuration:0.1 animations:^{
        CGRect frame = self.frame;
        frame.origin.x = (index + 0.3) * [UIScreen mainScreen].bounds.size.width/3;
        self.frame = frame;
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation"];
        CGMutablePathRef path = CGPathCreateMutable();
        CGFloat width = 100;
        CGFloat height = 60;
        CGPathAddEllipseInRect(path, NULL, CGRectMake(-width * 0.5, -height * 0.5, width, height));
        anim.path = path;
        [self.layer addAnimation:anim forKey:nil];
        
        CGPathRelease(path);
    }];
    
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }];
}

@end
