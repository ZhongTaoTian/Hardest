//
//  WNXStage18ViewController.m
//  Hardest
//
//  Created by sfbest on 16/5/17.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage18ViewController.h"
#import "WNXStage18PokerView.h"
#import "WNXCountTimeView.h"

@interface WNXStage18ViewController ()

@property (nonatomic, strong) WNXStage18PokerView *pokerView;
@property (nonatomic, assign) BOOL btnCanEdit;
@property (nonatomic, assign) int allScore;

@end

@implementation WNXStage18ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    
    self.pokerView = [WNXStage18PokerView viewFromNib];
    [self.view insertSubview:self.pokerView belowSubview:self.redButton];

    self.stateView = [WNXStateView viewFromNib];
    self.stateView.frame = CGRectMake(0, ScreenHeight - self.stateView.frame.size.height - ScreenWidth / 3 - 10, self.stateView.frame.size.width, self.stateView.frame.size.height);
    [self.view addSubview:self.stateView];
    
    __weak typeof(self) weakSelf = self;
    self.pokerView.startCountTime = ^{
        [(WNXCountTimeView *)weakSelf.countScore startCalculateByTimeWithTimeOut:^{
            weakSelf.view.userInteractionEnabled = NO;
            [weakSelf showGameFail];
        } outTime:2];
    };
    
    self.pokerView.showNextPoker = ^{
        weakSelf.btnCanEdit = [weakSelf.pokerView showPokerView];
        [weakSelf setButtonsIsActivate:YES];
    };
    
    self.pokerView.selectSamePokerSucess = ^{
        weakSelf.view.userInteractionEnabled = NO;
        [(WNXCountTimeView *)weakSelf.countScore stopCalculateByTimeWithTimeBlock:^(int second, int ms) {
            int onceTime = (second + ms / 60.0) * 1000;
            WNXResultStateType type;
            
            if (onceTime < 350) {
                type = WNXResultStateTypePerfect;
            } else if (onceTime < 500) {
                type = WNXResultStateTypeGreat;
            } else if (onceTime < 650) {
                type = WNXResultStateTypeGood;
            } else {
                type = WNXResultStateTypeGreat;
            }
            weakSelf.allScore += onceTime;
            
            [weakSelf.stateView showStateViewWithType:type stageViewHiddenFinishBlock:^{
                weakSelf.redImageView.highlighted = NO;
                weakSelf.yellowImageView.highlighted = NO;
                weakSelf.blueImageView.highlighted = NO;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    weakSelf.btnCanEdit = [weakSelf.pokerView showPokerView];
                    [(WNXCountTimeView *)weakSelf.countScore cleanData];
                    [weakSelf setButtonsIsActivate:YES];
                });
            }];
        }];
    };
    
    [self setButtonImage:[UIImage imageNamed:@"20_same-iphone4"] contenEdgeInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    
    [self.redButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [self.yellowButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [self.blueButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];

    [self bringPauseAndPlayAgainToFront];
}

- (void)btnClick:(UIButton *)sender {
    
    sender.userInteractionEnabled = NO;
    
    if (self.btnCanEdit) {
        if ([self.pokerView selectSamePokerWithIndex:sender.tag]) {
            if (sender.tag == 0) {
                self.redImageView.highlighted = YES;
            } else if (sender.tag == 1) {
                self.yellowImageView.highlighted = YES;
            } else {
                self.blueImageView.highlighted = YES;
            }
        } else {
            self.view.userInteractionEnabled = NO;
            [(WNXCountTimeView *)self.countScore stopCalculateByTimeWithTimeBlock:^(int second, int ms) {
                
            }];
            self.pokerView.isFail = YES;
            __weak typeof(self) weakSelf = self;
            [self.stateView showBadStateWithFinish:^{
                [weakSelf showGameFail];
            }];
        }
    } else {
        self.view.userInteractionEnabled = NO;
        self.pokerView.isFail = YES;
        __weak typeof(self) weakSelf = self;
        [self.stateView showBadStateWithFinish:^{
            [weakSelf showGameFail];
        }];
    }
}

#pragma mark - Super Method
- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    self.btnCanEdit = [self.pokerView showPokerView];
}

@end
