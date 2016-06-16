//
//  WNXStage20ViewController.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/23.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage20ViewController.h"
#import "WNXStage20DiceView.h"
#import "WNXCountTimeView.h"

@interface WNXStage20ViewController ()
{
    int _maxIndex;
    int _timeCount;
    int _diceCount;
    BOOL _playAgain;
}

@property (nonatomic, strong) WNXStage20DiceView *diceView;
@property (nonatomic, assign) NSInteger allScore;
@property (nonatomic, strong) CADisplayLink *timer;

@end

@implementation WNXStage20ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    [self setButtonImage:[UIImage imageNamed:@"11_tick-iphone4"] contenEdgeInsets:UIEdgeInsetsMake(25, 25, 25, 25)];
    
    [self addButtonsActionWithTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    [self buildStageView];
    [self buildDiceView];
}

- (void)buildDiceView {
    self.diceView = [[WNXStage20DiceView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.redButton.frame.size.height)];
    [self.view insertSubview:self.diceView belowSubview:self.redButton];
    [self bringPauseAndPlayAgainToFront];
    
    __weak typeof(self) weakSelf = self;
    self.diceView.shakeDiceFinsih = ^{
        [weakSelf setButtonsIsActivate:YES];
        [(WNXCountTimeView *)weakSelf.countScore startCalculateTime];
    };
    
    [self bringPauseAndPlayAgainToFront];
}

#pragma mark - Action

- (void)btnClick:(UIButton *)sender {
    [self setButtonsIsActivate:NO];
    
    __block NSInteger onceTime;
    __weak typeof(self) weakSelf = self;
    [(WNXCountTimeView *)self.countScore stopCalculateByTimeWithTimeBlock:^(int second, int ms) {
        onceTime = second * 1000 + ms / 60.0 * 1000;
        weakSelf.allScore += onceTime;
    }];
    
    UIView *twinkleView = [[UIView alloc] init];
    twinkleView.backgroundColor = [UIColor whiteColor];
    twinkleView.alpha = 0.7;
    
    if (sender.tag == 0) {
        twinkleView.frame = CGRectMake(0, 0, ScreenWidth / 3, ScreenHeight - ScreenWidth / 3);
        self.redImageView.highlighted = YES;
    } else if (sender.tag == 1) {
        twinkleView.frame = CGRectMake(ScreenWidth / 3, 0, ScreenWidth / 3, ScreenHeight - ScreenWidth / 3);
        self.yellowImageView.highlighted = YES;
    } else {
        twinkleView.frame = CGRectMake(ScreenWidth / 3 * 2, 0, ScreenWidth / 3, ScreenHeight - ScreenWidth / 3);
        self.blueImageView.highlighted = YES;
    }
    
    [self.view addSubview:twinkleView];
    
    [UIView animateWithDuration:0.25 animations:^{
        twinkleView.alpha = 0;
    } completion:^(BOOL finished) {
        [twinkleView removeFromSuperview];
        
        self.redImageView.highlighted = NO;
        self.yellowImageView.highlighted = NO;
        self.blueImageView.highlighted = NO;
        
    }];
    
    if (sender.tag != _maxIndex) {
        self.view.userInteractionEnabled = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showGameFail];
        });
    } else {
        WNXResultStateType resultType;
        if (onceTime < 400) {
            resultType = WNXResultStateTypePerfect;
        } else if (onceTime < 500) {
            resultType = WNXResultStateTypeGreat;
        } else if (onceTime < 600) {
            resultType = WNXResultStateTypeGood;
        } else {
            resultType = WNXResultStateTypeGood;
        }
        
        [self.stateView showStateViewWithType:resultType stageViewHiddenFinishBlock:^{
            if (!_playAgain) {
                [weakSelf nextDice];
            }
        }];
    }
}

- (void)updateTime {
    _timeCount++;
    
    int interval = 40 - _diceCount * 5;
    if (interval < 10) {
        interval = 10;
    }
    
    if (_timeCount == interval) {
        [self.timer invalidate];
        self.timer = nil;
        
        _diceCount++;
        [(WNXCountTimeView *)self.countScore cleanData];
        _maxIndex = [self.diceView startShakeDice];
    }
}

#pragma mark - Private Method
- (void)nextDice {
    if (self.timer) {
        [self.timer invalidate];
    }
    
    if (_diceCount == 12) {
        [self showResultControllerWithNewScroe:self.allScore / 12 unit:@"ms" stage:self.stage isAddScore:YES];
    } else {
        _timeCount = 0;
        self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
        [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

#pragma mark - Super Method

- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    [self setButtonsIsActivate:NO];
    _maxIndex = [self.diceView startShakeDice];
    _playAgain = NO;
}

- (void)pauseGame {
    if (self.timer) {
        self.timer.paused = YES;
    }
    
    [(WNXCountTimeView *)self.countScore pause];
    
    [self.diceView pause];
    
    [super pauseGame];
}

- (void)continueGame {
    [super continueGame];
    
    [(WNXCountTimeView *)self.countScore continueGame];
    if (self.timer) {
        self.timer.paused = NO;
    }
    
    [self.diceView resume];
}

- (void)playAgainGame {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    _playAgain = YES;
    
    self.allScore = 0;
    _maxIndex = -1;
    _timeCount = 0;
    _diceCount = 0;
    
    [self.diceView removeData];
    [self.diceView removeFromSuperview];
    self.diceView = nil;
    
    [self buildDiceView];
    [self.stateView removeFromSuperview];
    self.stateView = nil;
    
    [super buildStageView];
    
    [(WNXCountTimeView *)self.countScore cleanData];
    
    [super playAgainGame];
}

@end
