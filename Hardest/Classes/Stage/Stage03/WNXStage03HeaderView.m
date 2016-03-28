//
//  WNXStage03HeaderView.m
//  Hardest
//
//  Created by MacBook on 16/3/27.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage03HeaderView.h"

@interface WNXStage03HeaderView ()
{
    CGFloat _rotationAngel;
}

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

- (void)start {
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    _rotationAngel = M_PI_4 + M_PI_4 / 4;
    rotation.fromValue = @0;
    rotation.toValue = @(M_PI_4 + M_PI_4 / 4);
    rotation.duration = 3;
    rotation.removedOnCompletion = NO;
    rotation.fillMode=kCAFillModeForwards;
    [self.headerIV.layer addAnimation:rotation forKey:nil];
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
/*
 CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
 scale.fromValue = @0;
 titleLabel.hidden = NO;
 scale.toValue = @1;
 
 CAKeyframeAnimation *translation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
 translation.values = @[@0, @40, @(-20)];
 
 CAAnimationGroup *group = [CAAnimationGroup animation];
 group.duration = 0.3;
 group.animations = @[scale, translation];
 
 [titleLabel.layer addAnimation:group forKey:nil];
 
 [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundPrepaerTitle(i+1)];
 */
/*
 -(void)pauseLayer:(CALayer*)layer
 {
 CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
 layer.speed = 0.0;
 layer.timeOffset = pausedTime;
 }
 
 -(void)resumeLayer:(CALayer*)layer
 {
 CFTimeInterval pausedTime = [layer timeOffset];
 layer.speed = 1.0;
 layer.timeOffset = 0.0;
 layer.beginTime = 0.0;
 CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
 layer.beginTime = timeSincePause;
 }
 */

@end
