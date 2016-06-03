//
//  WNXCockroachView.m
//  Hardest
//
//  Created by sfbest on 16/6/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXCockroachView.h"

@interface WNXCockroachView ()
{
    int _shakeIndex;
}

@property (nonatomic, copy) void (^fail)();
@property (weak, nonatomic) IBOutlet UIImageView *cockroachIV;

@property (nonatomic, strong) CADisplayLink *shakeTime;
@property (nonatomic, strong) CADisplayLink *moveTime;

@end

@implementation WNXCockroachView

- (void)awakeFromNib {
    self.cockroachIV.animationImages = @[[UIImage imageNamed:@"stage27_run01-iphone4"], [UIImage imageNamed:@"stage27_run02-iphone4"]];
    self.cockroachIV.animationDuration = 0.2;
    self.cockroachIV.animationRepeatCount = 100000;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTimer) name:kNotificationNameGameViewControllerDelloc object:nil];
}

- (void)removeTimer {
    [self.shakeTime invalidate];
    self.shakeTime = nil;
    
    [self.moveTime invalidate];
    self.moveTime = nil;
}

- (void)dealloc {
    [self removeTimer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)stopShake {
    [self.shakeTime invalidate];
    self.shakeTime = nil;
}

- (void)shake {
    if (self.shakeTime) {
        [self.shakeTime invalidate];
        self.shakeTime = nil;
    }
    
    [self shakeAnimation];
    
    self.shakeTime = [CADisplayLink displayLinkWithTarget:self selector:@selector(shakeTimeUpdate)];
    [self.shakeTime addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)shakeAnimation {
//    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
//    anim.values = @[@1, @(0.85), @1, @(1.15), @1];
//    anim.duration = 0.5;
//    anim.repeatCount = 1;
    
    CAKeyframeAnimation *rota = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rota.values = @[@0, @(M_PI_4 / 6), @(0), @(-M_PI_4 / 6), @0, @(M_PI_4 / 6), @0];
    rota.duration = 0.5;
    rota.repeatCount = 1;

//    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
//    group.animations = @[anim, rota];
    
    [self.cockroachIV.layer addAnimation:rota forKey:nil];
}

- (void)shakeTimeUpdate {
    _shakeIndex++;
    if (_shakeIndex == 60) {
        _shakeIndex = 0;
        [self shakeAnimation];
    }
}

- (void)cockroachRunWithFail:(id)finish {
    if (self.shakeTime) {
        [self.shakeTime invalidate];
    }
    
    [self.cockroachIV startAnimating];
    
    if (self.moveTime) {
        [self.moveTime invalidate];
    }
    
    self.moveTime = [CADisplayLink displayLinkWithTarget:self selector:@selector(moveTimeUpdate)];
    [self.moveTime addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)moveTimeUpdate {
    self.cockroachIV.transform = CGAffineTransformTranslate(self.cockroachIV.transform, 0, -1);
    if (self.cockroachIV.transform.ty < 510) {
        [self.moveTime invalidate];
        self.moveTime = nil;
        
        
    }
}

@end
