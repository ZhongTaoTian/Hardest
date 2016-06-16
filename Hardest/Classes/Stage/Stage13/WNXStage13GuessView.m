//
//  WNXStage13GuessView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/5.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage13GuessView.h"

#define kSpeed 8
#define kToRightMaxDistance 500
#define kToLeftMinDistance -200

@interface WNXStage13GuessView ()
{
    int _count;
    BOOL _hasMan;
    BOOL _hasChild;
    BOOL _hasOld;
    BOOL _toRight;
    
    BOOL _rightSucess;
    BOOL _middleSucess;
    BOOL _leftSucess;
}

@property (nonatomic, strong) UIImageView *leftHandIV;
@property (nonatomic, strong) UIImageView *rightHandIV;

@property (nonatomic, strong) CADisplayLink *timer;

@property (nonatomic, strong) UIImageView *manIV;
@property (nonatomic, strong) UIImageView *childIV;
@property (nonatomic, strong) UIImageView *oldIV;

@end

@implementation WNXStage13GuessView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.oldIV = [[UIImageView alloc] init];
        self.oldIV.image = [UIImage imageNamed:@"11_grandma-iphone4"];
        [self addSubview:self.oldIV];
        
        self.manIV = [[UIImageView alloc] init];
        self.manIV.image = [UIImage imageNamed:@"11_dad-iphone4"];
        [self addSubview:self.manIV];
        
        self.childIV = [[UIImageView alloc] init];
        self.childIV.image = [UIImage imageNamed:@"11_boy-iphone4"];
        [self addSubview:self.childIV];
        
        self.leftHandIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height - 325, 190, 325)];
        self.leftHandIV.image = [UIImage imageNamed:@"11_hand-iphone4"];
        [self addSubview:self.leftHandIV];
        
        self.rightHandIV = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - 190, frame.size.height - 325, 190, 325)];
        self.rightHandIV.image = [UIImage imageNamed:@"11_hand-iphone4Right"];
        [self addSubview:self.rightHandIV];
        
        self.manIV.hidden = YES;
        self.childIV.hidden = YES;
        self.oldIV.hidden = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTimer) name:kNotificationNameGameViewControllerDelloc object:nil];
    }
    
    return self;
}

- (void)removeTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)startGuess {
    _count++;
    
    _hasMan = NO;
    _hasChild = NO;
    _hasOld = NO;
    _toRight = YES;
    
    self.manIV.hidden = YES;
    self.childIV.hidden = YES;
    self.oldIV.hidden = YES;
    
    _rightSucess = NO;
    _middleSucess = NO;
    _leftSucess = NO;
    
    self.leftHandIV.transform = CGAffineTransformIdentity;
    self.rightHandIV.transform = CGAffineTransformIdentity;
    
    self.manIV.frame = CGRectMake(0, self.frame.size.height - 150 - 100, 80, 150);
    self.childIV.frame = CGRectMake(0, self.frame.size.height - 121 - 50, 75, 121);
    self.oldIV.frame = CGRectMake(0, self.frame.size.height - 150 - 80 - 70, 80, 150);
    
    [UIView animateWithDuration:0.15 animations:^{
        self.leftHandIV.transform = CGAffineTransformMakeTranslation(-44, 0);
        self.rightHandIV.transform = CGAffineTransformMakeTranslation(44, 0);
    } completion:^(BOOL finished) {
        if (self.startCountTime) {
            self.startCountTime();
        }
        
        [self startAnimation];
        
    }];
}

- (void)startAnimation {
    
    [self setRandomPeople];
    
    if (_count < 5) {
        while ((_hasMan && _hasOld && _hasChild) || (_hasMan && _hasChild && !_hasOld) || (_hasMan && !_hasChild && _hasOld) || (!_hasMan && _hasChild && _hasOld) || (!_hasOld && !_hasMan && !_hasChild)) {
            [self setRandomPeople];
        }
    } else {
        while (!((_hasMan && _hasChild && _hasOld) || (_hasMan && _hasChild && !_hasOld) || (_hasMan && !_hasChild && _hasOld) || (!_hasMan && _hasChild && _hasOld))) {
            [self setRandomPeople];
        }
    }
    
    if (_hasMan && !_hasChild && !_hasOld) {
        
        [self setManIVHidden:NO childHidden:YES oldHiddeb:YES];
        self.manIV.frame = CGRectMake(0, self.frame.size.height - 150 - 80, 80, 150);
        
    } else if (_hasMan && _hasChild && !_hasOld) {
        
        [self setManIVHidden:NO childHidden:NO oldHiddeb:YES];
        self.manIV.frame = CGRectMake(0, self.frame.size.height - 150 - 100, 80, 150);
        self.childIV.frame = CGRectMake(0, self.frame.size.height - 121 - 60, 75, 121);
        
    } else if (_hasMan && _hasChild && _hasOld) {
        
        [self setManIVHidden:NO childHidden:NO oldHiddeb:NO];
        self.manIV.frame = CGRectMake(0, self.frame.size.height - 150 - 100, 80, 150);
        self.childIV.frame = CGRectMake(0, self.frame.size.height - 121 - 50, 75, 121);
        self.oldIV.frame = CGRectMake(0, self.frame.size.height - 150 - 80 - 70, 80, 150);
        
    } else if (_hasMan && !_hasChild && _hasOld) {
        
        [self setManIVHidden:NO childHidden:YES oldHiddeb:NO];
        self.manIV.frame = CGRectMake(0, self.frame.size.height - 150 - 80, 80, 150);
        self.oldIV.frame = CGRectMake(0, self.frame.size.height - 150 - 60 - 70, 80, 150);
        
    } else if (!_hasMan && _hasChild && !_hasOld) {
        
        [self setManIVHidden:YES childHidden:NO oldHiddeb:YES];
        self.childIV.frame = CGRectMake(0, self.frame.size.height - 150 - 80, 75, 121);
        
    } else if (!_hasMan && _hasChild && _hasOld) {
        [self setManIVHidden:YES childHidden:NO oldHiddeb:NO];
        self.oldIV.frame = CGRectMake(0, self.frame.size.height - 150 - 100, 80, 150);
        self.childIV.frame = CGRectMake(0, self.frame.size.height - 121 - 80, 75, 121);
        
    } else {
        [self setManIVHidden:YES childHidden:YES oldHiddeb:NO];
        self.oldIV.frame = CGRectMake(0, self.frame.size.height - 150 - 80, 80, 150);
    }
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateTime {
    
    if (self.manIV.frame.origin.x > kToRightMaxDistance || self.childIV.frame.origin.x > kToRightMaxDistance || self.oldIV.frame.origin.x > kToRightMaxDistance) {
        _toRight = NO;
    } else if (self.manIV.frame.origin.x < kToLeftMinDistance || self.childIV.frame.origin.x < kToLeftMinDistance || self.oldIV.frame.origin.x < kToLeftMinDistance) {
        _toRight = YES;
    }
    
    if (_toRight) {
        self.manIV.frame = CGRectMake(self.manIV.frame.origin.x + kSpeed, self.manIV.frame.origin.y, self.manIV.frame.size.width, self.manIV.frame.size.height);
        self.childIV.frame = CGRectMake(self.childIV.frame.origin.x + kSpeed, self.childIV.frame.origin.y, self.childIV.frame.size.width, self.childIV.frame.size.height);
        self.oldIV.frame = CGRectMake(self.oldIV.frame.origin.x + kSpeed, self.oldIV.frame.origin.y, self.oldIV.frame.size.width, self.oldIV.frame.size.height);
    } else {
        self.manIV.frame = CGRectMake(self.manIV.frame.origin.x - kSpeed, self.manIV.frame.origin.y, self.manIV.frame.size.width, self.manIV.frame.size.height);
        self.childIV.frame = CGRectMake(self.childIV.frame.origin.x - kSpeed, self.childIV.frame.origin.y, self.childIV.frame.size.width, self.childIV.frame.size.height);
        self.oldIV.frame = CGRectMake(self.oldIV.frame.origin.x - kSpeed, self.oldIV.frame.origin.y, self.oldIV.frame.size.width, self.oldIV.frame.size.height);
    }

    if (_toRight && ((self.manIV.frame.origin.x >= ScreenWidth / 2 && self.manIV.frame.origin.x < ScreenWidth / 2 + kSpeed) || (self.childIV.frame.origin.x >= ScreenWidth / 2 && self.childIV.frame.origin.x < ScreenWidth / 2 + kSpeed) || (self.childIV.frame.origin.x >= ScreenWidth / 2 && self.childIV.frame.origin.x < ScreenWidth / 2 + kSpeed))) {
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundAppearSoundName];
    } else if (!_toRight && ((self.manIV.frame.origin.x <= ScreenWidth / 2 && self.manIV.frame.origin.x > ScreenWidth / 2 - kSpeed) || (self.childIV.frame.origin.x <= ScreenWidth / 2 && self.childIV.frame.origin.x > ScreenWidth / 2 - kSpeed) || (self.oldIV.frame.origin.x <= ScreenWidth / 2 && self.oldIV.frame.origin.x > ScreenWidth / 2 - kSpeed))) {
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundAppearSoundName];
    }
}

- (void)setRandomPeople {
    _hasMan = arc4random_uniform(2);
    _hasChild = arc4random_uniform(2);
    _hasOld = arc4random_uniform(2);
}

- (void)setManIVHidden:(BOOL)man childHidden:(BOOL)child oldHiddeb:(BOOL)old {
    self.manIV.hidden = man;
    self.childIV.hidden = child;
    self.oldIV.hidden = old;
}

- (BOOL)guessPeopleWithGuessType:(WNXStage13GuessType)type {
    
    BOOL result = NO;
    
    if (type == WNXStage13GuessTypeMan) {
        result = _hasMan;
        _leftSucess = YES;
    }
    
    if (type == WNXStage13GuessTypeChild) {
        result = _hasChild;
        _middleSucess = YES;
    }
    
    if (type == WNXStage13GuessTypeOld) {
        result = _hasOld;
        _rightSucess = YES;
    }
    
    if (_hasMan && !_hasChild && !_hasOld) {
        if (_leftSucess) {
            self.nextCountWithSucess(_count == 19);
        }
    } else if (_hasMan && _hasChild && !_hasOld) {
        if (_leftSucess && _middleSucess) {
            self.nextCountWithSucess(_count == 19);
        }
    } else if (_hasMan && _hasChild && _hasOld) {
        if (_leftSucess && _middleSucess && _rightSucess) {
            self.nextCountWithSucess(_count == 19);
        }
    } else if (_hasMan && !_hasChild && _hasOld) {
        if (_leftSucess && _rightSucess) {
            self.nextCountWithSucess(_count == 19);
        }
    } else if (!_hasMan && _hasChild && !_hasOld) {
        if (_middleSucess) {
            self.nextCountWithSucess(_count == 19);
        }
    } else if (!_hasMan && _hasChild && _hasOld) {
        if (_middleSucess && _rightSucess) {
            self.nextCountWithSucess(_count == 19);
        }
    } else {
        if (_rightSucess) {
            self.nextCountWithSucess(_count == 19);
        }
    }
    
    return result;
}

- (void)showFailWithIsShowPeople:(BOOL)showPeople AnimationFinish:(void (^)(void))finish {
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    if (showPeople) {
        [self showRightResultPeople];
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        self.leftHandIV.transform = CGAffineTransformMakeTranslation(-145, 0);
        self.rightHandIV.transform = CGAffineTransformMakeTranslation(145, 0);
    }];
    
    [self showBadViewWithFinish:finish delayFinish:showPeople ? 1 : 0.5];
}

- (void)showRightResultPeople {
    if (_hasMan && !_hasChild && !_hasOld) {
        
        self.manIV.frame = CGRectMake(kCountStartX(80), self.frame.size.height - 150 - 80, 80, 150);
        
    } else if (_hasMan && _hasChild && !_hasOld) {
        
        self.manIV.frame = CGRectMake(50, self.frame.size.height - 150 - 100, 80, 150);
        self.childIV.frame = CGRectMake(ScreenWidth - 75 - 50, self.frame.size.height - 121 - 60, 75, 121);
        self.childIV.center = CGPointMake(self.childIV.center.x, self.manIV.center.y);
        
    } else if (_hasMan && _hasChild && _hasOld) {
        
        self.manIV.frame = CGRectMake(20, self.frame.size.height - 150 - 100, 80, 150);
        self.childIV.frame = CGRectMake(kCountStartX(75), self.frame.size.height - 121 - 50, 75, 121);
        self.childIV.center = CGPointMake(self.childIV.center.x, self.manIV.center.y);
        self.oldIV.frame = CGRectMake(ScreenWidth - 100, self.frame.size.height - 150 - 80 - 70, 80, 150);
        self.oldIV.center = CGPointMake(self.oldIV.center.x, self.manIV.center.y);
        
    } else if (_hasMan && !_hasChild && _hasOld) {
        
        self.manIV.frame = CGRectMake(40, self.frame.size.height - 150 - 60, 80, 150);
        self.oldIV.frame = CGRectMake(ScreenWidth - 120, self.frame.size.height - 150 - 60 - 70, 80, 150);
        self.oldIV.center = CGPointMake(self.oldIV.center.x, self.manIV.center.y);
        
    } else if (!_hasMan && _hasChild && !_hasOld) {
        
        self.childIV.frame = CGRectMake(kCountStartX(75), self.frame.size.height - 150 - 80, 75, 121);
        
    } else if (!_hasMan && _hasChild && _hasOld) {
        
        self.oldIV.frame = CGRectMake(50, self.frame.size.height - 150 - 100, 80, 150);
        self.childIV.frame = CGRectMake(ScreenWidth - 75 - 50, self.frame.size.height - 121 - 60, 75, 121);
        self.childIV.center = CGPointMake(self.childIV.center.x, self.oldIV.center.y);
        
    } else {
        
        self.oldIV.frame = CGRectMake(kCountStartX(80), self.frame.size.height - 150 - 80, 80, 150);
    }
}

- (void)showBadViewWithFinish:(void (^)(void))finish delayFinish:(NSTimeInterval)delay {
    UIImageView *errorView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 150) * 0.5, self.frame.size.height - 150, 150, 150)];
    errorView.image = [UIImage imageNamed:@"00_cross-iphone4"];
    [self addSubview:errorView];
    
    UIImageView *badView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 110, 80)];
    badView.layer.anchorPoint = CGPointMake(0, 0.5);
    badView.image = [UIImage imageNamed:@"00_bad-iphone4"];
    badView.center = CGPointMake(errorView.center.x - 70, errorView.center.y);
    [self addSubview:badView];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        badView.transform = CGAffineTransformMakeRotation(M_2_PI);
    } completion:^(BOOL finished) {
        [badView removeFromSuperview];
        [errorView removeFromSuperview];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (finish) {
                finish();
            }
        });
    }];
}

- (void)stopAnimationWithTimeOver {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    __weak typeof(self) weakSelf = self;
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundMoanName(arc4random_uniform(3) + 2)];
    [self showFailWithIsShowPeople:YES AnimationFinish:^{
        if (_count == 19) {
             self.nextCountWithSucess(YES);
        } else {
            weakSelf.nextCountWithError();
        }
    }];
}

- (void)stopAnimationWithFinish:(void (^)())finish {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.manIV.hidden = YES;
    self.childIV.hidden = YES;
    self.oldIV.hidden = YES;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.leftHandIV.transform = CGAffineTransformMakeTranslation(-80, 0);
        self.rightHandIV.transform = CGAffineTransformMakeTranslation(80, 0);
    } completion:^(BOOL finished) {
        if (finish) {
            finish();
        }
    }];
}

- (void)pause {
    self.timer.paused = YES;
}

- (void)resume {
    self.timer.paused = NO;
}

- (void)cleanData {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.manIV.hidden = YES;
    self.oldIV.hidden = YES;
    self.childIV.hidden = YES;
    _count = 0;
    self.leftHandIV.transform = CGAffineTransformIdentity;
    self.rightHandIV.transform = CGAffineTransformIdentity;
}

@end
