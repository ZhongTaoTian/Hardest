//
//  WNXDropEggView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXDropEggView.h"
#import "WNXStateView.h"
#import "WNXState12ResultView.h"

@interface WNXDropEggView ()
{
    CGAffineTransform _transform;
}

@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, strong) UIImageView *eggIV;
@property (nonatomic, assign) int speed;
@property (nonatomic, strong) UIImageView *handIV;

@end

@implementation WNXDropEggView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.eggIV = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 35) * 0.5, -44, 35, 44)];
        self.eggIV.image = [UIImage imageNamed:@"01_egg-iphone4"];
        [self addSubview:self.eggIV];
        
        self.handIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, -88, 80, 88)];
        self.handIV.hidden = YES;
        self.handIV.image = [UIImage imageNamed:@"01_holdhand-iphone4"];
        [self addSubview:self.handIV];
        
        _transform = CGAffineTransformMakeScale(1, 1);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTimer) name:kNotificationNameGameViewControllerDelloc object:nil];
    }
    
    return self;
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
    [self removeFromSuperview];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showDropEggWithSpeed:(int)speed {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }

    self.eggIV.transform = CGAffineTransformIdentity;
    self.eggIV.hidden = NO;
    _transform = CGAffineTransformIdentity;
    self.speed = speed;
    
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateTime {
    self.eggIV.transform = CGAffineTransformTranslate(_transform, 0, self.speed);
    _transform = self.eggIV.transform;
    
    if (self.eggIV.transform.ty > ScreenHeight - 190) {
        [self.timer invalidate];
        self.timer = nil;
            
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundEggHitName];
        if (self.failBlock) {
            self.failBlock(self.tag);
        }
        
    }
}

- (void)stopDropEgg {
    [self.timer invalidate];
    self.timer = nil;
}

- (NSInteger)grabEgg {
    [self.timer invalidate];
    self.timer = nil;
    self.eggIV.hidden = YES;
    
    return [self showHandAndResult];
}

- (NSInteger)showHandAndResult {
    NSInteger scroe;
    WNXResultStateType stateType;
    
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundEggYearName];
    
    self.handIV.frame = CGRectMake(0, self.eggIV.transform.ty - 44, 80, 88);
    self.handIV.hidden = NO;
    
    CGFloat toBottomMargin = ScreenHeight - 190 - self.eggIV.transform.ty;

    if (toBottomMargin < 20) {
        stateType = WNXResultStateTypePerfect;
    } else if (toBottomMargin < 50) {
        stateType = WNXResultStateTypeGreat;
    } else if (toBottomMargin < 100) {
        stateType = WNXResultStateTypeGood;
    } else {
        stateType = WNXResultStateTypeOK;
    }
    
    if (toBottomMargin < 20) {
        scroe = 10;
    } else if (toBottomMargin < 30) {
        scroe = 9;
    } else if (toBottomMargin < 40) {
        scroe = 8;
    } else if (toBottomMargin < 50) {
        scroe = 7;
    } else if (toBottomMargin < 60) {
        scroe = 6;
    } else if (toBottomMargin < 70) {
        scroe = 5;
    } else if (toBottomMargin < 80) {
        scroe = 4;
    } else if (toBottomMargin < 100) {
        scroe = 2;
    } else {
        scroe = 1;
    }
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - toBottomMargin + 12, self.frame.size.width, toBottomMargin - 12)];
    whiteView.transform = CGAffineTransformMakeScale(0, 0);
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.alpha = 0.6;
    [self addSubview:whiteView];
    
    WNXState12ResultView *resultView = [[WNXState12ResultView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(whiteView.frame) - 150, ScreenWidth / 3, 120)];
    resultView.alpha = 0;
    [self addSubview:resultView];
    [UIView animateWithDuration:0.1 animations:^{
        whiteView.transform = CGAffineTransformIdentity;
        resultView.alpha = 1;
    }];
    
    [resultView showStatusWithStateType:stateType score:scroe];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.handIV.hidden = YES;
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2 animations:^{
            whiteView.alpha = 0;
            resultView.alpha = 0;
        } completion:^(BOOL finished) {
            [whiteView removeFromSuperview];
            [resultView removeFromSuperview];
        }];
    });
    
    return scroe;
}

- (void)pause {
    self.timer.paused = YES;
}

- (void)resume {
    self.timer.paused = NO;
}

- (void)cleanData {
    self.failBlock = nil;
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
