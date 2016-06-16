//
//  WNXCockroachView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/6/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXCockroachView.h"
#import "UIColor+WNXColor.h"

@interface WNXCockroachView ()
{
    int _shakeIndex;
    int _isMove;
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

- (void)cockroachRunWithFail:(void (^)())finish {
    if (self.shakeTime) {
        [self.shakeTime invalidate];
    }
    
    [self.cockroachIV startAnimating];
    
    if (self.moveTime) {
        [self.moveTime invalidate];
    }
    
    self.fail = finish;
    
    if (_failed) {
        return;
    }
    
    self.moveTime = [CADisplayLink displayLinkWithTarget:self selector:@selector(moveTimeUpdate)];
    [self.moveTime addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    _isMove = YES;
    
    if (self.startCountTime) {
        self.startCountTime();
    }
}

- (void)moveTimeUpdate {
    self.cockroachIV.transform = CGAffineTransformTranslate(self.cockroachIV.transform, 0, -15);
    
    if (self.cockroachIV.transform.ty < -510) {
        [self.moveTime invalidate];
        self.moveTime = nil;
        [self.cockroachIV stopAnimating];
        _isMove = NO;
        if (self.fail) {
            self.fail();
        }
    }
}

- (BOOL)hitCockroach {
    
    if (_isMove) {
        [self.moveTime invalidate];
        self.moveTime = nil;
        
        [self.cockroachIV stopAnimating];
    
        [self showPaView];
    }
    
    return _isMove;
}

- (void)stopMove {
    [self.moveTime invalidate];
    self.moveTime = nil;
}

- (void)removeData {
    [self removeTimer];
    _failed = YES;
}

- (void)showPaView {
    
    UIImageView *slipView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth / 3 - 100) * 0.5 - 18, ScreenHeight + self.cockroachIV.transform.ty  - ScreenWidth / 3 + 50, 100, 159)];
    slipView.layer.anchorPoint = CGPointMake(0.5, 1);
    slipView.transform = CGAffineTransformMakeRotation(-M_PI_4 / 8);
    slipView.image = [UIImage imageNamed:@"stage27_shoes01-iphone4"];
    [self addSubview:slipView];
    
    UIView *topIV = [[UIView alloc] initWithFrame:CGRectMake(2, 0, ScreenWidth / 3 - 4, CGRectGetMaxY(slipView.frame))];

    if (self.tag == 10) {
        topIV.backgroundColor = [UIColor colorWithR:195 g:71 b:71];
    } else if (self.tag == 11) {
        topIV.backgroundColor = [UIColor colorWithR:225 g:200 b:66];
    } else {
        topIV.backgroundColor = [UIColor colorWithR:75 g:136 b:193];
    }
    
    [self insertSubview:topIV belowSubview:self.cockroachIV];
    
    UIView *blueV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(slipView.frame), self.frame.size.width, 5)];
    blueV.backgroundColor = [UIColor colorWithR:43 g:243 b:250];
    [self addSubview:blueV];
    
    [UIView animateWithDuration:0.1 animations:^{
        slipView.transform = CGAffineTransformMakeRotation(M_PI_4 / 3);
    } completion:^(BOOL finished) {
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundSlapName];
        
        UIImageView *bomIV = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth / 3 - 160) * 0.5, ScreenHeight + self.cockroachIV.transform.ty  - ScreenWidth / 3 - 100, 160, 170)];
        bomIV.image = [UIImage imageNamed:@"stage27_pa0102-iphone4"];
        [self insertSubview:bomIV aboveSubview:topIV];
        
        UIImageView *paIV = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth / 3 - 100) * 0.5, ScreenHeight + self.cockroachIV.transform.ty  - ScreenWidth / 3 + 40, 100, 83)];
        paIV.image = [UIImage imageNamed:@"stage27_pa01-iphone4"];
        [self addSubview:paIV];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.1 animations:^{
                bomIV.alpha = 0;
                paIV.alpha = 0;
            } completion:^(BOOL finished) {
                [bomIV removeFromSuperview];
                [paIV removeFromSuperview];
                
                if (self.showHitFinish) {
                    self.showHitFinish();
                }
            }];
        });
    }];
}

@end
