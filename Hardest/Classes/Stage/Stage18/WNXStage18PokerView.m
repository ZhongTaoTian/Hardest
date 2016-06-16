//
//  WNXStage18PokerView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/18.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage18PokerView.h"
#import "WNXPokerView.h"

#define kPokerViewWidth 90
#define kPokerViewHeight 125
#define kLeftPokerViewFrame CGRectMake((ScreenWidth / 3 - kPokerViewWidth) * 0.5, 260, kPokerViewWidth, kPokerViewHeight)
#define kMiddlePokerViewFrame CGRectMake((ScreenWidth / 3 - kPokerViewWidth) * 0.5 + ScreenWidth / 3, 260, kPokerViewWidth, kPokerViewHeight)
#define kRightPokerViewFrame CGRectMake((ScreenWidth / 3 - kPokerViewWidth) * 0.5 + ScreenWidth / 3 * 2, 260, kPokerViewWidth, kPokerViewHeight)

@interface WNXStage18PokerView ()

@property (nonatomic, strong) NSMutableArray *pokerArr;

@end

@implementation WNXStage18PokerView
{
    BOOL _same1;
    BOOL _same2;
    BOOL _same3;
    
    BOOL _selectSame1;
    BOOL _selectSame2;
    BOOL _selectSame3;
    
    int _samePokerCount;
    int _pokerCount;
}

- (NSMutableArray *)pokerArr {
    if (!_pokerArr) {
        _pokerArr = [NSMutableArray array];
    }
    
    return _pokerArr;
}

- (BOOL)showPokerView {
    
    self.isFail = NO;
    BOOL result = NO;
    
    _samePokerCount++;
    
    _selectSame1 = NO;
    _selectSame2 = NO;
    _selectSame3 = NO;
    
    WNXPokerView *leftPokerView = [WNXPokerView viewFromNib];
    leftPokerView.frame = kLeftPokerViewFrame;
    [self addSubview:leftPokerView];
    
    WNXPokerView *middlePokerView = [WNXPokerView viewFromNib];
    middlePokerView.frame = kMiddlePokerViewFrame;
    [self addSubview:middlePokerView];
    
    WNXPokerView *rightPokerView = [WNXPokerView viewFromNib];
    rightPokerView.frame = kRightPokerViewFrame;
    [self addSubview:rightPokerView];
    
    [self.pokerArr addObject:leftPokerView];
    [self.pokerArr addObject:middlePokerView];
    [self.pokerArr addObject:rightPokerView];
    
    leftPokerView.transform = CGAffineTransformRotate(CGAffineTransformMakeTranslation(-120, 0), M_PI);
    middlePokerView.transform = CGAffineTransformRotate(CGAffineTransformMakeTranslation(0, -400), M_PI);
    rightPokerView.transform = CGAffineTransformRotate(CGAffineTransformMakeTranslation(120, 0), -M_PI);
    
    int leftPokerNum = arc4random_uniform(10) + 1;
    int middlePokerNum = arc4random_uniform(10) + 1;
    int rightPokerNum = arc4random_uniform(10) + 1;
    
    if (!(leftPokerNum == middlePokerNum || middlePokerNum == rightPokerNum || leftPokerNum == rightPokerNum) && _samePokerCount > 4) {
        while (!(leftPokerNum == middlePokerNum || middlePokerNum == rightPokerNum || leftPokerNum == rightPokerNum)) {
            leftPokerNum = arc4random_uniform(10) + 1;
            middlePokerNum = arc4random_uniform(10) + 1;
            rightPokerNum = arc4random_uniform(10) + 1;
        }
        
        if (_pokerCount == 8) {
            while (!(leftPokerNum == middlePokerNum && middlePokerNum == rightPokerNum)) {
                leftPokerNum = arc4random_uniform(10) + 1;
                middlePokerNum = arc4random_uniform(10) + 1;
                rightPokerNum = arc4random_uniform(10) + 1;
            }
        }
        
        _samePokerCount = 0;
    }
    
    WNXPokerType leftType = arc4random_uniform(4);
    WNXPokerType middleType = arc4random_uniform(4);
    WNXPokerType rightType = arc4random_uniform(4);
    
    BOOL isPositive = arc4random_uniform(2);
    
    int pro = arc4random_uniform(5) + 3;
    if (!isPositive) {
        pro = -pro;
    }
    
    int middlePro = isPositive ? pro + 2 : pro - 2;
    
    if (leftPokerNum == middlePokerNum || leftPokerNum == rightPokerNum || middlePokerNum == rightPokerNum) {
        result = YES;
    } else {
        result = NO;
    }
    
    if (leftPokerNum == middlePokerNum && middlePokerNum != rightPokerNum) {
        _same1 = YES;
        _same2 = YES;
        _same3 = NO;
    } else if (leftPokerNum == rightPokerNum && middlePokerNum != leftPokerNum) {
        _same1 = YES;
        _same2 = NO;
        _same3 = YES;
    } else if (middlePokerNum == rightPokerNum && middlePokerNum != leftPokerNum) {
        _same1 = NO;
        _same2 = YES;
        _same3 = YES;
    } else if (middlePokerNum == rightPokerNum && rightPokerNum == leftPokerNum) {
        _same1 = YES;
        _same2 = YES;
        _same3 = YES;
    } else {
        _same3 = NO;
        _same2 = NO;
        _same1 = NO;
    }
    
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundDealName];
    [UIView animateWithDuration:0.3 animations:^{
        leftPokerView.transform = CGAffineTransformMakeRotation(M_PI_4 / pro);
        middlePokerView.transform = CGAffineTransformMakeRotation(M_PI_4 / middlePro);
        rightPokerView.transform = CGAffineTransformMakeRotation(-M_PI_4 / pro);
    } completion:^(BOOL finished) {
        self.superview.userInteractionEnabled = YES;
        [self removePokerView];
        if (result) {
            _pokerCount++;
            self.startCountTime();
        } else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (!self.isFail) {
                    self.showNextPoker();
                }
            });
        }
    }];
    
    [leftPokerView setPokerWithType:leftType number:leftPokerNum];
    [middlePokerView setPokerWithType:middleType number:middlePokerNum];
    [rightPokerView setPokerWithType:rightType number:rightPokerNum];
    
    return result;
}

- (void)removePokerView {
    if (self.pokerArr.count >= 15) {
        for (int i = 2; i >= 0; i--) {
            [self.pokerArr removeObjectAtIndex:i];
        }
    }
}

- (BOOL)selectSamePokerWithIndex:(NSInteger)index {
    BOOL result = NO;
    
    if (index == 0) {
        result = _same1;
    } else if (index == 1) {
        result = _same2;
    } else {
        result = _same3;
    }
    
    if (index == 0) {
        _selectSame1 = YES;
    } else if (index == 1) {
        _selectSame2 = YES;
    } else {
        _selectSame3 = YES;
    }
    
    if (_selectSame1 == _same1 && _selectSame2 == _same2 && _selectSame3 == _same3) {
        self.selectSamePokerSucess(_pokerCount == 9);
    }
    
    return result;
}

- (void)resumeData {
    for (UIView *subV in self.pokerArr) {
        [subV removeFromSuperview];
    }
    [self.pokerArr removeAllObjects];
    self.pokerArr = nil;
}

@end
