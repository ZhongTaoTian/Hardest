//
//  WNXStage03HeaderView.m
//  Hardest
//
//  Created by MacBook on 16/3/27.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage03HeaderView.h"

typedef void (^FailBlock)();

@interface WNXStage03HeaderView ()
{
    CGFloat _rotationAngel;
    CGAffineTransform _transform;
    int _flag;
    int _index;
    int _random;
    int _speed;
}

@property (nonatomic, strong) UIImageView *headerIV;
@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, copy) FailBlock failBlock;
@property (nonatomic, assign) CGFloat angel;

@end

@implementation WNXStage03HeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _speed = 300;
        self.headerIV = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 200) * 0.5, 20, 200, 200)];
        self.headerIV.image = [UIImage imageNamed:@"23_boyhead-iphone4"];
        self.headerIV.layer.anchorPoint = CGPointMake(0.5, 0.7);
        [self addSubview:self.headerIV];
        
        UIImageView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerIV.frame) - 42, 320, 113)];
        bottomImageView.image = [UIImage imageNamed:@"23_boybody-iphone4"];
        [self insertSubview:bottomImageView belowSubview:self.headerIV];
        
        _transform = CGAffineTransformMakeRotation(0);
        int random = arc4random_uniform(2);
        self.angel = random == 0 ? M_PI_4 / _speed :  -M_PI_4 / _speed;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTimer) name:kNotificationNameGameViewControllerDelloc object:nil];
        _random = arc4random_uniform(2) + 2;
    }
    
    return self;
}

- (void)startWithFailBlock:(void (^)(void))failBlock {
    self.failBlock = failBlock;
    
    [self start];
}

- (void)start {
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime:)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateTime:(CADisplayLink *)timer {
    _flag++;
    _transform = CGAffineTransformRotate(_transform, self.angel);
    self.headerIV.transform = _transform;
    
    if (_transform.a <= 0.6) {
        [self.timer invalidate];
        self.timer = nil;
        if (self.failBlock) {
            self.failBlock();
        }
    }
    
    if (_flag == 60) {
        _index++;
        
        if (_index == _random) {
            _speed -= 50;
            int random = arc4random_uniform(2);
            self.angel = random == 0 ? M_PI_4 / _speed :  -M_PI_4 / _speed;
            _index = 0;
            _random = arc4random_uniform(2) + 2;
        }
        _flag = 0;
    }
}

- (void)leftBtnClick {
    _transform = CGAffineTransformRotate(_transform, -M_PI_4 / 20);
}

- (void)rightBtnClick {
    _transform = CGAffineTransformRotate(_transform, M_PI_4 / 20);
}


- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

@end
