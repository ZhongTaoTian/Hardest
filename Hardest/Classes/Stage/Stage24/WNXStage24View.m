//
//  WNXStage24View.m
//  Hardest
//
//  Created by sfbest on 16/6/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage24View.h"
#import "WNXCockroachView.h"

@interface WNXStage24View ()
{
    int _cockorder1;
    int _cockorder2;
    int _cockorder3;
    int _show1;
    int _show2;
    int _show3;
    int _index;
    int _flag;
}

@property (nonatomic, strong) WNXCockroachView *cock1;
@property (nonatomic, strong) WNXCockroachView *cock2;
@property (nonatomic, strong) WNXCockroachView *cock3;

@property (nonatomic, strong) CADisplayLink *timer;

@end

@implementation WNXStage24View

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.cock1 = [WNXCockroachView viewFromNib];
        [self addSubview:self.cock1];
        
        self.cock2 = [WNXCockroachView viewFromNib];
        self.cock2.frame = CGRectMake(ScreenWidth / 3, 0, ScreenWidth / 3, ScreenHeight);
        [self addSubview:self.cock2];
        
        self.cock3 = [WNXCockroachView viewFromNib];
        self.cock3.frame = CGRectMake(ScreenWidth / 3 * 2, 0, ScreenWidth / 3, ScreenWidth);
        [self addSubview:self.cock3];
        
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTimer) name:kNotificationNameGameViewControllerDelloc object:nil];
        
    }
    
    return self;
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc {
    [self removeTimer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)startAppearCockroach {
    _flag = 0;
    _cockorder1 = arc4random_uniform(3);
    if (_cockorder1 == 0) {
        _cockorder2 = arc4random_uniform(2) + 1;
        if (_cockorder2 == 1) {
            _cockorder3 = 2;
        } else {
            _cockorder3 = 1;
        }
    } else if (_cockorder1 == 1) {
        _cockorder2 = arc4random_uniform(3);
        
        while (_cockorder2 == 1) {
            _cockorder2 = arc4random_uniform(3);
        }
        
        if (_cockorder2 == 0) {
            _cockorder3 = 2;
        } else {
            _cockorder3 = 0;
        }
    } else {
        _cockorder2 = arc4random_uniform(2);
        if (_cockorder2 == 0) {
            _cockorder3 = 1;
        } else {
            _cockorder3 = 0;
        }
    }
   
    NSTimeInterval after1 = arc4random_uniform(120) / 60.0;
    NSTimeInterval after2 = arc4random_uniform(120) / 60.0;
    NSTimeInterval after3 = arc4random_uniform(120) / 60.0;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(after1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.cock1 shake];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(after2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.cock2 shake];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(after3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.cock3 shake];
    });
    
    _index = arc4random_uniform(100) + 120;
    
    [self removeTimer];
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateTime {
    _flag++;
    if (_flag == _index) {
        if (_cockorder1 == 0) {
            [self.cock1 cockroachRun];
            [self.cock1 stopShake];
        } else if (_cockorder2 == 0) {
            [self.cock2 cockroachRun];
            [self.cock2 stopShake];
        } else if (_cockorder3 == 0) {
            [self.cock3 cockroachRun];
            [self.cock3 stopShake];
        }
    }
}

@end
