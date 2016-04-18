//
//  WNXStage09BobmView.m
//  Hardest
//
//  Created by sfbest on 16/4/12.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage09BobmView.h"
#import "WNXBobmView.h"

@interface WNXStage09BobmView ()
{
    int _stopCount;
    int _count;
    int _ms;
}

@property (nonatomic, strong) WNXBobmView *bobmView1;
@property (nonatomic, strong) WNXBobmView *bobmView2;
@property (nonatomic, strong) WNXBobmView *bobmView3;
@property (nonatomic, strong) CADisplayLink *timer;

@end

@implementation WNXStage09BobmView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        __weak typeof(self) weakSelf = self;
        
        self.bobmView1 = [WNXBobmView viewFromNib];
        CGFloat bobmWidth = self.bobmView1.frame.size.width;
        CGFloat bobmHeight = self.bobmView1.frame.size.height;
        CGFloat startY = ScreenHeight * 0.5 - 60;
        CGFloat startX = (ScreenWidth / 3 - bobmWidth) * 0.5;
        self.bobmView1.frame = CGRectMake(startX, startY, bobmWidth, bobmHeight);
        self.bobmView1.timeOver = ^{
            [weakSelf bobmWithIndex:0];
        };
        [self addSubview:self.bobmView1];
        
        self.bobmView2 = [WNXBobmView viewFromNib];
        self.bobmView2.timeOver = ^{
            [weakSelf bobmWithIndex:1];
        };
        self.bobmView2.frame = CGRectMake(ScreenWidth / 3 + startX, startY, bobmWidth, bobmHeight);
        [self addSubview:self.bobmView2];
        
        self.bobmView3 = [WNXBobmView viewFromNib];
        self.bobmView3.timeOver = ^{
            [weakSelf bobmWithIndex:2];
        };
        self.bobmView3.frame = CGRectMake(ScreenWidth / 3 * 2 + startX, startY, bobmWidth, bobmHeight);
        [self addSubview:self.bobmView3];
        
        CGAffineTransform locationTF = CGAffineTransformMakeTranslation(0, -(startY + bobmHeight));
        self.bobmView3.transform = self.bobmView2.transform = self.bobmView1.transform = locationTF;
    }
    
    return self;
}

- (void)bobmWithIndex:(int)index {
    self.superview.userInteractionEnabled = NO;
    [self.timer invalidate];
    self.timer = nil;
    [self bobmStopCount];
}

- (void)bobmStopCount {
    [self.bobmView1 stopCountDown];
    [self.bobmView2 stopCountDown];
    [self.bobmView3 stopCountDown];
}

- (void)stopCountWithIndex:(int)index {
    switch (index) {
        case 0:
            [self.bobmView1 stopCountDown];
            break;
        case 1:
            [self.bobmView2 stopCountDown];
            break;
        case 2:
            [self.bobmView3 stopCountDown];
            break;
        default:
            break;
    }
    [self showKaCViewWithIndex:index];
    
    _stopCount++;
    if (_stopCount == 3) {
        [self.timer invalidate];
        self.timer = nil;
        if (_count == 4) {
            self.passBlock();
        } else {
            self.nextBlock();
        }
    }
}

- (void)showKaCViewWithIndex:(int)index {
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundKaChaName];
    UIView *lightView = [[UIView alloc] initWithFrame:CGRectMake(index * (ScreenWidth / 3), 0, ScreenWidth / 3, self.frame.size.height)];
    lightView.backgroundColor = [UIColor whiteColor];
    lightView.alpha = 0.7;
    [self insertSubview:lightView belowSubview:self.bobmView1];
    
    [UIView animateWithDuration:0.15 animations:^{
        lightView.alpha = 0;
    } completion:^(BOOL finished) {
        [lightView removeFromSuperview];
    }];
}

- (void)showBobm {
    _stopCount = 0;
    _count++;
    [UIView animateWithDuration:0.25 animations:^{
        self.bobmView1.transform = self.bobmView2.transform = self.bobmView3.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.bobmView1 startCountDown];
        [self.bobmView2 startCountDown];
        [self.bobmView3 startCountDown];
        self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
        [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }];
}

- (void)updateTime {
    _ms++;
    if (_ms == 40) {
        _ms = 0;
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundCountDownName];
    }
}

@end
