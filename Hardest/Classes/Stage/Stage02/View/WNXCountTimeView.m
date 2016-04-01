//
//  WNXCountTimeView.m
//  Hardest
//
//  Created by sfbest on 16/3/21.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXCountTimeView.h"
#import "WNXStrokeLabel.h"

@interface WNXCountTimeView ()
{
    int _index;
    int _ms;
}
@property (weak, nonatomic) IBOutlet WNXStrokeLabel *countLabel;
@property (weak, nonatomic) IBOutlet WNXStrokeLabel *unitLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, strong) CADisplayLink *timer;

@end

@implementation WNXCountTimeView

- (void)awakeFromNib {
    self.clipsToBounds = NO;
    [self.countLabel setTextStorkeWidth:3];
    [self.unitLabel setTextStorkeWidth:3];
    
    self.layer.anchorPoint = CGPointMake(0, 1);
    self.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [self.backgroundImageView cleanSawtooth];
    
    UIFont *font1 = [UIFont fontWithName:@"TransformersMovie" size:90];
    UIFont *font2 = [UIFont fontWithName:@"TransformersMovie" size:40];
    if (font1 && font2) {
        self.countLabel.font = font1;
        self.unitLabel.font = font2;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTimer) name:kNotificationNameGameViewControllerDelloc object:nil];
}

- (void)startAnimationWithCompletion:(void (^)(BOOL))completion {
    [UIView animateWithDuration:0.4 animations:^{
        self.transform = CGAffineTransformMakeRotation(M_PI_4 / 8);
    } completion:^(BOOL finished) {
        if (completion) {
            completion(YES);
        }
    }];
}

- (void)startCalculateByTimeWithTimeOut:(void (^)())timeOutBlock {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime:)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    self.TimeOutBlock = timeOutBlock;
}

- (void)updateTime:(CADisplayLink *)timer {
    _index++;
    if (_index == 60) {
        _index = 0;
        _ms++;
        if (_ms == 10 && !self.notHasTimeOut) {
            [timer invalidate];
            if (self.TimeOutBlock) {
                self.TimeOutBlock();
            }
        }
    }
    self.countLabel.text = [NSString stringWithFormat:@"%d%02d", _ms, _index];
}

- (void)stopCalculateByTimeWithTimeBlock:(void (^)(int, int))timeBlock {
    [self.timer invalidate];
    self.timer = nil;
    timeBlock(_ms, _index);
    
    [UIView animateWithDuration:0.2 animations:^{
        self.countLabel.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.countLabel.transform = CGAffineTransformIdentity;
        }];
    }];
}

- (void)pause {
    self.timer.paused = YES;
}

- (void)continueGame {
    self.timer.paused = NO;
}

- (void)cleanData {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    _index = 0;
    _ms = 0;
    self.countLabel.text = [NSString stringWithFormat:@"%d%02d", _ms, _index];
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

@end
