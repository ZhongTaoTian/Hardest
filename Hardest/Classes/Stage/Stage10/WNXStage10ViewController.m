//
//  WNXStage10ViewController.m
//  Hardest
//
//  Created by MacBook on 16/4/23.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage10ViewController.h"
#import "WNXStage10View.h"
#import "WNXStage10BottomNumView.h"
#import "WNXTimeCountView.h"

@interface WNXStage10ViewController ()

@property (nonatomic, strong) WNXStage10View *plateView;
@property (nonatomic, strong) WNXStage10BottomNumView *numView;
@property (nonatomic, assign) NSTimeInterval time;

@end

@implementation WNXStage10ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    UIImageView *bgIV = [[UIImageView alloc] initWithFrame:ScreenBounds];
    bgIV.image = [UIImage imageNamed:@"08_bg-iphone4"];
    [self.view insertSubview:bgIV belowSubview:self.redButton];
    
    [self setButtonsIsActivate:NO];
    __weak typeof(self) weakSelf = self;
    self.plateView = [[WNXStage10View alloc] initWithFrame:CGRectMake(0, ScreenHeight - self.redButton.frame.size.height + 55 - 480, ScreenWidth, 480)];
    [self.view insertSubview:self.plateView belowSubview:self.redButton];
    self.plateView.AnimationFinishBlock = ^(BOOL isFrist) {
        [weakSelf setButtonsIsActivate:YES];
        if (isFrist) {
            [(WNXTimeCountView *)weakSelf.countScore startCalculateTime];
        } else {
            [(WNXTimeCountView *)weakSelf.countScore resumed];
        }
    };
    
    self.plateView.StopCountTimeBlock = ^{
        _time = [(WNXTimeCountView *)weakSelf.countScore pasueTime];
    };
    
    self.plateView.PassStageBlock = ^{
        [weakSelf showResultControllerWithNewScroe:[(WNXTimeCountView *)weakSelf.countScore stopCalculateTime] unit:@"秒" stage:weakSelf.stage isAddScore:YES];
    };
    
    self.plateView.NextBlock = ^{
        [weakSelf.numView cleanData];
        [weakSelf.plateView startRotation];
    };
    
    self.plateView.FailBlock = ^{
        [(WNXTimeCountView *)weakSelf.countScore stopCalculateTime];
        [weakSelf showGameFail];
    };
    
    self.numView = [[WNXStage10BottomNumView alloc] initWithFrame:CGRectMake(0, self.redButton.frame.origin.y + 4, ScreenWidth, self.redButton.frame.size.height)];
    self.numView.userInteractionEnabled = NO;
    [self.view insertSubview:self.numView aboveSubview:self.blueButton];
    
    [super bringPauseAndPlayAgainToFront];
    
    [self.redButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.yellowButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.blueButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
}

#pragma mark - Action
- (void)buttonClick:(UIButton *)sender {
    [self.numView addNumWithIndex:(int)sender.tag];
    if (![self.plateView clickWithIndex:(int)sender.tag]) {
        [(WNXTimeCountView *)self.countScore stopCalculateTime];
        [self showGameFail];
    }
}

#pragma mark - Super Method
- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    self.view.userInteractionEnabled = YES;
    [self setButtonsIsActivate:NO];
    [self.plateView startRotation];
}

@end
