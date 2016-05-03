//
//  WNXDropEggView.m
//  Hardest
//
//  Created by sfbest on 16/5/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXDropEggView.h"
#import "WNXStateView.h"

@interface WNXDropEggView ()
{
    CGAffineTransform _transform;
}

@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, strong) UIImageView *eggIV;
@property (nonatomic, assign) int speed;
@property (nonatomic, strong) UIImageView *handIV;

@end

@implementation WNXDropEggView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.eggIV = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 35) * 0.5, -44, 35, 44)];
        self.eggIV.image = [UIImage imageNamed:@"01_egg-iphone4"];
        [self addSubview:self.eggIV];
        
        self.handIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, -88, 80, 88)];
        self.handIV.hidden = YES;
        self.handIV.image = [UIImage imageNamed:@"01_holdhand-iphone4"];
        [self addSubview:self.handIV];
        
        _transform = CGAffineTransformMakeScale(1, 1);
    }
    
    return self;
}

- (void)showDropEggWithSpeed:(int)speed {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }

    self.eggIV.transform = CGAffineTransformIdentity;
    self.eggIV.hidden = NO;
    _transform = CGAffineTransformIdentity;
    self.speed = speed;
    
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateTime {
    self.eggIV.transform = CGAffineTransformTranslate(_transform, 0, self.speed);
    _transform = self.eggIV.transform;
    
    if (self.eggIV.transform.ty > ScreenHeight - 190) {
        [self.timer invalidate];
        self.timer = nil;
        self.failBlock(self.tag);
    }
}

- (void)stopDropEgg {
    [self.timer invalidate];
    self.timer = nil;
}

- (NSInteger)grabEgg {
    [self.timer invalidate];
    self.timer = nil;
    self.eggIV.hidden = YES;
    
    return [self showHandAndResult];
}

- (NSInteger)showHandAndResult {
    NSInteger scroe;
    WNXResultStateType stateType;
    
    self.handIV.frame = CGRectMake(0, self.eggIV.transform.ty - 44, 80, 88);
    self.handIV.hidden = NO;
    
    CGFloat toBottomMargin = ScreenHeight - 190 - self.eggIV.transform.ty;
    if (toBottomMargin < 5) {
        stateType = WNXResultStateTypePerfect;
    } else if (toBottomMargin < 20) {
        stateType = WNXResultStateTypeGreat;
    } else if (toBottomMargin < 40) {
        stateType = WNXResultStateTypeGood;
    } else {
        stateType = WNXResultStateTypeOK;
    }
    
    if (toBottomMargin < 5) {
        scroe = 10;
    } else if (toBottomMargin < 10) {
        scroe = 9;
    } else if (toBottomMargin < 15) {
        scroe = 8;
    } else if (toBottomMargin < 20) {
        scroe = 7;
    } else if (toBottomMargin < 25) {
        scroe = 6;
    } else if (toBottomMargin < 30) {
        scroe = 5;
    } else if (toBottomMargin < 35) {
        scroe = 4;
    } else if (toBottomMargin < 50) {
        scroe = 2;
    } else {
        scroe = 1;
    }
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - toBottomMargin, self.frame.size.width, toBottomMargin)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.alpha = 0.4;
    [self addSubview:whiteView];
    
//    if (sta) {
//        <#statements#>
//    }
    
    return scroe;
}

@end
