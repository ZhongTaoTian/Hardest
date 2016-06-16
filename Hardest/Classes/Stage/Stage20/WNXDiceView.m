//
//  WNXDiceView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/23.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXDiceView.h"

@interface WNXDiceView ()
{
    int _index;
    int _number1;
    int _number2;
    int _number3;
    NSInteger _duration;
}

@property (weak, nonatomic) IBOutlet UIImageView *thirdDiceIV;
@property (weak, nonatomic) IBOutlet UIImageView *secondDiceIV;
@property (weak, nonatomic) IBOutlet UIImageView *firstDiceIV;

@property (nonatomic, strong) CADisplayLink *timer;

@end

@implementation WNXDiceView

- (void)awakeFromNib {
    
    self.secondDiceIV.hidden = YES;
    self.thirdDiceIV.hidden = YES;
    [self setImageViewAnimationAttribute];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTimer) name:kNotificationNameGameViewControllerDelloc object:nil];
}

- (void)removeTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)dealloc {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setImageViewAnimationAttribute {
    NSArray *animationImages = @[[UIImage imageNamed:@"10_dice_ad01-iphone4"],
                                 [UIImage imageNamed:@"10_dice_ad02-iphone4"],
                                 [UIImage imageNamed:@"10_dice_ad03-iphone4"],
                                 [UIImage imageNamed:@"10_dice_ad04-iphone4"],
                                 [UIImage imageNamed:@"10_dice_ad05-iphone4"]];
    self.firstDiceIV.animationImages = self.secondDiceIV.animationImages = self.thirdDiceIV.animationImages = animationImages;
    self.firstDiceIV.animationDuration = self.secondDiceIV.animationDuration = self.thirdDiceIV.animationDuration = 0.2;
    self.firstDiceIV.animationRepeatCount = self.secondDiceIV.animationRepeatCount = self.thirdDiceIV.animationRepeatCount = MAXFLOAT;
}

- (void)startShakeDiceWithFirstDiceNumber:(int)number1 secoundDiceNumber:(int)number2 thridDiceNumber:(int)number3 shakeDuration:(NSInteger)duration {
    if (number1 != -1 && number2 == -1 && number3 == -1) {
        self.secondDiceIV.hidden = YES;
        self.thirdDiceIV.hidden = YES;
        self.firstDiceIV.frame = CGRectMake(13, 265, 80, 80);
    } else if (number1 != -1 && number2 != -1 && number3 == -1) {
        self.secondDiceIV.hidden = NO;
        self.thirdDiceIV.hidden = YES;
        self.firstDiceIV.frame = CGRectMake(13, 303, 80, 80);
        self.secondDiceIV.frame = CGRectMake(13, 230, 80, 80);
    } else {
        self.secondDiceIV.hidden = NO;
        self.thirdDiceIV.hidden = NO;
        self.firstDiceIV.frame = CGRectMake(13, 339, 80, 80);
        self.secondDiceIV.frame = CGRectMake(13, 266, 80, 80);
        self.thirdDiceIV.frame = CGRectMake(13, 195, 80, 80);
    }
    
    _number1 = number1;
    _number2 = number2;
    _number3 = number3;
    _duration = duration;
    
    [self startShakeDice];
}

- (void)startShakeDice {
    [UIView animateWithDuration:0.1 animations:^{
        self.firstDiceIV.transform = CGAffineTransformMakeTranslation(0, -30);
        self.secondDiceIV.transform = CGAffineTransformMakeTranslation(0, -30);
        self.thirdDiceIV.transform = CGAffineTransformMakeTranslation(0, -30);
    } completion:^(BOOL finished) {
        [self.firstDiceIV startAnimating];
        [self.secondDiceIV startAnimating];
        [self.thirdDiceIV startAnimating];
        
        if (self.timer) {
            [self.timer invalidate];
        }
        
        self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
        [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }];
}

- (void)updateTime {
    _index++;
    if (_index == _duration) {
        [self.timer invalidate];
        self.timer = nil;
        
        _index = 0;
        
        [self.firstDiceIV stopAnimating];
        [self.secondDiceIV stopAnimating];
        [self.thirdDiceIV stopAnimating];
        [self showDiceNumber];
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.firstDiceIV.transform = CGAffineTransformIdentity;
            self.secondDiceIV.transform = CGAffineTransformIdentity;
            self.thirdDiceIV.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if (self.shakeDiceFinish) {
                self.shakeDiceFinish();
            }
        }];
        
    }
}

- (void)showDiceNumber {
    self.firstDiceIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"10_dice0%d-iphone4", _number1]];
    if (_number2 != -1) {
        self.secondDiceIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"10_dice0%d-iphone4", _number2]];
    } else {
        self.secondDiceIV.image = [UIImage imageNamed:@"10_dice01-iphone4"];
    }
    
    if (_number3 != -1) {
        self.thirdDiceIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"10_dice0%d-iphone4", _number3]];
    } else {
        self.thirdDiceIV.image = [UIImage imageNamed:@"10_dice01-iphone4"];
    }
    
}

- (void)pause {
    if (self.timer) {
        self.timer.paused = YES;
    }
}

- (void)resume {
    if (self.timer) {
        self.timer.paused = NO;
    }
}

- (void)removeData {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    if (self.shakeDiceFinish) {
        self.shakeDiceFinish = nil;
    }
}

@end
