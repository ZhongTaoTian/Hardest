//
//  WNXBobmView.m
//  Hardest
//
//  Created by sfbest on 16/4/12.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXBobmView.h"

@interface WNXBobmView ()
{
    int _s;
    int _ms;
}

@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
@property (nonatomic, strong) CADisplayLink *timer;

@end

@implementation WNXBobmView

- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTimer) name:kNotificationNameGameViewControllerDelloc object:nil];
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)randomCountDownTime {
    _s = arc4random_uniform(3) + 2;
    _ms = arc4random_uniform(60);
    if (_ms >= 10) {
        self.countDownLabel.text = [NSString stringWithFormat:@"%d:%d", _s, _ms];
    } else {
        self.countDownLabel.text = [NSString stringWithFormat:@"%d:%02d", _s, _ms];
    }
}

- (void)startCountDown {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.countDownLabel.alpha = 1;
    self.countDownLabel.textColor = [UIColor greenColor];
    _s = arc4random_uniform(4) + 4;
    _ms = arc4random_uniform(60);
    
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}


- (void)updateTime {
    _ms--;
    if (_ms < 0) {
        _ms = 60;
        _s--;
        if (_s < 0) {
            _s = 0;
            _ms = 0;
            [self.timer invalidate];
            self.timer = nil;
            [self showTwinkleAnimation];
        }
    }
    
    if (_s == 0) {
        self.countDownLabel.textColor = [UIColor redColor];
    }
    
    NSString *format;
    if (_ms >= 10) {
        format = @"%d:%d";
    } else {
        format = @"%d:%02d";
    }
    self.countDownLabel.text = [NSString stringWithFormat:format, _s, _ms];
}

- (void)showTwinkleAnimation {
    self.timeOver();
    [UIView animateWithDuration:0.1 animations:^{
        self.countDownLabel.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.countDownLabel.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                self.countDownLabel.alpha = 0;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    self.countDownLabel.alpha = 1;
                }];
            }];
        }];
    }];
}

- (void)stopCountDown {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)pasueCountDown {}

- (void)resumeCountDown {}

@end
