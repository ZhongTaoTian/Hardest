//
//  WNXStage05ViewController.m
//  Hardest
//
//  Created by MacBook on 16/4/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage05ViewController.h"
#import "WNXIceView.h"
#import "WNXTimeCountView.h"
#import "WNXStateView.h"

@interface WNXStage05ViewController ()

@property (nonatomic, strong) WNXIceView *iceView;
@property (nonatomic, strong) WNXStateView *stateView;

@end

@implementation WNXStage05ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
    
    [self buildStateView];
}

#pragma mark - Build UI
- (void)buildStageInfo {
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:@"03_background-iphone4"];
    [self.view insertSubview:bgImageView belowSubview:self.redButton];
    
    [self setButtonsInfo];
    
    [self buildEggRoll];
    
    [self buildIceView];
    
    for (UIButton *btn in self.buttons) {
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    }
}

- (void)setButtonsInfo {
    for (UIButton *btn in self.buttons) {
        [btn setImage:[UIImage imageNamed:@"03_button-iphone4"] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    }
}

- (void)buildStateView {
    self.stateView = [WNXStateView viewFromNib];
    self.stateView.frame = CGRectMake(0, ScreenHeight - self.stateView.frame.size.height - self.redButton.frame.size.height - 10, self.stateView.frame.size.width, self.stateView.frame.size.height);
    [self.view addSubview:self.stateView];
}

- (void)buildEggRoll {
    CGFloat eggIVW = 100;
    CGFloat eggIVH = 204;
    CGFloat margin = (ScreenWidth / 3 - eggIVW) * 0.5;
    for (int i = 0; i < 3; i++) {
        UIImageView *eggIV = [[UIImageView alloc] initWithFrame:CGRectMake(margin + i * (eggIVW + margin * 2), ScreenHeight - self.redButton.bounds.size.height - 85, eggIVW, eggIVH)];
        eggIV.image = [UIImage imageNamed:@"03_cones-iphone4"];
        [self.view insertSubview:eggIV belowSubview:self.redButton];
    }
    
    [self.view bringSubviewToFront:self.playAgainButton];
    [self.view bringSubviewToFront:self.pauseButton];
}

- (void)buildIceView {
    self.iceView = [[WNXIceView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 412, ScreenWidth, 229)];
    [self.view addSubview:self.iceView];
    [self.iceView showDottedLineView];

    __weak typeof(self) weakSelf = self;
    
    if (self.guideImageView) {
        [self.view bringSubviewToFront:self.guideImageView];
    }
    
    self.iceView.failBlock = ^{
        NSLog(@"失败");
    };
    
    self.iceView.successBlock = ^(int iceCount){
        [weakSelf showResultStateWithCount:iceCount];
    };
}

#pragma mark Super Method
- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    [self.view bringSubviewToFront:self.iceView];
    
    [(WNXTimeCountView *)self.countScore startCalculateTime];
}

- (void)beginRedayGoView {
    [super beginRedayGoView];
    
    if (self.guideImageView) {
        [self.view bringSubviewToFront:self.guideImageView];
    }
}

#pragma mark - Private Method
- (void)showResultStateWithCount:(int)count {
    NSTimeInterval time = [(WNXTimeCountView *)self.countScore pasueTime];
    NSLog(@"%f", time / count);
    WNXResultStateType stageType;
    if (time < 0.05) {
        stageType = WNXResultStateTypePerfect;
    } else if (time < 0.08) {
        stageType = WNXResultStateTypeGreat;
    } else if (time < 0.1) {
        stageType = WNXResultStateTypeGood;
    } else {
        stageType = WNXResultStateTypeOK;
    }
    
    [self.stateView showStateViewWithType:stageType];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.iceView showDottedLineView];
        [(WNXTimeCountView *)self.countScore resumed];
    });
}

#pragma mark Action
- (void)btnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            [self.iceView addIceWithRed:YES yellow:NO blue:NO];
            break;
        case 1:
            [self.iceView addIceWithRed:NO yellow:YES blue:NO];
            break;
        case 2:
            [self.iceView addIceWithRed:NO yellow:NO blue:YES];
            break;
        default:
            break;
    }
}

@end
