//
//  WNXJumpPeopleView.m
//  Hardest
//
//  Created by sfbest on 16/5/31.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXJumpPeopleView.h"

@interface WNXJumpPeopleView ()
{
    int _count;
    int _angleNum;
    int _speedIndex;
    int _angleIndex;
    BOOL _angleAdd;
}

@property (weak, nonatomic) IBOutlet UIView *speedView;
@property (weak, nonatomic) IBOutlet UIView *angelView;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UILabel *angelLabel;
@property (weak, nonatomic) IBOutlet UIImageView *peopleView;
@property (weak, nonatomic) IBOutlet UIImageView *landIV;
@property (weak, nonatomic) IBOutlet UIView *speedV;
@property (weak, nonatomic) IBOutlet UIView *angle;

@property (nonatomic, assign) int speedNum;
@property (nonatomic, assign) int angleNum;

@property (nonatomic, strong) CADisplayLink *speedTimer;
@property (nonatomic, strong) CADisplayLink *angleTimer;


@end

@implementation WNXJumpPeopleView

- (void)awakeFromNib {
    self.speedView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.angelView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.angelView.layer.borderWidth = 2;
    self.speedView.layer.borderWidth = 2;
    
    self.peopleView.animationImages = @[[UIImage imageNamed:@"22_run02-iphone4"],
                                        [UIImage imageNamed:@"22_run03-iphone4"],
                                        [UIImage imageNamed:@"22_run04-iphone4"],
                                        [UIImage imageNamed:@"22_run05-iphone4"]];
    self.peopleView.animationRepeatCount = 1;
    self.peopleView.animationDuration = 0.3;
    
    self.angle.layer.anchorPoint = CGPointMake(0, 0.5);
    self.speedV.layer.anchorPoint = CGPointMake(0, 0.5);
    self.angle.transform = CGAffineTransformMakeScale(0, 1);
    self.speedV.transform = CGAffineTransformMakeScale(0, 1);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTimer) name:kNotificationNameGameViewControllerDelloc object:nil];
    
    [self.landIV addObserver:self forKeyPath:@"transform" options:NSKeyValueObservingOptionNew context:nil];
    _angleIndex = YES;
}

- (void)removeTimer {
    [self.speedTimer invalidate];
    self.speedTimer = nil;
    
    [self.angleTimer invalidate];
    self.angleTimer = nil;
    
}

- (void)dealloc {
    [self removeTimer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.landIV removeObserver:self forKeyPath:@"transform"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if (object == self.landIV) {
        if (self.landIV.transform.tx <= -310 && _speedNum > 75) {
            if (self.jumpButtonCanClick) {
                self.jumpButtonCanClick();
            }
        } else if (self.landIV.transform.tx <= -340 && _speedNum > 50) {
            if (self.jumpButtonCanClick) {
                self.jumpButtonCanClick();
            }
        } else if (self.landIV.transform.tx <= -380 && _speedNum > 25) {
            if (self.jumpButtonCanClick) {
                self.jumpButtonCanClick();
            }
        } else if (self.landIV.transform.tx <= -415 && _speedNum >= 0) {
            if (self.jumpButtonCanClick) {
                self.jumpButtonCanClick();
            }
        }
    }
}

- (void)run {
    
    self.peopleView.image = [UIImage imageNamed:@"22_run05-iphone4"];
    _count++;
    
    self.speedNum += 5;
    if (self.speedNum > 100) {
        self.speedNum = 100;
    }
    
    NSTimeInterval duration;
    if (_count <= 12) {
        duration = 0.3;
    } else {
        duration = 0.2;
    }
    
    if (_count <= 4) {
        [UIView animateWithDuration:duration animations:^{
            self.peopleView.transform = CGAffineTransformTranslate(self.peopleView.transform, 15, 0);
        }];
    } else {
        [UIView animateWithDuration:duration animations:^{
            self.landIV.transform = CGAffineTransformTranslate(self.landIV.transform, -11, 0);
        }];
    }
    
    self.peopleView.animationDuration = duration;
    [self.peopleView startAnimating];
    
}

- (void)setSpeedNum:(int)speedNum {
    _speedNum = speedNum;
    self.speedV.transform = CGAffineTransformMakeScale(1 - (100 - _speedNum) / 100.0, 1);
    
    if (_speedNum > 0) {
        if (!self.speedTimer) {
            self.speedTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(speedTimeUpdate)];
            [self.speedTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        }
    } else {
        [self.speedTimer invalidate];
        self.speedTimer = nil;
    }
}

- (void)setAngleNum:(int)angleNum {
    _angleNum = angleNum;
    
    self.angle.transform = CGAffineTransformMakeScale(1 - (45 - _angleNum) / 45.0, 1);
}

- (void)readyJump {
    
    [self.speedTimer invalidate];
    self.speedTimer = nil;
    self.peopleView.hidden = YES;
    
    UIImageView *slipIV = [[UIImageView alloc] initWithFrame:CGRectMake(self.peopleView.frame.origin.x - 20, self.peopleView.frame.origin.y + 20, 30, 30)];
    slipIV.image = [UIImage imageNamed:@"22_slip-iphone4"];
    slipIV.transform = self.peopleView.transform;
    [self addSubview:slipIV];
    
//    CGFloat moveDis;
//    NSTimeInterval duration;
//    
//    if (self.speedNum <= 0) {
//        moveDis = 0;
//        duration = 0;
//    } else if (self.speedNum < 20) {
//        moveDis = 5;
//        duration = 0.2;
//    } else if (self.speedNum < 50) {
//        moveDis = 10;
//        duration = 0.25;
//    } else if (self.speedNum < 75) {
//        moveDis = 15;
//        duration = 0.3;
//    } else {
//        moveDis = 20;
//        duration = 0.35;
//    }
//    
//    [UIView animateWithDuration:duration animations:^{
//        slipIV.
//        slipIV.transform = CGAffineTransformTranslate(slipIV.transform, moveDis, 0);
//    } completion:^(BOOL finished) {
//        slipIV.frame = CGRectMake(slipIV.frame.origin.x, slipIV.frame.origin.y, 18, 33);
//        slipIV.image = [UIImage imageNamed:@"22_hold-iphone4"];
//        
//        NSLog(@"%f, %f", slipIV.frame.origin.y, slipIV.transform.tx);
//        
//        if (self.angleTimer) {
//            [self.angleTimer invalidate];
//            self.angleTimer = nil;
//        }
//        
//        self.angleTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(angleTimeUpdate)];
//        [self.angleTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
//        
//    }];
}

- (void)speedTimeUpdate {
    
    _speedIndex++;
    
    if (_speedIndex == 4) {
        _speedIndex = 0;
        self.speedNum -= 1;
        self.speedLabel.text = [NSString stringWithFormat:@"%d%%", self.speedNum];
        
        if (self.speedNum <= 0) {
            [self.speedTimer invalidate];
            self.speedTimer = nil;
        }
    }
}

- (void)angleTimeUpdate {
    _angleIndex++;
    
    if (_angleIndex == 2) {
        _angleIndex = 0;
        
        if (_angleAdd) {
            self.angleNum++;
            
            if (self.angleNum >= 45) {
                self.angleNum = 45;
                _angleAdd = NO;
            }
        } else {
            self.angleNum--;
            if (self.angleNum <= 0) {
                self.angleNum = 0;
                _angleAdd = YES;
            }
        }
        
        self.angelLabel.text = [NSString stringWithFormat:@"%d'", self.angleNum];
    }
}

- (void)startJump {
    [self.angleTimer invalidate];
    self.angleTimer = nil;
}

















@end
