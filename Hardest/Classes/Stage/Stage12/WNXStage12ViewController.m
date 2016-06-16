//
//  WNXStage12ViewController.m
//  Hardest
//
//  Created by MacBook on 16/5/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage12ViewController.h"
#import "WNXStage12BottomView.h"
#import "WNXStage12EggView.h"
#import "WNXScoreboardCountView.h"

@interface WNXStage12ViewController ()

@property (nonatomic, strong) WNXStage12BottomView *bottomView;
@property (nonatomic, strong) WNXStage12EggView *eggView;
@property (nonatomic, assign) NSInteger allScroe;

@end

@implementation WNXStage12ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    [self setButtonImage:[UIImage imageNamed:@"01_catch-iphone4"] contenEdgeInsets:UIEdgeInsetsMake(14, 14, 14, 14)];

    [self addButtonsActionWithTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    [self buildEggView];
    
    [self buildBottomView];
}

- (void)buildBottomView {
    self.bottomView = [[WNXStage12BottomView alloc] initWithFrame:CGRectMake(0, ScreenHeight - self.redButton.frame.size.height - 138, ScreenHeight, 144)];
    [self.view insertSubview:self.bottomView belowSubview:self.redButton];
}

- (void)buildEggView {
    self.eggView = [[WNXStage12EggView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 200)];
    [self.view addSubview:self.eggView];
    
    self.eggView.redButton = self.redButton;
    self.eggView.yellowButton = self.yellowButton;
    self.eggView.blueButton = self.blueButton;
    
    __weak typeof(self) weakSelf = self;
    self.eggView.failBlock = ^(NSInteger index) {
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundEggHitName];
        weakSelf.view.userInteractionEnabled = NO;
        UIImageView *badIV = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth / 3 - 80) * 0.5 + ScreenWidth / 3 * index, ScreenHeight - 250, 80, 44)];
        badIV.image = [UIImage imageNamed:@"00_bad-iphone4"];
        [weakSelf.view addSubview:badIV];
        [weakSelf.eggView failWithIndex:index];
        [weakSelf.bottomView changeBottomWihtIndex:index imageType:WNXStage12BottomViewTypeFail];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf showGameFail];
        });
    };
    
    self.eggView.nextDropEggBlock = ^{
        [weakSelf.eggView showEgg];
        [weakSelf.bottomView changeBottomWihtIndex:0 imageType:WNXStage12BottomViewTypeNormal];
        [weakSelf.bottomView changeBottomWihtIndex:1 imageType:WNXStage12BottomViewTypeNormal];
        [weakSelf.bottomView changeBottomWihtIndex:2 imageType:WNXStage12BottomViewTypeNormal];
    };
    
    self.eggView.passStageBlock = ^{
        [weakSelf showResultControllerWithNewScroe:weakSelf.allScroe unit:@"PTS" stage:weakSelf.stage isAddScore:YES];
    };
}


#pragma mark - Super Method
- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    [self.view bringSubviewToFront:self.eggView];
    [self bringPauseAndPlayAgainToFront];
    
    [self.eggView showEgg];
}

- (void)pauseGame {
    [super pauseGame];
    [self.eggView pause];
}

- (void)continueGame {
    [super continueGame];
    [self.eggView resume];
}

- (void)playAgainGame {
    self.allScroe = 0;
    
    [(WNXScoreboardCountView *)self.countScore clean];
    
    [self.eggView cleanData];
    [self.eggView removeFromSuperview];
    self.eggView = nil;
    
    [self.bottomView removeFromSuperview];
    self.bottomView = nil;
    
    [self buildEggView];
    [self buildBottomView];
    
    [super playAgainGame];
}

#pragma mark - Action
- (void)btnClick:(UIButton *)sender {
    sender.userInteractionEnabled = NO;

     NSInteger scroe = [self.eggView grabWithIndex:sender.tag];
    [(WNXScoreboardCountView *)self.countScore setScore:scroe];
    _allScroe += scroe;

    if (sender.tag == 0) {
        self.redImageView.highlighted = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.redImageView.highlighted = NO;
        });
    } else if (sender.tag == 1) {
        self.yellowImageView.highlighted = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.yellowImageView.highlighted = NO;
        });
    } else {
        self.blueImageView.highlighted = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.blueImageView.highlighted = NO;
        });
    }
    [self.bottomView changeBottomWihtIndex:sender.tag imageType:WNXStage12BottomViewTypeSucess];
}

@end
