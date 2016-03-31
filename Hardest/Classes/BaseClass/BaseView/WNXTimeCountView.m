//
//  WNXTimeCountView.m
//  Hardest
//
//  Created by sfbest on 16/3/28.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXTimeCountView.h"
#import "WNXStrokeLabel.h"

@interface WNXTimeCountView ()
{
    CGAffineTransform _transform;
    int _ms;
    int _second;
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
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime:)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (NSTimeInterval)stopCalculateTime {
    [self.timer invalidate];
    self.timer = nil;
    return _second + _ms / 60;
}

- (void)pause {
    self.timer.paused = YES;
}

- (void)resumed {
    self.timer.paused = NO;
}

#pragma mark - Action
- (void)updateTime:(CADisplayLink *)timer {
    _ms++;
    
    if (_ms == 60) {
        _ms = 0;
        _second++;
        if (_second < 10) {
            self.label1.text = [NSString stringWithFormat:@"%02d", _second];
        } else {
            self.label1.text = [NSString stringWithFormat:@"%d", _second];
        }
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
