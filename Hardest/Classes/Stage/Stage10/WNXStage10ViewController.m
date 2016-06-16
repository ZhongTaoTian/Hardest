//
//  WNXStage10ViewController.m
//  Hardest
//
//  Created by MacBook on 16/4/23.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage10ViewController.h"
#import "WNXStage10View.h"
#import "WNXStage10BottomNumView.h"
#import "WNXTimeCountView.h"

@interface WNXStage10ViewController ()

@property (nonatomic, strong) WNXStage10View *plateView;
@property (nonatomic, strong) WNXStage10BottomNumView *numView;
@property (nonatomic, assign) NSTimeInterval oneTime;

@end

@implementation WNXStage10ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    [super buildStageView];
    
    [self removeAllImageView];
    
    UIImageView *bgIV = [[UIImageView alloc] initWithFrame:ScreenBounds];
    bgIV.image = [UIImage imageNamed:@"08_bg-iphone4"];
    [self.view insertSubview:bgIV belowSubview:self.redButton];
    
    [self setButtonsIsActivate:NO];
  
    [self buildPlateView];
    
    [self buildBottomNumberView];
    
    [super bringPauseAndPlayAgainToFront];

    [self addButtonsActionWithTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
}

- (void)buildPlateView {
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
        [weakSelf setButtonsIsActivate:NO];
        weakSelf.oneTime = [(WNXTimeCountView *)weakSelf.countScore pasueTime];
    };
    
    self.plateView.PassStageBlock = ^{
        WNXResultStateType resultType;
        if (weakSelf.oneTime < 0.8) {
            resultType = WNXResultStateTypePerfect;
        } else if (weakSelf.oneTime < 1) {
            resultType = WNXResultStateTypeGreat;
        } else {
            resultType = WNXResultStateTypeGood;
        }
        [weakSelf.stateView showStateViewWithType:resultType stageViewHiddenFinishBlock:^{
            [weakSelf showResultControllerWithNewScroe:[(WNXTimeCountView *)weakSelf.countScore stopCalculateTime] unit:@"秒" stage:weakSelf.stage isAddScore:YES];
        }];
    };
    
    self.plateView.NextBlock = ^{
        WNXResultStateType resultType;
        if (weakSelf.oneTime < 0.8) {
            resultType = WNXResultStateTypePerfect;
        } else if (weakSelf.oneTime < 1) {
            resultType = WNXResultStateTypeGreat;
        } else {
            resultType = WNXResultStateTypeGood;
        }
        [weakSelf.stateView showStateViewWithType:resultType stageViewHiddenFinishBlock:^{
            [weakSelf.numView cleanData];
            [weakSelf.plateView startRotation];
        }];
    };
    
    self.plateView.FailBlock = ^{
        [(WNXTimeCountView *)weakSelf.countScore stopCalculateTime];
        [weakSelf showGameFail];
    };
}

- (void)buildBottomNumberView {
    self.numView = [[WNXStage10BottomNumView alloc] initWithFrame:CGRectMake(0, self.redButton.frame.origin.y + 4, ScreenWidth, self.redButton.frame.size.height)];
    self.numView.userInteractionEnabled = NO;
    [self.view insertSubview:self.numView aboveSubview:self.blueButton];
}

#pragma mark - Action
- (void)buttonClick:(UIButton *)sender {
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundFeatherClickName];
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

- (void)pauseGame {
    [self.plateView pause];
    [(WNXTimeCountView *)self.countScore pause];
    [super pauseGame];
}

- (void)continueGame {
    [super continueGame];
    [self.plateView resume];
    if (!self.plateView.isAnimation) {
        [(WNXTimeCountView *)self.countScore resumed];
    }
}

- (void)playAgainGame {
    [(WNXTimeCountView *)self.countScore cleadData];
    [self.plateView cleanData];
    [self.numView cleanData];
    [self.plateView removeFromSuperview];
    self.plateView = nil;
    
    [self.numView removeFromSuperview];
    self.numView = nil;
    
    [self buildPlateView];
    [self buildBottomNumberView];
    
    [super playAgainGame];
}

@end
