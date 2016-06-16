//
//  WNXStage11ViewController.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/4/27.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage11ViewController.h"
#import "WNXStage11View.h"
#import "WNXStage11BottomNumView.h"
#import "WNXTimeCountView.h"
#import "WNXCountTimeView.h"

@interface WNXStage11ViewController ()

@property (nonatomic, strong) WNXStage11View *blackboardView;
@property (nonatomic, strong) WNXStage11BottomNumView *bottomNumView;
@property (nonatomic, assign) NSTimeInterval onceTime;
@property (nonatomic, assign) NSTimeInterval allTime;
@property (nonatomic, assign) BOOL isPlayAgain;

@end

@implementation WNXStage11ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    [super buildStageView];
    
    [self removeAllImageView];
    
    __weak typeof(self) weakSelf = self;
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:ScreenBounds];
    bgImageView.image = [UIImage imageNamed:@"13_bg-iphone4"];
    [self.view insertSubview:bgImageView belowSubview:self.redButton];
    
    self.blackboardView = [[WNXStage11View alloc] initWithFrame:ScreenBounds];
    [self.view insertSubview:self.blackboardView belowSubview:self.redButton];
    
    self.blackboardView.handViewShowAnimation = ^(BOOL isRight) {
        if (isRight) {
            weakSelf.bottomNumView.hidden = YES;
            [weakSelf showResultStatusWithIsSucess:YES animationFinish:^{
                [weakSelf.blackboardView showHandViewAnimationFinish:^{
                    [weakSelf.blackboardView showSubjectViewWithNums:^(int index1, int index2, int index3) {
                        [(WNXCountTimeView *)weakSelf.countScore startCalculateTime];
                        [weakSelf.bottomNumView setLabelTextWithNum1:index1 num2:index2 num3:index3];
                        [weakSelf setButtonsIsActivate:YES];
                    }];
                }];
            }];
        } else {
            weakSelf.bottomNumView.hidden = NO;
            [weakSelf showResultStatusWithIsSucess:NO animationFinish:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (weakSelf.isPlayAgain) {
                        return;
                    }
                    [weakSelf showGameFail];
                });
            }];
            
        }
    };
    
    self.blackboardView.passState = ^{
        NSTimeInterval average = weakSelf.allTime / 16;
        int scroe = average * 1000;
        [weakSelf showResultControllerWithNewScroe:scroe unit:@"MS" stage:weakSelf.stage isAddScore:YES];
    };
    
    self.bottomNumView = [[WNXStage11BottomNumView alloc] initWithFrame:CGRectMake(0, self.redButton.frame.origin.y + 4, ScreenWidth, self.redButton.frame.size.height)];
    [self.view addSubview:self.bottomNumView];
    
    [self bringPauseAndPlayAgainToFront];
    
    [self addButtonsActionWithTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
}


- (void)showResultStatusWithIsSucess:(BOOL)sucess animationFinish:(void (^)(void))finish {
    _allTime += self.onceTime;
    if (sucess) {
        WNXResultStateType resultType;
        if (self.onceTime < 1.0) {
            resultType = WNXResultStateTypePerfect;
        } else if (self.onceTime < 1.2) {
            resultType = WNXResultStateTypeGreat;
        } else if (self.onceTime < 1.4) {
            resultType = WNXResultStateTypeGood;
        } else {
            resultType = WNXResultStateTypeOK;
        }
        [self.stateView showStateViewWithType:resultType stageViewHiddenFinishBlock:^{
            finish();
        }];
    } else {
        UIImageView *errorView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 150) * 0.5, ScreenHeight - self.redButton.frame.size.height - 180, 150, 150)];
        errorView.image = [UIImage imageNamed:@"00_cross-iphone4"];
        [self.view addSubview:errorView];
        
        UIImageView *badView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 140, 80)];
        badView.layer.anchorPoint = CGPointMake(0, 0.5);
        badView.image = [UIImage imageNamed:@"00_bad-iphone4"];
        badView.center = CGPointMake(errorView.center.x - 70, errorView.center.y);
        [self.view addSubview:badView];
        
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundEnenName];
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            badView.transform = CGAffineTransformMakeRotation(M_2_PI);
        } completion:^(BOOL finished) {
            [badView removeFromSuperview];
            [errorView removeFromSuperview];
            finish();
        }];
    }
}

#pragma mark - Super Method
- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    
    [self.blackboardView setSubjectPlayAgain];
    __weak typeof(self) weakSelf = self;
    [self.blackboardView showSubjectViewWithNums:^(int index1, int index2, int index3) {
        [weakSelf.bottomNumView setLabelTextWithNum1:index1 num2:index2 num3:index3];
        [(WNXCountTimeView *)weakSelf.countScore startCalculateTime];
        weakSelf.isPlayAgain = NO;
    }];
}

- (void)pauseGame {
    [super pauseGame];
    [(WNXCountTimeView *)self.countScore pause];
}

- (void)continueGame {
    [super continueGame];
    [(WNXCountTimeView *)self.countScore continueGame];
}

- (void)playAgainGame {
    [(WNXCountTimeView *)self.countScore cleanData];
    [self.bottomNumView setLabelTextWithNum1:0 num2:0 num3:0];
    self.bottomNumView.hidden = YES;
    [self.blackboardView cleanData];
    self.isPlayAgain = YES;
    
    [super playAgainGame];
}

#pragma mark - Action
- (void)btnClick:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    [self setButtonsIsActivate:NO];
    [(WNXCountTimeView *)self.countScore stopCalculateByTimeWithTimeBlock:^(int second, int ms) {
        weakSelf.onceTime = second + ms / 60.0;
    }];
    
    [self.blackboardView guessResult:[self.bottomNumView resultWithIndex:(int)sender.tag]];
}

@end
