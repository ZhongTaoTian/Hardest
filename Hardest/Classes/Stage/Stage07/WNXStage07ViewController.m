//
//  WNXStage07ViewController.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/4/8.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage07ViewController.h"
#import "WNXStage07View.h"
#import "WNXTimeCountView.h"


@interface WNXStage07ViewController ()
{
    BOOL _isStartTime;
    NSTimeInterval _time;
}

@property (nonatomic, strong) WNXStage07View *glassView;
@property (nonatomic, assign) NSTimeInterval oneTime;

@end

@implementation WNXStage07ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    [self removeAllImageView];
    __weak typeof(self) weakSelf = self;
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 20)];
    bgImageView.image = [UIImage imageNamed:@"04_background-iphone4"];
    [self.view insertSubview:bgImageView belowSubview:self.playAgainButton];
        
    [self addButtonsActionWithTarget:self action:@selector(gunClick) forControlEvents:UIControlEventTouchDown];
    
    [self setButtonImage:[UIImage imageNamed:@"004_gun-iphone4"] contenEdgeInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    
    self.glassView = [[WNXStage07View alloc] initWithFrame:CGRectMake(0, ScreenHeight - 300 - self.redButton.frame.size.height, ScreenWidth, 300)];
    [self.view addSubview:self.glassView];
    if (self.guideImageView) {
        [self.view bringSubviewToFront:self.guideImageView];
    }
    self.glassView.failBlock = ^{
        [weakSelf setButtonsIsActivate:NO];
        [weakSelf showGameFail];
    };
    
    self.glassView.sucessBlock = ^(int glassCount, BOOL isPass){
        [weakSelf setButtonsIsActivate:NO];
        [weakSelf showStageViewWihtCount:glassCount isPass:isPass];
    };
    
    self.glassView.stopTimeBlock = ^{
        weakSelf.oneTime = [(WNXTimeCountView *)weakSelf.countScore pasueTime];
    };

    [self bringPauseAndPlayAgainToFront];
}

- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    
    [self.glassView start];
}

- (void)pauseGame {
    [super pauseGame];
    [(WNXTimeCountView *)self.countScore pause];
}

- (void)continueGame {
    [super continueGame];
    [(WNXTimeCountView *)self.countScore resumed];
}

- (void)playAgainGame {
    [(WNXTimeCountView *)self.countScore cleadData];
    [self.glassView cleadData];
    _isStartTime = NO;
    [super playAgainGame];
}

#pragma mark - Action
- (void)gunClick {
    [self.glassView hitGlass];
    if (!_isStartTime) {
        _isStartTime = YES;
        [(WNXTimeCountView *)self.countScore startCalculateTime];
    }
}

- (void)showStageViewWihtCount:(int)count isPass:(BOOL)isPass {
    __weak typeof(self) weakSelf = self;
    if (isPass) {
        _time = [(WNXTimeCountView *)weakSelf.countScore stopCalculateTime];
    }

    NSTimeInterval oneGlassTime = _oneTime / count;
    
    if (self.stateView) {
        [self.stateView removeFromSuperview];
        self.stateView = nil;
    }

    [super buildStageView];
    
    WNXResultStateType stageType;
    if (oneGlassTime <= 0.1) {
        stageType = WNXResultStateTypePerfect;
    } else if (oneGlassTime <= 0.14) {
        stageType = WNXResultStateTypeGreat;
    } else if (oneGlassTime <= 0.18) {
        stageType = WNXResultStateTypeGood;
    } else {
        stageType = WNXResultStateTypeOK;
    }
    
    [self.stateView showStateViewWithType:stageType stageViewHiddenFinishBlock:^{
        if (isPass) {
            [weakSelf showResultControllerWithNewScroe:_time unit:@"秒" stage:weakSelf.stage isAddScore:YES];
        } else {
            [weakSelf.glassView start];
            [weakSelf setButtonsIsActivate:YES];
            [(WNXTimeCountView *)weakSelf.countScore resumed];
        }
    }];
}

@end
