//
//  WNXStage09BobmView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/4/12.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage09BobmView.h"
#import "WNXBobmView.h"
#import "WNXStage09ResultView.h"

@interface WNXStage09BobmView ()
{
    int _stopCount;
    int _count;
    int _ms;
    NSTimeInterval _allTime;
}

@property (nonatomic, strong) WNXBobmView *bobmView1;
@property (nonatomic, strong) WNXBobmView *bobmView2;
@property (nonatomic, strong) WNXBobmView *bobmView3;
@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, strong) WNXStage09ResultView *resultView1;
@property (nonatomic, strong) WNXStage09ResultView *resultView2;
@property (nonatomic, strong) WNXStage09ResultView *resultView3;

@end

@implementation WNXStage09BobmView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        __weak typeof(self) weakSelf = self;
        
        self.bobmView1 = [WNXBobmView viewFromNib];
        CGFloat bobmWidth = self.bobmView1.frame.size.width;
        CGFloat bobmHeight = self.bobmView1.frame.size.height;
        CGFloat startY = ScreenHeight * 0.5 - 60;
        CGFloat startX = (ScreenWidth / 3 - bobmWidth) * 0.5;
        self.bobmView1.frame = CGRectMake(startX, startY, bobmWidth, bobmHeight);
        self.bobmView1.timeOver = ^{
            [weakSelf bobmWithIndex:0];
        };
        [self addSubview:self.bobmView1];
        
        self.bobmView2 = [WNXBobmView viewFromNib];
        self.bobmView2.timeOver = ^{
            [weakSelf bobmWithIndex:1];
        };
        self.bobmView2.frame = CGRectMake(ScreenWidth / 3 + startX, startY, bobmWidth, bobmHeight);
        [self addSubview:self.bobmView2];
        
        self.bobmView3 = [WNXBobmView viewFromNib];
        self.bobmView3.timeOver = ^{
            [weakSelf bobmWithIndex:2];
        };
        self.bobmView3.frame = CGRectMake(ScreenWidth / 3 * 2 + startX, startY, bobmWidth, bobmHeight);
        [self addSubview:self.bobmView3];
        
        CGAffineTransform locationTF = CGAffineTransformMakeTranslation(0, -(startY + bobmHeight));
        self.bobmView3.transform = self.bobmView2.transform = self.bobmView1.transform = locationTF;
        
        self.resultView1 = [WNXStage09ResultView viewFromNib];
        CGFloat resultViewHeight = self.resultView1.frame.size.height;
        CGFloat resultViewWidth = self.resultView1.frame.size.width;
        CGFloat resultY = frame.size.height - resultViewHeight;
        self.resultView1.frame = CGRectMake(0, resultY, resultViewWidth, resultViewHeight);
        [self addSubview:self.resultView1];
        
        self.resultView2 = [WNXStage09ResultView viewFromNib];
        self.resultView2.frame = CGRectMake(ScreenWidth / 3, resultY, resultViewWidth, resultViewHeight);
        [self addSubview:self.resultView2];
        
        self.resultView3 = [WNXStage09ResultView viewFromNib];
        self.resultView3.frame = CGRectMake(ScreenWidth / 3 * 2, resultY, resultViewWidth, resultViewHeight);
        [self addSubview:self.resultView3];
        
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

- (void)bobmWithIndex:(int)index {
    self.superview.userInteractionEnabled = NO;
    [self.timer invalidate];
    self.timer = nil;
    [self bobmStopCount];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIImageView *failView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth / 3 * index, 0, ScreenWidth / 3, self.frame.size.height)];
        failView.image = [UIImage imageNamed:@"AAAA"];
        failView.alpha = 0;
        [self insertSubview:failView belowSubview:self.bobmView1];
        
        UIImageView *bobmAnimationIV = [[UIImageView alloc] initWithFrame:failView.frame];
        bobmAnimationIV.animationImages = @[[UIImage imageNamed:@"14_explosion01-iphone4"], [UIImage imageNamed:@"14_explosion02-iphone4"], [UIImage imageNamed:@"14_explosion03-iphone4"]];
        bobmAnimationIV.animationRepeatCount = 1;
        bobmAnimationIV.animationDuration = 0.3;
        [self insertSubview:bobmAnimationIV belowSubview:self.bobmView1];
        
        [bobmAnimationIV startAnimating];
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundLaunchBoum];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            failView.alpha = 1;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.failBlock();
            });
        });
    });
}

- (void)resumeLocation {
    CGFloat startY = ScreenHeight * 0.5 - 60;
    CGFloat bobmHeight = self.bobmView1.frame.size.height;
    CGAffineTransform locationTF = CGAffineTransformMakeTranslation(0, -(startY + bobmHeight));
    self.bobmView3.transform = self.bobmView2.transform = self.bobmView1.transform = locationTF;
    self.resultView3.hidden = YES;
    self.resultView2.hidden = YES;
    self.resultView1.hidden = YES;
}

- (void)bobmStopCount {
    [self.bobmView1 stopCountDown];
    [self.bobmView2 stopCountDown];
    [self.bobmView3 stopCountDown];
}

- (void)stopCountWithIndex:(int)index {
    NSTimeInterval stopTime;
    switch (index) {
        case 0:
            stopTime = [self.bobmView1 stopCountDown];
            [self.resultView1 showResultViewWithTime:stopTime];
            break;
        case 1:
            stopTime = [self.bobmView2 stopCountDown];
            [self.resultView2 showResultViewWithTime:stopTime];
            break;
        case 2:
            stopTime = [self.bobmView3 stopCountDown];
            [self.resultView3 showResultViewWithTime:stopTime];
            break;
        default:
            break;
    }
    
    _allTime += stopTime;
    [self showKaCViewWithIndex:index];
    
    _stopCount++;
    if (_stopCount == 3) {
        [self.timer invalidate];
        self.timer = nil;
        if (_count == 4) {
            self.passBlock(_allTime / 12.0);
        } else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self resumeLocation];
                self.nextBlock();
            });
        }
    }
}

- (void)showKaCViewWithIndex:(int)index {
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundKaChaName];
    UIView *lightView = [[UIView alloc] initWithFrame:CGRectMake(index * (ScreenWidth / 3), 0, ScreenWidth / 3, self.frame.size.height)];
    lightView.backgroundColor = [UIColor whiteColor];
    lightView.alpha = 0.7;
    [self insertSubview:lightView belowSubview:self.bobmView1];
    
    [UIView animateWithDuration:0.15 animations:^{
        lightView.alpha = 0;
    } completion:^(BOOL finished) {
        [lightView removeFromSuperview];
    }];
}

- (void)showBobm {
    self.hidden = NO;
    _stopCount = 0;
    _count++;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bobmView1.transform = self.bobmView2.transform = self.bobmView3.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundPaName];
        self.superview.userInteractionEnabled = YES;
        [self.bobmView1 startCountDown];
        [self.bobmView2 startCountDown];
        [self.bobmView3 startCountDown];
        self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
        [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }];
}

- (void)cleanData {
    self.hidden = YES;
    _stopCount = 0;
    _allTime = 0;
    _count = 0;
    [self.bobmView1 clean];
    [self.bobmView2 clean];
    [self.bobmView3 clean];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self resumeLocation];
    self.resultView1.hidden = YES;
    self.resultView2.hidden = YES;
    self.resultView3.hidden = YES;
}

- (void)updateTime {
    _ms++;
    if (_ms == 40) {
        _ms = 0;
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundCountDownName];
    }
}

- (void)pause {
    self.timer.paused = YES;
    [self.bobmView1 pasueCountDown];
    [self.bobmView2 pasueCountDown];
    [self.bobmView3 pasueCountDown];
}

- (void)resume {
    self.timer.paused = NO;
    [self.bobmView1 resumeCountDown];
    [self.bobmView2 resumeCountDown];
    [self.bobmView3 resumeCountDown];
}

@end
