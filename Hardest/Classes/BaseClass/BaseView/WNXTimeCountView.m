//
//  WNXTimeCountView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/28.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//
//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXTimeCountView.h"
#import "WNXStrokeLabel.h"

@interface WNXTimeCountView ()
{
    CGAffineTransform _transform;
    int _ms;
    int _second;
    int _onceMS;
    int _onceSecond;
}

@property (weak, nonatomic) IBOutlet WNXStrokeLabel *label1;
@property (weak, nonatomic) IBOutlet WNXStrokeLabel *label2;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, strong) CADisplayLink *timer;

@end

@implementation WNXTimeCountView

- (void)awakeFromNib {
    [self.label1 setTextStorkeWidth:3];
    [self.label2 setTextStorkeWidth:3];
    
    self.layer.anchorPoint = CGPointMake(0, 1);
    self.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [self.backgroundImageView cleanSawtooth];
    
    UIFont *font1 = [UIFont fontWithName:@"TransformersMovie" size:110];
    UIFont *font2 = [UIFont fontWithName:@"TransformersMovie" size:50];
    if (font1 && font2) {
        self.label1.font = font1;
        self.label2.font = font2;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTimer) name:kNotificationNameGameViewControllerDelloc object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)startAnimationWithCompletion:(void (^)(BOOL))completion {
    [UIView animateWithDuration:0.4 animations:^{
        self.transform = CGAffineTransformMakeRotation(M_PI_4 / 8);
        _transform = self.transform;
    } completion:^(BOOL finished) {
        if (completion) {
            completion(YES);
        }
    }];
}

- (void)startCalculateTime {
    [self startCountWithOffsetX:15 offsetY:3];
    
    if (self.timer) {
        [self.timer invalidate];
    }
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime:)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (NSTimeInterval)stopCalculateTime {
    [self startCountWithOffsetX:-15 offsetY:-3];
    
    [self.timer invalidate];
    self.timer = nil;
    return _second + _ms / 60.0;
}

- (void)pause {
    [self startCountWithOffsetX:-15 offsetY:-3];
    self.timer.paused = YES;
}

- (NSTimeInterval)pasueTime {
    [self startCountWithOffsetX:-15 offsetY:-3];
    
    NSTimeInterval oneTime = _onceSecond + _onceMS / 60.0;
    _onceSecond = 0;
    _onceMS = 0;
    self.timer.paused = YES;
    return oneTime;
}

- (void)resumed {
    [self startCountWithOffsetX:15 offsetY:3];
    self.timer.paused = NO;
}

- (void)startCountWithOffsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY {
    [UIView animateWithDuration:0.05 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
    } completion:nil];
}

- (void)cleadData {
    [self.timer invalidate];
    self.timer = nil;
    
    self.transform = CGAffineTransformMakeRotation(-M_PI_2);;
    
    _ms = 0;
    _second = 0;
    self.label1.text = @"00";
    self.label2.text = @"00";
}

#pragma mark - Action
- (void)updateTime:(CADisplayLink *)timer {
    _ms++;
    _onceMS++;
    if (_ms == 60) {
        _ms = 0;
        _second++;
        if (_second < 10) {
            self.label1.text = [NSString stringWithFormat:@"%02d", _second];
        } else {
            self.label1.text = [NSString stringWithFormat:@"%d", _second];
        }
    }
    
    if (_onceMS == 60) {
        _onceSecond++;
        _onceMS = 0;
    }
    
    if (_ms < 10) {
        self.label2.text = [NSString stringWithFormat:@"%02d", _ms];
    } else {
        self.label2.text = [NSString stringWithFormat:@"%d", _ms];
    }
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

@end
