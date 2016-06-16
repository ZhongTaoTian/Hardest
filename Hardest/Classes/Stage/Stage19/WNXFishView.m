//
//  WNXFishView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/19.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXFishView.h"

@interface WNXFishView ()
{
    int _index;
}

@property (weak, nonatomic) IBOutlet UIImageView *peopleIV;
@property (weak, nonatomic) IBOutlet UIImageView *rodIV;
@property (weak, nonatomic) IBOutlet UIImageView *sprayIV;
@property (weak, nonatomic) IBOutlet UIImageView *iphoneIV;
@property (weak, nonatomic) IBOutlet UIImageView *pullIV;
@property (weak, nonatomic) IBOutlet UIView *blackView;
@property (weak, nonatomic) IBOutlet UIImageView *lineIV;
@property (weak, nonatomic) IBOutlet UIImageView *happyIV;

@property (nonatomic, strong) CADisplayLink *timer;

@end

@implementation WNXFishView

- (void)awakeFromNib {
    self.pullIV.hidden = YES;
    self.iphoneIV.hidden = YES;
    self.blackView.hidden = YES;
    self.lineIV.hidden = YES;
    
    self.iphoneIV.animationDuration = 0.5;
    self.iphoneIV.animationImages = @[[UIImage imageNamed:@"06_phone01-iphone4"], [UIImage imageNamed:@"06_phone02-iphone4"]];
    self.iphoneIV.animationRepeatCount = MAXFLOAT;
    
    self.rodIV.layer.anchorPoint = CGPointMake(0.5, 1);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTimer) name:kNotificationNameGameViewControllerDelloc object:nil];
}

- (void)removeTimer {
    [self killTimer];
}

- (void)dealloc {
    [self killTimer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showBlackView {
    self.blackView.hidden = NO;
    self.iphoneIV.hidden = NO;
    self.pullIV.hidden = NO;
    [self.iphoneIV startAnimating];
}

- (void)killTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)startFishBite {
    self.sprayIV.image = [UIImage imageNamed:@"06_water02-iphone4"];
    
    //    CAKeyframeAnimation *sprayAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.y"];
    //    sprayAnim.values = @[@(0), @(M_PI), @(0)];
    //    sprayAnim.duration = 0.2;
    //    sprayAnim.repeatCount = MAXFLOAT;
    //    [self.sprayIV.layer addAnimation:sprayAnim forKey:nil];
    
    //    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    //    anim.values = @[@1, @(0.8), @1];
    //    anim.duration = 0.2;
    //    anim.repeatCount = MAXFLOAT;
    //    [self.rodIV.layer addAnimation:anim forKey:nil];
    
    [self killTimer];
    
    _index = 0;
    
    [self startSprayAnimation];
    [self startRodAnimation];
    
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updataTime)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    //    self.sprayTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(startSprayAnimation) userInfo:nil repeats:YES];
    
}

- (void)updataTime {
    _index++;
    if (_index == 12) {
        [self startRodAnimation];
        [self startSprayAnimation];
        _index = 0;
    }
}

- (void)stopFishBite {
    [self killTimer];
    
    self.sprayIV.transform = CGAffineTransformIdentity;
    self.rodIV.transform = CGAffineTransformIdentity;
    self.sprayIV.image = [UIImage imageNamed:@"06_water01-iphone4"];
}

- (void)showSucess {
    self.blackView.hidden = YES;
    [self.iphoneIV stopAnimating];
    self.iphoneIV.hidden = YES;
    self.pullIV.hidden = YES;
    
    [self stopFishBite];
    
    self.rodIV.hidden = YES;
    self.lineIV.hidden = NO;
    self.sprayIV.hidden = YES;
    self.peopleIV.hidden = YES;
    
    self.happyIV.hidden = NO;
    
    CGFloat startY = self.happyIV.frame.origin.y + self.happyIV.frame.size.height * 0.5;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
        anim.values = @[@(10 + startY), @(startY), @(10 + startY), @(startY), @(10 + startY), @(startY), @(startY + 10), @(startY)];
        anim.duration = 0.4;
        [self.happyIV.layer addAnimation:anim forKey:nil];
    });
}

- (void)pause {
    if (self.timer) {
        self.timer.paused = YES;
    }
    
    if (self.blackView.hidden == NO) {
        if ([self.iphoneIV isAnimating]) {
            [self.iphoneIV stopAnimating];
        }
    }
}

- (void)resume {
    if (self.timer) {
        self.timer.paused = NO;
    }
    
    if (self.blackView.hidden == NO) {
        [self.iphoneIV startAnimating];
    }
}

- (void)resumeData {
    self.happyIV.hidden = YES;
    self.lineIV.hidden = YES;
    self.rodIV.hidden = NO;
    self.sprayIV.hidden = NO;
    self.peopleIV.hidden = NO;
}

#pragma mark - Private Method

- (void)startSprayAnimation {
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundReelinName];
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.sprayIV.transform = CGAffineTransformMakeScale(0, 1);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.sprayIV.transform = CGAffineTransformIdentity;
        } completion:nil];
        
    }];
}

- (void)startRodAnimation {
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.rodIV.transform = CGAffineTransformMakeScale(1, 0.7);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.rodIV.transform = CGAffineTransformIdentity;
        } completion:nil];
        
    }];
}



@end
