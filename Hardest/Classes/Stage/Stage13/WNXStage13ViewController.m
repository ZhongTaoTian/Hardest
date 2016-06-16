//
//  WNXStage13ViewController.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/4.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage13ViewController.h"
#import "WNXStage13BottomView.h"
#import "WNXStage13GuessView.h"
#import "WNXCountTimeView.h"

@interface WNXStage13ViewController ()

@property (nonatomic, strong) WNXStage13GuessView *guessView;
@property (nonatomic, strong) WNXStage13BottomView *bottom;
@property (nonatomic, assign) NSTimeInterval allTime;
@property (nonatomic, assign) WNXResultStateType type;

@end

@implementation WNXStage13ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    UIImageView *bgIV = [[UIImageView alloc] initWithFrame:ScreenBounds];
    bgIV.image = [UIImage imageNamed:@"11_bg-iphone4"];
    [self.view insertSubview:bgIV belowSubview:self.redButton];
    
    [self removeAllImageView];
    
    [super buildStageView];
    
    self.guessView = [[WNXStage13GuessView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.redButton.frame.size.height)];
    [self.view addSubview:self.guessView];
    
    self.bottom = [[WNXStage13BottomView alloc] initWithFrame:CGRectMake(0, self.redButton.frame.origin.y, ScreenWidth, self.redButton.frame.size.height)];
    [self.view addSubview:self.bottom];
    
    [self addButtonsActionWithTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    [self bringPauseAndPlayAgainToFront];
    
    __weak typeof(self) weakSelf = self;
    self.guessView.startCountTime = ^{
        [weakSelf setButtonsIsActivate:YES];
        [(WNXCountTimeView *)weakSelf.countScore startCalculateByTimeWithTimeOut:^{
            [weakSelf.guessView stopAnimationWithTimeOver];
        } outTime:3];
    };
    
    self.guessView.nextCountWithError = ^{
        [(WNXCountTimeView *)weakSelf.countScore cleanData];
        [weakSelf.bottom cleanData];
        weakSelf.allTime += 3.0;
        [weakSelf.guessView startGuess];
    };
    
    self.guessView.nextCountWithSucess = ^(BOOL isPass){
        [weakSelf.guessView stopAnimationWithFinish:nil];
        [weakSelf setButtonsIsActivate:NO];
        [(WNXCountTimeView *)weakSelf.countScore stopCalculateByTimeWithTimeBlock:^(int second, int ms) {
            NSTimeInterval onceTime = (second + ms / 60.0);
            
            if (onceTime < 0.8) {
                weakSelf.type = WNXResultStateTypePerfect;
            } else if (onceTime < 1.0) {
                weakSelf.type = WNXResultStateTypeGreat;
            } else if (onceTime < 1.2) {
                weakSelf.type = WNXResultStateTypeGood;
            } else {
                weakSelf.type = WNXResultStateTypeOK;
            }
            
            weakSelf.allTime += onceTime;
            
            [weakSelf.stateView showStateViewWithType:weakSelf.type stageViewHiddenFinishBlock:^{
                if (isPass) {
                    [weakSelf showResultControllerWithNewScroe:(int)(weakSelf.allTime / 18 * 1000) unit:@"MS" stage:weakSelf.stage isAddScore:YES];
                } else {
                    [(WNXCountTimeView *)weakSelf.countScore cleanData];
                    [weakSelf.bottom cleanData];
                    [weakSelf.guessView startGuess];
                }
            }];
            
        }];
    };
}

#pragma mark - Super Method
- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    [self.bottom changeBottomImageViewWihtIndex:0 type:WNXStage13BottomTypePeople];
    [self.bottom changeBottomImageViewWihtIndex:1 type:WNXStage13BottomTypePeople];
    [self.bottom changeBottomImageViewWihtIndex:2 type:WNXStage13BottomTypePeople];
    
    [self.guessView startGuess];
}

- (void)pauseGame {
    [(WNXCountTimeView *)self.countScore pause];
    [self.guessView pause];
    
    [super pauseGame];
}

- (void)continueGame {
    [super continueGame];
    
    [(WNXCountTimeView *)self.countScore continueGame];
    [self.guessView resume];
}

- (void)playAgainGame {
    [(WNXCountTimeView *)self.countScore cleanData];
    [self.bottom cleanData];
    [self.guessView cleanData];
    
    [super playAgainGame];
}

#pragma mark - Action
- (void)btnClick:(UIButton *)sender {
    [self.bottom showPeopleImageViewWithIndex:sender.tag];
    
    __weak typeof(self) weakSelf = self;
    sender.userInteractionEnabled = NO;
    if ([self.guessView guessPeopleWithGuessType:sender.tag]) {
        [self.bottom changeBottomImageViewWihtIndex:sender.tag type:WNXStage13BottomTypeTick];
    } else {
        [self.bottom changeBottomImageViewWihtIndex:sender.tag type:WNXStage13BottomTypeNone];
        self.view.userInteractionEnabled = NO;
        [(WNXCountTimeView *)self.countScore stopCalculateByTimeWithTimeBlock:nil];
        
        [self.guessView showFailWithIsShowPeople:YES AnimationFinish:^{
            [weakSelf showGameFail];
        }];
    }
}

@end
