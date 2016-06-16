//
//  WNXStage08PeopleView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/4/11.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage08PeopleView.h"

@interface WNXStage08PeopleView ()
{
    BOOL _isModel1;
    BOOL _isModel2;
    BOOL _isModel3;
    int _ms;
    int _count;
    BOOL _isPlayAgain;
    BOOL _isPasue;
    
    int _takeDuration;
}
@property (weak, nonatomic) IBOutlet UIImageView *peopleIV1;
@property (weak, nonatomic) IBOutlet UIImageView *peopleIV2;
@property (weak, nonatomic) IBOutlet UIImageView *people3;
@property (weak, nonatomic) IBOutlet UIImageView *curtainLeft;
@property (weak, nonatomic) IBOutlet UIImageView *curtainRight;

@property (nonatomic, strong) CADisplayLink *timer;

@end

@implementation WNXStage08PeopleView

- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTimer) name:kNotificationNameGameViewControllerDelloc object:nil];
}

- (void)removeTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self removeFromSuperview];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showModel {
    _isPlayAgain = NO;
    _count++;
    _isModel1 = NO;
    _isModel2 = NO;
    _isModel3 = NO;
    while ((_isModel1 == NO && _isModel2 == NO && _isModel3 == NO) || (_isModel1 && _isModel2 && _isModel3)) {
        _isModel1 = (int)arc4random_uniform(2);
        _isModel2 = (int)arc4random_uniform(2);
        _isModel3 = (int)arc4random_uniform(2);
    }
    
    if (_count == 12) {
        _isModel1 = YES;
        _isModel2 = YES;
        _isModel3 = YES;
    }
    
    if (_isModel1) {
        self.peopleIV1.image = [UIImage imageNamed:@"02_girl01-iphone4"];
    } else {
        self.peopleIV1.image = [UIImage imageNamed:@"02_robot01-iphone4"];
    }
    
    if (_isModel2) {
        self.peopleIV2.image = [UIImage imageNamed:@"02_girl02-iphone4"];
    } else {
        self.peopleIV2.image = [UIImage imageNamed:@"02_robot01-iphone4"];
    }
    
    if (_isModel3) {
        self.people3.image = [UIImage imageNamed:@"02_girl03-iphone4"];
    } else {
        self.people3.image = [UIImage imageNamed:@"02_robot01-iphone4"];
    }
    
    [self hiddenCurtain];
}

- (void)hiddenCurtain {
    NSTimeInterval duration;
    if (_count < 4) {
        duration = 0.2;
    } else if (_count < 8) {
        duration = 0.15;
    } else {
        duration = 0.1;
    }
    
    [UIView animateWithDuration:duration animations:^{
        self.curtainLeft.transform = CGAffineTransformMakeTranslation(-self.curtainLeft.frame.size.width, 0);
        self.curtainRight.transform = CGAffineTransformMakeTranslation(self.curtainRight.frame.size.width, 0);
    } completion:^(BOOL finished) {
        if (self.startTakePhoto && !_isPlayAgain && !_isPasue) {
            self.startTakePhoto();
            [self startTime];
        }
    }];
}

- (void)cleanDate {
    _isPlayAgain = YES;
    [self.timer invalidate];
    self.timer = nil;
    self.curtainLeft.transform = CGAffineTransformIdentity;
    self.curtainRight.transform = CGAffineTransformIdentity;
    _count = 0;
    _ms = 0;
}

//#warning 重写动画 暂停需要用CADisplayLink或者CoreAnimation

- (void)showCurtain {
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundSayOKName];
    
    NSTimeInterval duration;
    if (_count < 4) {
        duration = 0.2;
    } else if (_count < 8) {
        duration = 0.15;
    } else {
        duration = 0.1;
    }
    
    [UIView animateWithDuration:duration animations:^{
        self.curtainLeft.transform = CGAffineTransformIdentity;
        self.curtainRight.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (self.nextTakePhoto && !_isPlayAgain && !_isPasue) {
            self.nextTakePhoto(_count == 12);
        }
    }];
}

- (void)stopTime {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)startTime {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    if (_count <= 3) {
        _takeDuration = 100;
    } else if (_count <= 6) {
        _takeDuration = 95;
    } else if (_count <= 9) {
        _takeDuration = 90;
    } else {
        _takeDuration = 85;
    }
     
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)pause {
    _isPasue = YES;
    self.timer.paused = YES;
}

- (void)resume {
    _isPasue = NO;
    self.timer.paused = NO;
}

- (void)updateTime {
    _ms++;

    if (_ms == _takeDuration) {
        _ms = 0;
        [self.timer invalidate];
        self.timer = nil;
        if (self.shopTakePhoto) {
            self.shopTakePhoto();
            [self showCurtain];
        }
    }
}

- (BOOL)takePhotoWithIndex:(int)index {
    BOOL isSucess;
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundTakePhotoName];
    switch (index) {
        case 0:
            if (_isModel1) {
                isSucess = YES;
            }
            [self showShadowWithIndex:0];
            break;
        case 1:
            if (_isModel2) {
                isSucess = YES;
            }
            [self showShadowWithIndex:1];
            break;
        case 2:
            if (_isModel3) {
                isSucess = YES;
            }
            [self showShadowWithIndex:2];
            break;
        default:
            break;
    }
    
    return isSucess;
}

- (void)showShadowWithIndex:(int)index {
    if (index == 0) {
        UIImage *image;
        UIImage *currentImage = self.peopleIV1.image;
        if (_isModel1) {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"02_girl010%d-iphone4", arc4random_uniform(2) + 1]];
        } else {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"02_robot010%d-iphone4", arc4random_uniform(2) + 1]];
        }
        self.peopleIV1.image = image;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.peopleIV1.image = currentImage;
        });
    } else if (index == 1) {
        UIImage *image;
        UIImage *currentImage = self.peopleIV2.image;
        if (_isModel2) {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"02_girl020%d-iphone4", arc4random_uniform(2) + 1]];
        } else {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"02_robot010%d-iphone4", arc4random_uniform(2) + 1]];
        }
        self.peopleIV2.image = image;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.peopleIV2.image = currentImage;
        });
    } else {
        UIImage *image;
        UIImage *currentImage = self.people3.image;
        if (_isModel3) {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"02_girl030%d-iphone4", arc4random_uniform(2) + 1]];
        } else {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"02_robot010%d-iphone4", arc4random_uniform(2) + 1]];
        }
        self.people3.image = image;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.people3.image = currentImage;
        });
    }
}

@end
