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
    _ms = arc4random_uniform(61);
    if (_ms >= 10) {
        self.countDownLabel.text = [NSString stringWithFormat:@"%d:%d", _s, _ms];
    } else {
        self.countDownLabel.text = [NSString stringWithFormat:@"%d:%02d", _s, _ms];
    }
}

- (void)startCountDown {
    
}

- (void)stopCountDown {}

- (void)pasueCountDown {}

- (void)resumeCountDown {}

@end
