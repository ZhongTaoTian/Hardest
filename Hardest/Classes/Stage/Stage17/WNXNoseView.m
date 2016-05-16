
//
//  WNXNoseView.m
//  Hardest
//
//  Created by sfbest on 16/5/16.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXNoseView.h"

@interface  WNXNoseView ()
{
    int _score;
    int _count;
    BOOL _pullOut;
    int _offsetX;
    int _noseOffsetX;
}

@property (nonatomic ,strong) IBOutlet UIImageView *noseIV;
@property (weak, nonatomic) IBOutlet UIImageView *vibrissaIV;
@property (weak, nonatomic) IBOutlet UIImageView *handIV;
@property (weak, nonatomic) IBOutlet UIImageView *curvedViIV;

@property (nonatomic, strong) CADisplayLink *timer;

@end

@implementation WNXNoseView

- (void)awakeFromNib {
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTimer) name:kNotificationNameGameViewControllerDelloc object:nil];
    _offsetX = 10;
    _noseOffsetX = 1;
    
    self.vibrissaIV.layer.anchorPoint = CGPointMake(0.5, 0);
    self.curvedViIV.layer.anchorPoint = CGPointMake(0.5, 0);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)showPullAnimationWithIsPullOut:(BOOL)pullOut score:(int)score finish:(void (^)())finish {
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    if (score <= 20) {
        _score = 30;
    } else if (score <= 50) {
        _score = 60;
    } else if (score <= 80) {
        _score = 90;
    } else {
        _score = 120;
    }
    
    _pullOut = pullOut;
    
     self.handIV.hidden = NO;
    
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    self.noseIV.image = [UIImage imageNamed:@"15_nose02-iphone4"];
}

- (void)updateTime {
    _count++;
    
    if (_count % 6 == 0) {
        [UIView animateWithDuration:0.1 animations:^{
            self.noseIV.transform = CGAffineTransformMakeTranslation(_noseOffsetX, 0);
        }];
        _noseOffsetX = -_noseOffsetX;
    }
    
    if (_count % 5 == 0) {
        _offsetX = -_offsetX;
        
        [UIView animateWithDuration:0.1 animations:^{
            self.handIV.transform = CGAffineTransformMakeTranslation(_offsetX, _count * 1.5);
            self.noseIV.transform = CGAffineTransformMakeTranslation(_noseOffsetX, 0);
        }];
    } else {
        self.vibrissaIV.transform = CGAffineTransformMakeScale(1, 1 + (0.031 * _count));
        self.curvedViIV.transform = CGAffineTransformMakeScale(1, 1 + (0.031 * _count));
        self.handIV.transform = CGAffineTransformMakeTranslation(0, _count * 1.5);
    }
    
    if (_count == _score) {
         self.handIV.transform = CGAffineTransformMakeTranslation(0, _count * 1.5);
        [self.timer invalidate];
        self.timer = nil;
        self.noseIV.image = [UIImage imageNamed:@"15_nose01-iphone4"];
        
        if (!_pullOut) {
            self.vibrissaIV.hidden = YES;
            self.curvedViIV.hidden = NO;
            [UIView animateWithDuration:0.35 animations:^{
                
                self.handIV.transform = CGAffineTransformMakeTranslation(0, _count * 1.5 + 200);
                self.vibrissaIV.transform = CGAffineTransformIdentity;
                self.curvedViIV.transform = CGAffineTransformIdentity;
                
            } completion:^(BOOL finished) {
                self.handIV.hidden = YES;
                self.handIV.transform = CGAffineTransformIdentity;
                self.vibrissaIV.hidden = NO;
                self.curvedViIV.hidden = YES;
            }];
        } else {
        
        }
    }
    
}

@end
