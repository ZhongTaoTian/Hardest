//
//  WNXPowerView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/16.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXPowerView.h"

@interface WNXPowerView ()
{
    int _count;
}

@property (weak, nonatomic) IBOutlet UIImageView *arrowIV;
@property (weak, nonatomic) IBOutlet UIImageView *redIV;
@property (weak, nonatomic) IBOutlet UIImageView *blackIV;
@property (weak, nonatomic) IBOutlet UIImageView *maxIV;
@property (weak, nonatomic) IBOutlet UIView *lineView1;
@property (weak, nonatomic) IBOutlet UIView *lineView2;
// 0 56 93 42
// 7 52 79 5
@property (nonatomic, strong) CADisplayLink *timer;

@end

@implementation WNXPowerView

- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTimer) name:kNotificationNameGameViewControllerDelloc object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)startWithCount:(int)count {
    self.arrowIV.transform = CGAffineTransformIdentity;
    _count = 0;
    
    if (count > 4) {
        self.maxIV.hidden = YES;
    } else {
        self.maxIV.hidden = NO;
    }
    
    self.blackIV.hidden = NO;
    self.redIV.hidden = NO;
    self.lineView1.hidden = NO;
    self.lineView2.hidden = NO;
    
    if (count == 1) {
        self.redIV.frame = CGRectMake(0, 56, 93, 42);
        self.lineView1.frame = CGRectMake(7, 52, 79, 5);
        self.lineView2.frame = CGRectMake(7, CGRectGetMaxY(self.redIV.frame), 79, 5);
    } else if (count == 2) {
        self.redIV.frame = CGRectMake(0, 59, 93, 36);
        self.lineView1.frame = CGRectMake(7, 54, 79, 5);
        self.lineView2.frame = CGRectMake(7, CGRectGetMaxY(self.redIV.frame), 79, 5);
    } else if (count == 3) {
        self.redIV.frame = CGRectMake(0, 62, 93, 30);
        self.lineView1.frame = CGRectMake(7, 58, 79, 4);
        self.lineView2.frame = CGRectMake(7, CGRectGetMaxY(self.redIV.frame), 79, 4);
    } else if (count == 4) {
        self.redIV.frame = CGRectMake(0, 65, 93, 24);
        self.lineView1.frame = CGRectMake(7, 62, 79, 3);
        self.lineView2.frame = CGRectMake(7, CGRectGetMaxY(self.redIV.frame), 79, 3);
    } else if (count == 5) {
        self.redIV.frame = CGRectMake(0, 68, 93, 18);
        self.lineView1.frame = CGRectMake(7, 65.5, 79, 2.5);
        self.lineView2.frame = CGRectMake(7, CGRectGetMaxY(self.redIV.frame), 79, 2.5);
    } else {
        self.redIV.frame = CGRectMake(0, 71, 93, 12);
        self.lineView1.frame = CGRectMake(7, 69, 79, 2);
        self.lineView2.frame = CGRectMake(7, CGRectGetMaxY(self.redIV.frame), 79, 2);
    }
    
    [self bringSubviewToFront:self.arrowIV];
    
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateTime {
    _count++;
    self.arrowIV.transform = CGAffineTransformMakeTranslation(0, -_count * 7);
    if (self.arrowIV.transform.ty <= -305) {
        [self.timer invalidate];
        self.timer = nil;
        if (self.failBlock) {
            self.failBlock();
        }
    }
}

- (void)resumeData {
    [self.timer invalidate];
    self.timer = nil;
    
    _count = 0;
    
    self.lineView1.hidden = YES;
    self.lineView2.hidden = YES;
    self.redIV.hidden = YES;
    self.maxIV.hidden = YES;
    self.blackIV.hidden = YES;
    self.arrowIV.transform = CGAffineTransformIdentity;
}

- (int)stopCount {
    int score = 1000;
    [self.timer invalidate];
    self.timer = nil;
    
    CGFloat ty = self.arrowIV.transform.ty;
    
    if (self.redIV.frame.size.height == 42) {
        if (ty <= -215 && ty >= -248) {
            score = 100;
        } else if (ty < -248) {
            score = 0;
        } else if (ty > -215){
            score = -ty * 0.46;
        }
    }
    
    if (self.redIV.frame.size.height == 36) {
        if (ty <= -218 && ty >= -255) {
            score = 100;
        } else if (ty < -245) {
            score = 0;
        } else if (ty > -218) {
            score = -ty * 0.45;
        }
    }
    
    if (self.redIV.frame.size.height == 30) {
        if (ty <= -221 && ty >= -252) {
            score = 100;
        } else if (ty < -242) {
            score = 0;
        } else if (ty > -221) {
            score = -ty * 0.45;
        }
    }
    
    if (self.redIV.frame.size.height == 24) {
        if (ty <= -224 && ty >= -249) {
            score = 100;
        } else if (ty < -239) {
            score = 0;
        } else if (ty > -224) {
            score = -ty * 0.44;
        }
    }
    
    if (self.redIV.frame.size.height == 18) {
        if (ty <= -227 && ty >= -246) {
            score = 100;
        } else if (ty < -236) {
            score = 0;
        } else if (ty > -227) {
            score = -ty * 0.44;
        }
    }
    
    if (self.redIV.frame.size.height == 12) {
        if (ty <= -230 && ty >= -243) {
            score = 100;
        } else if (ty < -233) {
            score = 0;
        } else if (ty > -230) {
            score = -ty * 0.43;
        }
    }
    
    return score;
}

- (void)pause {
    self.timer.paused = YES;
}

- (void)resume {
    self.timer.paused = NO;
}

@end
