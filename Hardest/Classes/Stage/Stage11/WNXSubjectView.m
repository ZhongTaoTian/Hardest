//
//  WNXSubjectView.m
//  Hardest
//
//  Created by sfbest on 16/4/28.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXSubjectView.h"

@interface WNXSubjectView ()
{
    int _leftRandom;
    int _middleRandom;
    int _rightRandom;
}

@property (strong, nonatomic)  UIImageView *leftIV;
@property (strong, nonatomic)  UIImageView *plusIV;
@property (strong, nonatomic)  UIImageView *middleIV;
@property (strong, nonatomic)  UIImageView *equalIV;
@property (strong, nonatomic)  UIImageView *lineIV;
@property (strong, nonatomic)  UIImageView *rightIV;

@property (nonatomic, assign) WNXSubjectGuessType guessType;

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
        
        self.alpha = 0;
        self.hidden = YES;
    }
    
    return self;
}

- (void)showSubjectViewNums:(void (^)(int, int, int, int))nums {
    self.hidden = NO;
    
    self.leftIV.image = nil;
    self.middleIV.image = nil;
    self.rightIV.image = nil;
    self.guessType = arc4random_uniform(3);
    
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
    
    self.transform = CGAffineTransformMakeTranslation(0, 150);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    } completion:^(BOOL finished) {
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

- (void)showResultWithResult:(int)result {
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
}


@end
