//
//  WNXSubjectView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/4/28.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXSubjectView.h"

#define kToTopMargin -100
#define kToBottomMargin 200

@interface WNXSubjectView ()
{
    int _leftRandom;
    int _middleRandom;
    int _rightRandom;
    int _count;
    CGFloat _handToCenterX;
    CGFloat _handToCenterY;
}

@property (strong, nonatomic) UIImageView *handIV;
@property (strong, nonatomic) UIImageView *leftIV;
@property (strong, nonatomic) UIImageView *plusIV;
@property (strong, nonatomic) UIImageView *middleIV;
@property (strong, nonatomic) UIImageView *equalIV;
@property (strong, nonatomic) UIImageView *lineIV;
@property (strong, nonatomic) UIImageView *rightIV;

@property (nonatomic, assign) WNXSubjectGuessType guessType;
@property (nonatomic, assign) WNXSubjectGuessType coverType;


@end

@implementation WNXSubjectView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.leftIV = [[UIImageView alloc] initWithFrame:CGRectMake(34, 0, 47, 55)];
        [self addSubview:self.leftIV];
        
        self.plusIV = [[UIImageView alloc] initWithFrame:CGRectMake(94, 13, 29, 29)];
        self.plusIV.image = [UIImage imageNamed:@"13_plus-iphone4"];
        [self addSubview:self.plusIV];
        
        self.middleIV = [[UIImageView alloc] initWithFrame:CGRectMake(136, 0, 47, 55)];
        [self addSubview:self.middleIV];
        
        self.equalIV = [[UIImageView alloc] initWithFrame:CGRectMake(190, 17, 27, 18)];
        self.equalIV.image = [UIImage imageNamed:@"13_equal-iphone4"];
        [self addSubview:self.equalIV];
        
        self.lineIV = [[UIImageView alloc] initWithFrame:CGRectMake(222, 60, 60, 5)];
        self.lineIV.image = [UIImage imageNamed:@"13_line-iphone4"];
        [self addSubview:self.lineIV];
        
        self.rightIV = [[UIImageView alloc] initWithFrame:CGRectMake(230, 0, 47, 55)];
        [self addSubview:self.rightIV];
        
        self.handIV = [[UIImageView alloc] initWithFrame:CGRectMake(25, 100, 72, 94)];
        self.handIV.image = [UIImage imageNamed:@"13_hand-iphone4"];
        self.handIV.alpha = 0;
        [self addSubview:self.handIV];
        
        self.alpha = 0;
        self.hidden = YES;
        self.clipsToBounds = NO;
    }
    
    return self;
}

- (void)showNextSubjectViewNums:(void (^)(int, int, int, int))nums {
    
    BOOL isMoveLeft = !(self.coverType == WNXSubjectGuessTypeLeft);
    BOOL isMoveMiddle = !(self.coverType == WNXSubjectGuessTypeMiddle);
    BOOL isMoveRight = !(self.coverType == WNXSubjectGuessTypeRight);
    
    NSTimeInterval duration = 0.2 - _count * 0.02;
    if (duration < 0.05) {
        duration = 0.05;
    }
    [UIView animateWithDuration:duration animations:^{
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0, kToTopMargin);
        self.plusIV.transform = transform;
        self.plusIV.alpha = 0;
        self.equalIV.transform = transform;
        self.equalIV.alpha = 0;
        self.lineIV.transform = transform;
        self.lineIV.alpha = 0;
        
        if (!isMoveLeft) {
            self.middleIV.transform = transform;
            self.middleIV.alpha = 0;
            
            self.rightIV.transform = transform;
            self.rightIV.alpha = 0;
            
        } else if (!isMoveMiddle) {
            self.leftIV.transform = transform;
            self.leftIV.alpha = 0;
            
            self.rightIV.transform = transform;
            self.rightIV.alpha = 0;
            
        } else if (!isMoveRight) {
            self.leftIV.transform = transform;
            self.leftIV.alpha = 0;
            
            self.middleIV.transform = transform;
            self.middleIV.alpha = 0;
        }
        
    } completion:^(BOOL finished) {
        if (self.isPlayAgain) {
            [self cleanDataStopAnimation];
            return;
        }
        CGAffineTransform bottomT = CGAffineTransformMakeTranslation(0, kToBottomMargin);
        if (!isMoveLeft) {
            self.middleIV.transform = bottomT;
            self.rightIV.transform = bottomT;
            
            self.guessType = arc4random_uniform(2) + 1;
            
            if (self.guessType == WNXSubjectGuessTypeMiddle) {
                _rightRandom = arc4random_uniform(10);
                _middleRandom = -1;
                while (_rightRandom - _leftRandom < 0) {
                    _rightRandom = arc4random_uniform(10);
                }
            } else if (self.guessType == WNXSubjectGuessTypeRight) {
                _middleRandom = arc4random_uniform(10);
                _rightRandom = -1;
                while (_leftRandom + _middleRandom > 9) {
                    _middleRandom = arc4random_uniform(10);
                }
            }
            
        } else if (!isMoveMiddle) {
            self.leftIV.transform = bottomT;
            self.rightIV.transform = bottomT;
            
            self.guessType = arc4random_uniform(3);
            while (self.guessType == WNXSubjectGuessTypeMiddle) {
                self.guessType = arc4random_uniform(3);
            }
            
            if (self.guessType == WNXSubjectGuessTypeLeft) {
                _rightRandom = arc4random_uniform(10);
                _leftRandom = -1;
                
                while (_rightRandom - _middleRandom < 0) {
                    _rightRandom = arc4random_uniform(10);
                }
            } else {
                _rightRandom = -1;
                _leftRandom = arc4random_uniform(10);
                while (_leftRandom + _middleRandom > 9) {
                    _leftRandom = arc4random_uniform(10);
                }
            }
            
        } else if (!isMoveRight) {
            self.leftIV.transform = bottomT;
            self.middleIV.transform = bottomT;
            
            self.guessType = arc4random_uniform(2);
            
            if (self.guessType == WNXSubjectGuessTypeLeft) {
                _leftRandom = -1;
                _middleRandom = arc4random_uniform(10);
                
                while (_rightRandom - _middleRandom < 0) {
                    _middleRandom = arc4random_uniform(10);
                }
            } else {
                _middleRandom = -1;
                _leftRandom = arc4random_uniform(10);
                
                while (_rightRandom - _leftRandom < 0) {
                    _leftRandom = arc4random_uniform(10);
                }
            }
        }
        
        self.equalIV.transform = bottomT;
        self.lineIV.transform = bottomT;
        self.plusIV.transform = bottomT;
        
        self.coverType = arc4random_uniform(3);
        
        CGFloat lineCenterX;
        int result;
        if (self.guessType == WNXSubjectGuessTypeLeft) {
            result = _rightRandom - _middleRandom;
            lineCenterX = self.leftIV.center.x;
        } else if (self.guessType == WNXSubjectGuessTypeMiddle) {
            result = _rightRandom - _leftRandom;
            lineCenterX = self.middleIV.center.x;
        } else if (self.guessType == WNXSubjectGuessTypeRight) {
            result = _leftRandom + _middleRandom;
            lineCenterX = self.rightIV.center.x;
        }
        
        self.lineIV.center = CGPointMake(lineCenterX, self.lineIV.center.y);
        
        if (self.guessType == WNXSubjectGuessTypeLeft) {
            self.leftIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"stage13_%d", _leftRandom]];
            self.rightIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"stage13_%d", _rightRandom]];
            self.middleIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"stage13_%d", _middleRandom]];
        } else if (self.guessType == WNXSubjectGuessTypeMiddle) {
            self.leftIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"stage13_%d", _leftRandom]];
            self.rightIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"stage13_%d", _rightRandom]];
            self.middleIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"stage13_%d", -1]];
        } else {
            self.leftIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"stage13_%d", _leftRandom]];
            self.rightIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"stage13_%d", -1]];
            self.middleIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"stage13_%d", _middleRandom]];
        }
        
        if (self.guessType == WNXSubjectGuessTypeLeft) {
            _leftRandom = result;
        } else if (self.guessType == WNXSubjectGuessTypeMiddle) {
            _middleRandom = result;
        } else {
            _rightRandom = result;
        }
        
        NSTimeInterval duration = 0.25 - _count * 0.02;
        if (duration < 0.1) {
            duration = 0.1;
        }
        
        [UIView animateWithDuration:duration animations:^{
            self.equalIV.transform = CGAffineTransformIdentity;
            self.equalIV.alpha = 1;
            self.plusIV.transform = CGAffineTransformIdentity;
            self.plusIV.alpha = 1;
            self.lineIV.transform = CGAffineTransformIdentity;
            self.lineIV.alpha = 1;
            
            if (!isMoveLeft) {
                self.middleIV.transform = CGAffineTransformIdentity;
                self.middleIV.alpha = 1;
                self.rightIV.transform = CGAffineTransformIdentity;
                self.rightIV.alpha = 1;
            } else if (!isMoveMiddle) {
                self.leftIV.transform = CGAffineTransformIdentity;
                self.leftIV.alpha = 1;
                self.rightIV.transform = CGAffineTransformIdentity;
                self.rightIV.alpha = 1;
            } else if (!isMoveRight){
                self.leftIV.transform = CGAffineTransformIdentity;
                self.leftIV.alpha = 1;
                self.middleIV.transform = CGAffineTransformIdentity;
                self.middleIV.alpha = 1;
            }
            
        } completion:^(BOOL finished) {
            if (self.isPlayAgain) {
                [self cleanDataStopAnimation];
                return;
            }
            [self randonResultWithNums:^(int num1, int num2, int num3) {
                nums(num1, num2, num3, result);
            }];
        }];
        
    }];
}

- (void)showSubjectViewNums:(void (^)(int, int, int, int))nums {
    self.hidden = NO;
    self.leftIV.image = nil;
    self.middleIV.image = nil;
    self.rightIV.image = nil;
    self.guessType = arc4random_uniform(3);
    self.coverType = arc4random_uniform(3);
    
    _leftRandom = -1;
    _rightRandom = -1;
    _middleRandom = -1;
    
    CGFloat lineCenterX;
    int result;
    if (self.guessType == WNXSubjectGuessTypeLeft) {
        _middleRandom = arc4random_uniform(10);
        _rightRandom = arc4random_uniform(10);
        while (_rightRandom - _middleRandom < 0) {
            _middleRandom = arc4random_uniform(10);
            _rightRandom = arc4random_uniform(10);
        }
        result = _rightRandom - _middleRandom;
        lineCenterX = self.leftIV.center.x;
    } else if (self.guessType == WNXSubjectGuessTypeMiddle) {
        _leftRandom = arc4random_uniform(10);
        _rightRandom = arc4random_uniform(10);
        while (_rightRandom - _leftRandom < 0) {
            _leftRandom = arc4random_uniform(10);
            _rightRandom = arc4random_uniform(10);
        }
        result = _rightRandom - _leftRandom;
        lineCenterX = self.middleIV.center.x;
    } else if (self.guessType == WNXSubjectGuessTypeRight) {
        _leftRandom = arc4random_uniform(10);
        _middleRandom = arc4random_uniform(10);
        while (_leftRandom + _middleRandom > 9) {
            _leftRandom = arc4random_uniform(10);
            _middleRandom = arc4random_uniform(10);
        }
        result = _leftRandom + _middleRandom;
        lineCenterX = self.rightIV.center.x;
    }
    
    self.lineIV.center = CGPointMake(lineCenterX, self.lineIV.center.y);
    
    self.leftIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"stage13_%d", _leftRandom]];
    self.rightIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"stage13_%d", _rightRandom]];
    self.middleIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"stage13_%d", _middleRandom]];
    
    if (self.guessType == WNXSubjectGuessTypeLeft) {
        _leftRandom = result;
    } else if (self.guessType == WNXSubjectGuessTypeMiddle) {
        _middleRandom = result;
    } else {
        _rightRandom = result;
    }
    
    self.transform = CGAffineTransformMakeTranslation(0, 200);
    NSTimeInterval duration = 0.25 - _count * 0.02;
    if (duration < 0.1) {
        duration = 0.1;
    }
    
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    } completion:^(BOOL finished) {
        if (self.isPlayAgain) {
            [self cleanDataStopAnimation];
            return;
        }
        [self randonResultWithNums:^(int num1, int num2, int num3) {
            nums(num1, num2, num3, result);
        }];
    }];
}

- (void)randonResultWithNums:(void (^) (int num1, int num2, int num3))nums {
    int index1 = arc4random_uniform(10);
    int index2 = arc4random_uniform(10);
    int index3 = arc4random_uniform(10);
    if (self.guessType == WNXSubjectGuessTypeLeft) {
        while (!((_rightRandom - _middleRandom == index1 || _rightRandom - _middleRandom == index2 || _rightRandom - _middleRandom == index3) && index1 != index2 && index2 != index3 && index1 != index3)) {
            index1 = arc4random_uniform(10);
            index2 = arc4random_uniform(10);
            index3 = arc4random_uniform(10);
        }
    } else if (self.guessType == WNXSubjectGuessTypeMiddle) {
        while (!((_rightRandom - _leftRandom == index1 || _rightRandom - _leftRandom == index2 || _rightRandom - _leftRandom == index3) && index1 != index2 && index2 != index3 && index1 != index3)) {
            index1 = arc4random_uniform(10);
            index2 = arc4random_uniform(10);
            index3 = arc4random_uniform(10);
        }
    } else {
        while (!((_leftRandom + _middleRandom == index1 || _leftRandom + _middleRandom == index2 || _leftRandom + _middleRandom == index3) && index1 != index2 && index2 != index3 && index1 != index3) ) {
            index1 = arc4random_uniform(10);
            index2 = arc4random_uniform(10);
            index3 = arc4random_uniform(10);
        }
    }
    nums(index1, index2, index3);
}

- (void)showResultWithResult:(int)result finish:(void (^)(void))finish {
    UIImage *resultImage = [UIImage imageNamed:[NSString stringWithFormat:@"stage13_%d", result]];
    switch (self.guessType) {
        case WNXSubjectGuessTypeLeft:
            self.leftIV.image = resultImage;
            break;
        case WNXSubjectGuessTypeMiddle:
            self.middleIV.image = resultImage;
            break;
        case WNXSubjectGuessTypeRight:
            self.rightIV.image = resultImage;
            break;
        default:
            break;
    }
    
    [self moveHandViewToBottomAnimationFinish:^{
        finish();
    }];
}

- (void)moveHandViewToBottomAnimationFinish:(void (^) (void))finish {
    NSTimeInterval duration = 0.3 - _count * 0.2;
    if (duration < 0.05) {
        duration = 0.05;
    }
    [UIView animateWithDuration:duration animations:^{
        self.handIV.frame = CGRectMake(self.handIV.frame.origin.x, self.handIV.frame.origin.y + 100, self.handIV.frame.size.width, self.handIV.frame.size.height);
    } completion:^(BOOL finished) {
        if (self.isPlayAgain) {
            [self cleanDataStopAnimation];
            return;
        }
        finish();
    }];
}

- (void)showHandViewWithAnimationFinish:(void (^)(void))finish {
    _count++;
    self.handIV.alpha = 0.3 * _count;
    [self calculationHandImageViewToCenter];
    NSTimeInterval duration = 1 - _count * 0.2;
    if (duration < 0.05) {
        duration = 0.05;
    }
    [UIView animateWithDuration:duration animations:^{
        self.handIV.center = CGPointMake(_handToCenterX, _handToCenterY - 4);
    } completion:^(BOOL finished) {
        if (self.isPlayAgain) {
            [self cleanDataStopAnimation];
            return;
        }
        finish();
    }];
}

- (void)calculationHandImageViewToCenter {
    
    if (self.coverType == WNXSubjectGuessTypeLeft) {
        _handToCenterY = self.leftIV.center.y;
        _handToCenterX = self.leftIV.center.x;
    } else if (self.coverType == WNXSubjectGuessTypeMiddle) {
        _handToCenterY = self.middleIV.center.y;
        _handToCenterX = self.middleIV.center.x;
    } else {
        _handToCenterY = self.rightIV.center.y;
        _handToCenterX = self.rightIV.center.x;
    }
}

- (void)cleanData {
    _count = 0;
    self.isPlayAgain = YES;
    _leftRandom = -1;
    _middleRandom = -1;
    _rightRandom = -1;
    
    self.leftIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"stage13_%d", _leftRandom]];
    self.rightIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"stage13_%d", _rightRandom]];
    self.middleIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"stage13_%d", _middleRandom]];
    self.handIV.alpha = 0;
    self.transform = CGAffineTransformIdentity;
    self.leftIV.transform = CGAffineTransformIdentity;
    self.plusIV.transform = CGAffineTransformIdentity;
    self.middleIV.transform = CGAffineTransformIdentity;
    self.equalIV.transform = CGAffineTransformIdentity;
    self.rightIV.transform = CGAffineTransformIdentity;
    self.handIV.transform = CGAffineTransformIdentity;
    self.lineIV.transform = CGAffineTransformIdentity;
    self.alpha = 0;
}

- (void)cleanDataStopAnimation {
    [self cleanData];
    self.isPlayAgain = NO;
}

@end
