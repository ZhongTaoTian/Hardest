//
//  WNXStage10View.m
//  Hardest
//
//  Created by MacBook on 16/4/23.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage10View.h"

typedef NS_ENUM(NSInteger, LeftType) {
    LeftTypeYellow = 0,
    LeftTypeBlue,
    LeftTypeNotRed,
    LeftTypeNotYellow,
    LeftTypeNotBlue,
    LeftTypeRed
};

typedef NS_ENUM(NSInteger, RigthType) {
    RigthTypeX1 = 0,
    RigthTypeX2,
    RigthTypeX3,
    RigthTypeX4,
    RigthTypeX5,
    RigthTypeX6,
};

@interface WNXStage10View()
{
    CGAffineTransform _leftTranform;
    CGAffineTransform _rightTranform;
    int _index;
    int _index2;
    int _rotationIndex;
    int _rotationIndex2;
    int _lastType;
    int _lastType2;
    int _lastClickIndex;
    int _clickCount;
    BOOL _isPass;
    BOOL _isFrist;
    int _count;
}

@property (strong, nonatomic)  UIImageView *leftPlateView;
@property (strong, nonatomic)  UIImageView *rightPlateView;
@property (nonatomic, assign) LeftType leftType;
@property (nonatomic, assign) RigthType rightType;

@property (nonatomic, strong) CADisplayLink *timer1;
@property (nonatomic, strong) CADisplayLink *timer2;

@property (nonatomic, assign) int animFinishCount;

@end

@implementation WNXStage10View

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.rightPlateView = [[UIImageView alloc] initWithFrame:CGRectMake(134, 47, 400, 400)];
        self.rightPlateView.image = [UIImage imageNamed:@"08_right-iphone4"];
        [self addSubview:self.rightPlateView];
        
        self.leftPlateView = [[UIImageView alloc] initWithFrame:CGRectMake(-200, 47, 400, 400)];
        self.leftPlateView.image = [UIImage imageNamed:@"08_left-iphone4"];
        
        [self addSubview:self.leftPlateView];
        
        _leftTranform = CGAffineTransformMakeScale(1, 1);
        _rightTranform = CGAffineTransformRotate(CGAffineTransformMakeScale(1, 1), M_PI + M_PI / 3);
        self.rightPlateView.transform = _rightTranform;
        
        [self cleanSawtoothGreat];
        
        _lastClickIndex = -1;
        _isFrist = YES;
        self.isAnimation = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTimer) name:kNotificationNameGameViewControllerDelloc object:nil];
    }
    
    return self;
}

- (void)removeTimer {
    [self killTime];
}

- (void)dealloc {
    [self killTime];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)killTime {
    [self.timer1 invalidate];
    self.timer1 = nil;
    
    [self.timer2 invalidate];
    self.timer2 = nil;
}

- (void)cleanSawtoothGreat {
    self.rightPlateView.layer.borderWidth = 10;
    self.rightPlateView.layer.borderColor = [UIColor clearColor].CGColor;
    
    self.leftPlateView.layer.borderColor = [UIColor clearColor].CGColor;
    self.leftPlateView.layer.borderWidth = 10;
}

- (void)startRotation {
    _lastClickIndex = -1;
    _clickCount = 0;
    _isPass = NO;
    _count++;
    self.animFinishCount = 0;
    
    _leftTranform = CGAffineTransformMakeScale(1, 1);
    _rightTranform = CGAffineTransformRotate(CGAffineTransformMakeScale(1, 1), M_PI + M_PI / 3);
    
    self.leftType = arc4random_uniform(6);
    self.rightType = arc4random_uniform(6);
    
    [self.timer1 invalidate];
    self.timer1 = nil;
    
    [self.timer2 invalidate];
    self.timer2 = nil;
    
    _rotationIndex = self.leftType * 10;
    _rotationIndex2 = self.rightType * 10;
    
    self.isAnimation = YES;
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundRollingName2];
    self.timer1 = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
    [self.timer1 addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.timer2 = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime2)];
        [self.timer2 addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    });
}

- (void)setAnimFinishCount:(int)animFinishCount {
    _animFinishCount = animFinishCount;
    if (_animFinishCount == 2) {
        // 动画完成
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundJackpotStop];
        self.AnimationFinishBlock(_isFrist);
        self.isAnimation = NO;
        _isFrist = NO;
    }
}

- (void)updateTime {
    _index++;
    _leftTranform = CGAffineTransformRotate(_leftTranform, M_PI / 3 / 10);
    self.leftPlateView.transform = _leftTranform;
    
    if (_index == (60 + _rotationIndex)) {
        self.animFinishCount++;
        [self.timer1 invalidate];
        self.timer1 = nil;
        _index = 0;
        [self cleanSawtoothGreat];
    }
}

- (void)updateTime2 {
    _index2++;
    _rightTranform = CGAffineTransformRotate(_rightTranform, -M_PI / 3 / 10);
    self.rightPlateView.transform = _rightTranform;
    
    if (_index2 == (60 + _rotationIndex2)) {
        self.animFinishCount++;
        [self.timer2 invalidate];
        self.timer2 = nil;
        _index2 = 0;
        [self cleanSawtoothGreat];
    }
}

- (BOOL)clickWithIndex:(int)index {
    
    if (_lastClickIndex != -1 && _lastClickIndex != index) {
        _isPass = NO;
        return NO;
    }
    
    _lastClickIndex = index;
    
    BOOL result;
    if (index == 0) {
        result = (self.leftType == LeftTypeRed || self.leftType == LeftTypeNotYellow || self.leftType == LeftTypeNotBlue) && (_clickCount < self.rightType + 1);
    } else if (index == 1) {
        result = (self.leftType == LeftTypeYellow || self.leftType == LeftTypeNotRed || self.leftType == LeftTypeNotBlue) && (_clickCount < self.rightType + 1);
    } else if (index == 2) {
        result = (self.leftType == LeftTypeBlue || self.leftType == LeftTypeNotYellow || self.leftType == LeftTypeNotRed) && (_clickCount < self.rightType + 1);
    }
    _isPass = NO;
    _clickCount++;
    if (!result) {
        return result;
    }
    if (_clickCount == self.rightType + 1) {
        self.StopCountTimeBlock();
        _isPass = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (_isPass) {
                if (_count == 10) {
                    self.PassStageBlock();
                } else {
                    self.NextBlock();
                }
            }
        });
    }
    
    return result;
}

- (void)pause {
    self.timer1.paused = YES;
    self.timer2.paused = YES;
}

- (void)resume {
    self.timer2.paused = NO;
    self.timer1.paused = NO;
}

- (void)cleanData {
    [self killTime];
    _lastClickIndex = -1;
    _clickCount = 0;
    _isPass = NO;
    _count = 0;
    self.animFinishCount = 0;
    self.isAnimation = NO;
    _index = 0;
    _index2 = 0;
    _isFrist = YES;
    
    _leftTranform = CGAffineTransformMakeScale(1, 1);
    self.leftPlateView.transform = _leftTranform;
    
    _rightTranform = CGAffineTransformRotate(CGAffineTransformMakeScale(1, 1), M_PI + M_PI / 3);
    self.rightPlateView.transform = _rightTranform;
    
    [self cleanSawtoothGreat];
}

@end
