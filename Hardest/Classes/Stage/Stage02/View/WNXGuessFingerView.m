//
//  WNXGuessFingerView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/21.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXGuessFingerView.h"

@interface WNXGuessFingerView ()
{
    CGAffineTransform _leftTransform;
    CGAffineTransform _rightTransform;
    int _winIndex;
}

@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIImageView *leftImageView;

@end

@implementation WNXGuessFingerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(0, frame.origin.y, ScreenWidth, frame.size.height)]) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = NO;
        
        self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 400) * 0.5 - 120, (frame.size.height - 97) * 0.5, 200, 97)];
        self.leftImageView.image = [UIImage imageNamed:@"09_hand02-iphone4right"];
        self.leftImageView.layer.anchorPoint = CGPointMake(0, 0.5);
        [self addSubview:self.leftImageView];
        
        self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth + (400 - ScreenWidth) * 0.5 - 80, (frame.size.height - 97) * 0.5, 200, 97)];
        self.rightImageView.image = [UIImage imageNamed:@"09_hand02-iphone4"];
        self.rightImageView.layer.anchorPoint = CGPointMake(1, 0.5);
        [self addSubview:self.rightImageView];
    }

    return self;
}

- (void)startAnimationWithDuration:(NSTimeInterval)duration {
    self.leftImageView.image = [UIImage imageNamed:@"09_hand02-iphone4right"];
    self.rightImageView.image = [UIImage imageNamed:@"09_hand02-iphone4"];
    
    NSTimeInterval timer1 = duration / 14;
    NSTimeInterval timer2 = duration / 7;
    
    int random1 = arc4random_uniform(3) + 1;
    int random2 = arc4random_uniform(3) + 1;
    
    [self setWinIndexWithNumOne:random1 numTwo:random2];
    
    [UIView animateWithDuration:timer1 animations:^{
        self.leftImageView.transform = CGAffineTransformMakeRotation(-M_PI_4 / 2);
        _leftTransform = self.leftImageView.transform;
        self.rightImageView.transform = CGAffineTransformMakeRotation(M_PI_4 / 2);
        _rightTransform = self.rightImageView.transform;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:timer2 animations:^{
            self.leftImageView.transform = CGAffineTransformRotate(_leftTransform, M_PI_4);
            _leftTransform = self.leftImageView.transform;
            self.rightImageView.transform = CGAffineTransformRotate(_rightTransform, -M_PI_4);
            _rightTransform = self.rightImageView.transform;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:timer2 animations:^{
                self.leftImageView.transform = CGAffineTransformRotate(_leftTransform, -M_PI_4);
                _leftTransform = self.leftImageView.transform;
                self.rightImageView.transform = CGAffineTransformRotate(_rightTransform, M_PI_4);
                _rightTransform = self.rightImageView.transform;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:timer2 animations:^{
                    self.leftImageView.transform = CGAffineTransformRotate(_leftTransform, M_PI_4);
                    _leftTransform = self.leftImageView.transform;
                    self.rightImageView.transform = CGAffineTransformRotate(_rightTransform, -M_PI_4);
                    _rightTransform = self.rightImageView.transform;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:timer2 animations:^{
                        self.leftImageView.transform = CGAffineTransformRotate(_leftTransform, -M_PI_4);
                        _leftTransform = self.leftImageView.transform;
                        self.rightImageView.transform = CGAffineTransformRotate(_rightTransform, M_PI_4);
                        _rightTransform = self.rightImageView.transform;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:timer2 animations:^{
                            self.leftImageView.transform = CGAffineTransformRotate(_leftTransform, M_PI_4);
                            _leftTransform = self.leftImageView.transform;
                            self.rightImageView.transform = CGAffineTransformRotate(_rightTransform, -M_PI_4);
                            _rightTransform = self.rightImageView.transform;
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:timer2 animations:^{
                                self.leftImageView.transform = CGAffineTransformRotate(_leftTransform, -M_PI_4);
                                _leftTransform = self.leftImageView.transform;
                                self.rightImageView.transform = CGAffineTransformRotate(_rightTransform, M_PI_4);
                                _rightTransform = self.rightImageView.transform;
                            } completion:^(BOOL finished) {
                                [UIView animateWithDuration:timer1 animations:^{
                                    self.leftImageView.transform = CGAffineTransformIdentity;
                                    self.rightImageView.transform = CGAffineTransformIdentity;
                                    self.leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"09_hand0%d-iphone4right", random1]];
                                    self.rightImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"09_hand0%d-iphone4", random2]];
                                } completion:^(BOOL finished) {
                                    if (self.animationFinish) {
                                        self.animationFinish(_winIndex);
                                    }
                                }];
                            }];
                        }];
                    }];
                }];
                
            }];
        }];
    }];
}

- (void)showResultAnimationCompletion:(void (^)())completion {
    CGFloat moveX1 = 0;
    CGFloat moveX2 = 0;
    if (_winIndex == 0) {
        moveX1 = 40;
        moveX2 = 15;
    } else if (_winIndex == 1) {
        moveX1 = 20;
        moveX2 = -20;
    } else if (_winIndex == 2) {
        moveX1 = -15;
        moveX2 = -40;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.leftImageView.transform = CGAffineTransformMakeTranslation(moveX1, 0);
        self.rightImageView.transform = CGAffineTransformMakeTranslation(moveX2, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.leftImageView.transform = CGAffineTransformIdentity;
            self.rightImageView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            completion();
        }];
    }];
}

- (void)setWinIndexWithNumOne:(int)num1 numTwo:(int)num2 {
    if (num1 == num2) {
        _winIndex = 1;
        return;
    }
    
    if (num1 == 1 && num2 == 2) {
        _winIndex = 2;
    } else if (num1 == 1 && num2 == 3) {
        _winIndex = 0;
    } else if (num1 == 2 && num2 == 1) {
        _winIndex = 0;
    } else if (num1 == 2 && num2 == 3) {
        _winIndex = 2;
    } else if (num1 == 3 && num2 == 1) {
        _winIndex = 2;
    } else if (num1 == 3 && num2 == 2) {
        _winIndex = 0;
    }
}

- (void)cleanData {
    self.leftImageView.transform = CGAffineTransformIdentity;
    self.rightImageView.transform = CGAffineTransformIdentity;
    self.rightImageView.image = [UIImage imageNamed:@"09_hand02-iphone4"];
    self.leftImageView.image = [UIImage imageNamed:@"09_hand02-iphone4right"];
    self.animationFinish = nil;
}

@end
