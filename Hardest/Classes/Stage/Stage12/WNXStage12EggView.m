//
//  WNXStage12EggView.m
//  Hardest
//
//  Created by MacBook on 16/5/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage12EggView.h"
#import "WNXDropEggView.h"

@interface WNXStage12EggView ()
{
    int _speed;
    int _count;
}

@property (nonatomic, strong) WNXDropEggView *egg1;
@property (nonatomic, strong) WNXDropEggView *egg2;
@property (nonatomic, strong) WNXDropEggView *egg3;
@property (nonatomic, assign) int stopCount;

@end

@implementation WNXStage12EggView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.egg1 = [[WNXDropEggView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth / 3, ScreenHeight - 200)];
        [self buildEggView:self.egg1 tag:0];
        
        self.egg2 = [[WNXDropEggView alloc] initWithFrame:CGRectMake(ScreenWidth / 3, 0, ScreenWidth / 3, ScreenHeight - 200)];
        [self buildEggView:self.egg2 tag:1];
        
        self.egg3 = [[WNXDropEggView alloc] initWithFrame:CGRectMake(ScreenWidth / 3 * 2, 0, ScreenWidth / 3, ScreenHeight - 200)];
        [self buildEggView:self.egg3 tag:2];
    }
    
    return self;
}

- (void)setButtonsEnabled:(BOOL)enabled {
    self.redButton.userInteractionEnabled = enabled;
    self.blueButton.userInteractionEnabled = enabled;
    self.yellowButton.userInteractionEnabled = enabled;
}

- (void)showEgg {
    [self setButtonsEnabled:NO];
    
    _count++;
    if (_count == 7) {
        self.passStageBlock();
        return;
    }
    
    self.stopCount = 0;
    
    if (_speed >= 2) {
        _speed++;
    } else {
        _speed += 2;
    }
    
    if (_speed > 6) {
        _speed = 6;
    }
    
    NSTimeInterval random1 = arc4random_uniform(2) + arc4random_uniform(10) / 10.0;
    NSTimeInterval random2 = arc4random_uniform(2) + arc4random_uniform(10) / 10.0;
    NSTimeInterval random3 = arc4random_uniform(2) + arc4random_uniform(10) / 10.0;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(random1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.egg1 showDropEggWithSpeed:_speed];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.redButton.userInteractionEnabled = YES;
        });
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(random2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.egg2 showDropEggWithSpeed:_speed];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.yellowButton.userInteractionEnabled = YES;
        });
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(random3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.egg3 showDropEggWithSpeed:_speed];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.blueButton.userInteractionEnabled = YES;
        });
    });
    
}

- (void)buildEggView:(WNXDropEggView *)eggView tag:(NSInteger)tag {
    __weak typeof(self) weakSelf = self;
    eggView.tag = tag;
    [self addSubview:eggView];
    eggView.failBlock = ^(NSInteger index){
        if (weakSelf.failBlock) {
            weakSelf.failBlock(index);
        }
    };
}

- (void)failWithIndex:(NSInteger)index {
    if (index == 0) {
        self.egg1.hidden = YES;
    } else if (index == 1) {
        self.egg2.hidden = YES;
    } else {
        self.egg3.hidden = YES;
    }
    
    [self.egg1 stopDropEgg];
    [self.egg2 stopDropEgg];
    [self.egg3 stopDropEgg];
}

- (NSInteger)grabWithIndex:(NSInteger)index {
    self.stopCount++;
    NSInteger scroe;
    if (index == 0) {
        scroe = [self.egg1 grabEgg];
    } else if (index == 1) {
        scroe = [self.egg2 grabEgg];
    } else {
        scroe = [self.egg3 grabEgg];
    }
    
    return scroe;
}

- (void)setStopCount:(int)stopCount {
    _stopCount = stopCount;
    if (_stopCount == 3) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.nextDropEggBlock();
        });
    }
}

- (void)pause {
    [self.egg1 pause];
    [self.egg2 pause];
    [self.egg3 pause];
}

- (void)resume {
    [self.egg1 resume];
    [self.egg2 resume];
    [self.egg3 resume];
}

- (void)cleanData {
    self.failBlock = nil;
    self.nextDropEggBlock = nil;
    self.passStageBlock = nil;
    
    [self.egg1 removeFromSuperview];
    [self.egg1 cleanData];
    self.egg1 = nil;
    
    [self.egg2 removeFromSuperview];
    [self.egg2 cleanData];
    self.egg2 = nil;
    
    [self.egg3 removeFromSuperview];
    [self.egg3 cleanData];
    self.egg3 = nil;
}

@end
