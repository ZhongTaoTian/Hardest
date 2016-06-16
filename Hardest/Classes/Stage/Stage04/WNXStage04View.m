//
//  WNXStage04View.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/31.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage04View.h"

#define kStepsHeight 25
#define kStepsWidth 35

@interface WNXStage04View ()
{
    int _randomIndex;
    int _runCount;
    BOOL _isMove;
    BOOL _isSucceed;
    int _startCount;
    CGAffineTransform _bgTransform;
}

@property (nonatomic, strong) UIImageView *peopleIV;
@property (nonatomic, strong) UIImageView *toiletIV;
@property (nonatomic, strong) NSMutableArray *stepsArr;
@property (nonatomic, strong) UIImageView *bottomView;
@property (nonatomic, strong) UIImageView *failIV;

@end

@implementation WNXStage04View

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.stepsArr = [NSMutableArray array];
        self.peopleIV = [[UIImageView alloc] initWithFrame:CGRectMake(50, frame.size.height - 148 - kStepsHeight, 100, 154)];
        self.peopleIV.image = [UIImage imageNamed:@"05_hold-iphone4"];
        [self addSubview:self.peopleIV];
        
        self.toiletIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 94)];
        self.toiletIV.image = [UIImage imageNamed:@"05_commode-iphone4"];
        [self addSubview:self.toiletIV];
        
        self.bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height - kStepsHeight, ScreenWidth, kStepsHeight)];
        self.bottomView.image = [UIImage imageNamed:@"05_floor-iphone4"];
        [self addSubview:self.bottomView];
        
        self.peopleIV.animationRepeatCount = 1;
        self.peopleIV.animationDuration = 0.3;
        
        self.failIV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 100, frame.size.height - 50 - kStepsHeight, 100, 160)];
        self.failIV.transform = CGAffineTransformMakeScale(1, 0);
        self.failIV.layer.anchorPoint = CGPointMake(0.5, 1);
        self.failIV.image = [UIImage imageNamed:@"05_water-iphone4"];
        [self addSubview:self.failIV];
    }
    
    return self;
}

- (void)start {
    _startCount++;
    _runCount = 0;
    _bgTransform = CGAffineTransformMakeTranslation(0, 0);
    self.peopleIV.transform = CGAffineTransformIdentity;
    self.peopleIV.frame = CGRectMake(50, self.frame.size.height - 148 - kStepsHeight, 100, 154);
    if ([self.peopleIV isAnimating]) {
        [self.peopleIV stopAnimating];
    }
    self.peopleIV.animationImages = nil;
    self.peopleIV.image = [UIImage imageNamed:@"05_hold-iphone4"];
    self.bgIV.transform = CGAffineTransformIdentity;
    self.peopleIV.transform = CGAffineTransformIdentity;
    if (_isMove) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - kStepsHeight, self.frame.size.width, self.frame.size.height);
    }
    self.bgIV.superview.userInteractionEnabled = YES;
    _isMove = NO;
    self.bottomView.hidden = NO;
    if (self.stepsArr.count > 0) {
        for (UIView *subView in self.stepsArr) {
            [subView removeFromSuperview];
        }
    }
    
    _randomIndex = arc4random_uniform(15) + 1;
    for (int i = 0; i < _randomIndex; i++) {
        UIImageView *stepsIV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.peopleIV.frame) - 23 + i * kStepsWidth, self.frame.size.height - kStepsHeight - i * kStepsHeight - kStepsHeight, kStepsWidth, kStepsHeight)];
        stepsIV.image = [UIImage imageNamed:@"05_stair-iphone4"];
        stepsIV.tag = i + 100;
        [self.stepsArr addObject:stepsIV];
        [self addSubview:stepsIV];
        
        if (i == _randomIndex - 1) {
            stepsIV.frame = CGRectMake(CGRectGetMaxX(self.peopleIV.frame) - 23 + i * kStepsWidth, self.frame.size.height - kStepsHeight - i * kStepsHeight - kStepsHeight, 70, kStepsHeight);
            self.toiletIV.frame = CGRectMake(CGRectGetMaxX(self.peopleIV.frame) - 23 + 11 + i * kStepsWidth, self.frame.size.height - kStepsHeight - i * kStepsHeight - kStepsHeight - 74, 50, 78);
        }
    }
    
    [self bringSubviewToFront:self.peopleIV];
    self.btnToFront();
}

- (void)runLeft {
    [self runWithIsLeft:YES];
}

- (void)runRight {
    [self runWithIsLeft:NO];
}

- (void)runWithIsLeft:(BOOL)isLeft {
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundGoUpstairs];
    _runCount++;
    _isSucceed = NO;
    if (_runCount > _randomIndex) {
        self.bgIV.superview.userInteractionEnabled = NO;
        [self failAnimation];
        return;
    }
    
    if (_runCount < 3) {
        [UIView animateWithDuration:0.2 animations:^{
            self.peopleIV.frame = CGRectMake(self.peopleIV.frame.origin.x + kStepsWidth, self.peopleIV.frame.origin.y - kStepsHeight, self.peopleIV.frame.size.width, self.peopleIV.frame.size.height);
        }];
    } else {
        if (_runCount == 3) {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + kStepsHeight, self.frame.size.width, self.frame.size.height);
            _isMove = YES;
            self.bottomView.hidden = YES;
        } else {
            self.bgIV.transform = CGAffineTransformTranslate(_bgTransform, 0, 2);
            _bgTransform = self.bgIV.transform;
        }
        for (UIView *view in self.stepsArr) {
            [UIView animateWithDuration:0.2 animations:^{
                view.frame = CGRectMake(view.frame.origin.x - kStepsWidth, view.frame.origin.y + kStepsHeight, view.frame.size.width, view.frame.size.height);
            }];
        }
        
        [UIView animateWithDuration:0.2 animations:^{
            self.toiletIV.frame = CGRectMake(self.toiletIV.frame.origin.x - kStepsWidth, self.toiletIV.frame.origin.y + kStepsHeight, self.toiletIV.frame.size.width, self.toiletIV.frame.size.height);
        }];
        
        UIView *view = [self viewWithTag:_runCount - 3 + 100];
        view.hidden = YES;
    }
    
    if (self.peopleIV.isAnimating) {
        [self.peopleIV startAnimating];
    }
    
    if (isLeft) {
        self.peopleIV.animationImages = @[[UIImage imageNamed:@"05_walk01-iphone4"], [UIImage imageNamed:@"05_walk02-iphone4"]];
    } else {
        self.peopleIV.animationImages = @[[UIImage imageNamed:@"05_walk03-iphone4"], [UIImage imageNamed:@"05_walk04-iphone4"]];
    }
    
    [self.peopleIV startAnimating];
    
    if (_runCount == _randomIndex) {
        _isSucceed = YES;
        if (self.stopTime) {
            self.stopTime(_randomIndex);
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self succeedAnimation];
        });
    }
}
- (void)succeedAnimation {
    [self.bgIV.superview setUserInteractionEnabled:NO];
    // 成功回调
    if (_isSucceed) {
        self.peopleIV.image = [UIImage imageNamed:@"05_success01-iphone4"];
        [UIView animateWithDuration:0.2 animations:^{
            self.peopleIV.transform = CGAffineTransformMakeTranslation(25, 0);
        } completion:^(BOOL finished) {
            [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundStage04Name];
            self.peopleIV.image = [UIImage imageNamed:@"05_success02-iphone4"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.showResult();
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.stopAnimationDidFinish();
                if (_startCount == 9) {
                    self.passStage();
                }
            });
        }];
    }
}

- (void)failAnimation {
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundFailToJumpName];
    CGAffineTransform failTransform = CGAffineTransformRotate(self.peopleIV.transform, M_PI_4);
    failTransform = CGAffineTransformTranslate(failTransform, 100, -80);
    [UIView animateWithDuration:0.2 animations:^{
        self.peopleIV.transform = failTransform;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.peopleIV.frame = CGRectMake(self.peopleIV.frame.origin.x, self.peopleIV.frame.origin.y + 300, 100, 154);
        } completion:^(BOOL finished) {
            [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundWaterName];
            [UIView animateWithDuration:0.2 animations:^{
                self.failIV.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    self.failIV.transform = CGAffineTransformMakeScale(1, 0.9);
                } completion:^(BOOL finished) {
                    self.failBlock();
                }];
            }];
        }];
    }];
}

- (void)playAgain {
    _startCount = 0;
    [self start];
}

@end
