//
//  WNXBusView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/27.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXBusView.h"

typedef NS_ENUM(NSInteger, WNXDirectionType) {
    WNXDirectionTypeLeft = 0,
    WNXDirectionTypeRight
};

@interface WNXBusView ()
{
    int _count;
    float _speed;
    
    int _redBoyNum;
    int _yellowGirlNum;
    int _blueBoyNum;
    
    BOOL _fail;
}

@property (nonatomic, strong) CADisplayLink *timer;

@property (nonatomic, strong) NSMutableArray *numArr;
@property (nonatomic, strong) NSMutableArray *windowArr;

@property (nonatomic, assign) WNXDirectionType direction;



@end

@implementation WNXBusView

- (void)awakeFromNib {
    self.numArr = [NSMutableArray array];
    self.windowArr = [NSMutableArray array];

    NSArray *frameArr = [NSArray arrayWithObjects:
                         NSStringFromCGRect(CGRectMake(69, 13, 87, 79)),
                         NSStringFromCGRect(CGRectMake(164, 13, 87, 79)),
                         NSStringFromCGRect(CGRectMake(261, 13, 87, 79)),
                         NSStringFromCGRect(CGRectMake(360, 13, 87, 79)),
                         NSStringFromCGRect(CGRectMake(455, 13, 87, 79)), nil];
    for (int i = 0; i < frameArr.count; i++) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectFromString(frameArr[i])];
        iv.image = [UIImage imageNamed:@"12_bus_Rgirl-iphone4"];
        [self.windowArr addObject:iv];
        iv.hidden = YES;
        [self addSubview:iv];
    }
    
    self.userInteractionEnabled = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTimer) name:kNotificationNameGameViewControllerDelloc object:nil];
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc {
    if (self.timer) {
        [self removeTimer];
    }

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showBus {
    _count++;
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundBusPassName];
    _redBoyNum = 0;
    _yellowGirlNum = 0;
    _blueBoyNum = 0;
    
    if (self.timer) {
        [self.timer invalidate];
    }
        
    int child1 = -100;
    int child2 = -100;
    int child3 = -100;
    int child4 = -100;
    int child5 = -100;
    
    [self.numArr removeAllObjects];
    
    if (_count <= 2) {
        child1 = arc4random_uniform(3);
        child2 = arc4random_uniform(3);
        [self.numArr addObject:[NSNumber numberWithInt:child1]];
        [self.numArr addObject:[NSNumber numberWithInt:child2]];
    } else if (_count <= 4) {
        child1 = arc4random_uniform(3);
        child2 = arc4random_uniform(3);
        child3 = arc4random_uniform(3);
        [self.numArr addObject:[NSNumber numberWithInt:child1]];
        [self.numArr addObject:[NSNumber numberWithInt:child2]];
        [self.numArr addObject:[NSNumber numberWithInt:child3]];
    } else if (_count <= 6) {
        child1 = arc4random_uniform(3);
        child2 = arc4random_uniform(3);
        child3 = arc4random_uniform(3);
        child4 = arc4random_uniform(3);
        [self.numArr addObject:[NSNumber numberWithInt:child1]];
        [self.numArr addObject:[NSNumber numberWithInt:child2]];
        [self.numArr addObject:[NSNumber numberWithInt:child3]];
        [self.numArr addObject:[NSNumber numberWithInt:child4]];
    } else {
        child1 = arc4random_uniform(3);
        child2 = arc4random_uniform(3);
        child3 = arc4random_uniform(3);
        child4 = arc4random_uniform(3);
        child5 = arc4random_uniform(3);
        [self.numArr addObject:[NSNumber numberWithInt:child1]];
        [self.numArr addObject:[NSNumber numberWithInt:child2]];
        [self.numArr addObject:[NSNumber numberWithInt:child3]];
        [self.numArr addObject:[NSNumber numberWithInt:child4]];
        [self.numArr addObject:[NSNumber numberWithInt:child5]];
    }
    
    for (int i = 0; i < self.numArr.count; i++) {
        int num = [self.numArr[i] intValue];
        UIImageView *windowIV = self.windowArr[i];
        windowIV.hidden = NO;
        
        if (num == 0) {
            windowIV.image = [UIImage imageNamed:@"12_bus_Bboy-iphone4"];
            _redBoyNum++;
        } else if (num == 1) {
            windowIV.image = [UIImage imageNamed:@"12_bus_Rgirl-iphone4"];
            _yellowGirlNum++;
        } else {
            windowIV.image = [UIImage imageNamed:@"12_bus_Yboy-iphone4"];
            _blueBoyNum++;
        }
    }
    
    if (_count % 2) {
        self.transform = CGAffineTransformIdentity;
        self.direction = WNXDirectionTypeLeft;
    } else {
        self.transform = CGAffineTransformScale(self.transform, -1, 1);
        self.direction = WNXDirectionTypeRight;
    }
    
    _speed = 10 + _count * 1.3;
    
    if (_speed >= 19) {
        _speed = 19;
    }
    
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateTime {

    self.transform = CGAffineTransformTranslate(self.transform, -_speed, 0);
    if ((self.transform.tx <= -self.frame.size.width * 2 && self.direction == WNXDirectionTypeLeft) || (self.transform.tx >= 0 && self.direction == WNXDirectionTypeRight)) {

        [self.timer invalidate];
        self.timer = nil;
        
        if (self.busPassFinish) {
            self.busPassFinish();
        }
    }
}

- (BOOL)guessWithIndex:(NSInteger)index {
    
    if (self.numArr.count == 0) {
        _fail = YES;
        return NO;
    }
    
    
    for (int i = 0; i < self.numArr.count; i++) {
        NSNumber *num = self.numArr[i];
        if (index == [num integerValue]) {
            
            [self.numArr removeObjectAtIndex:i];
            
            if (self.numArr.count == 0) {
                if (self.stopCountTime) {
                    self.stopCountTime();
                }
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (!_fail) {
                        if (self.guessSucess) {
                            self.guessSucess();
                        }
                    }
                });
                
            }
            
            return YES;
        }
    }
    
    return NO;
}

- (void)showCorrectBus {
    self.transform = CGAffineTransformMakeScale(0.5, 0.5);
}

- (void)pause {
    if (self.timer) {
        [self.timer setPaused:YES];
    }
}

- (void)resume {
    if (self.timer) {
        self.timer.paused = NO;
    }
}

- (void)removeData {
    [self removeTimer];
    
    self.busPassFinish = nil;
    self.guessSucess = nil;
    self.stopCountTime = nil;
    [self removeFromSuperview];
}

@end
