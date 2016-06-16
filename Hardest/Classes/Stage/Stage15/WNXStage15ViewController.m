//
//  WNXStage15ViewController.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/12.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage15ViewController.h"
#import "WNXStage15View.h"
#import "WNXTimeCountView.h"

@interface WNXStage15ViewController ()

@property (nonatomic, strong) WNXStage15View *jumpView;

@end

@implementation WNXStage15ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    [self removeAllImageView];
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:ScreenBounds];
    bgView.image = [UIImage imageNamed:@"stage36_bg-iphone4"];
    [self.view insertSubview:bgView belowSubview:self.redButton];
    
    [self buildJumpView];
    
    [self addButtonsActionWithTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchDown];
    [self bringPauseAndPlayAgainToFront];
}

- (void)buildJumpView {
    __weak typeof(self) weakSelf = self;
    
    self.jumpView = [WNXStage15View new];
    [self.view insertSubview:self.jumpView belowSubview:self.redButton];
    
    self.jumpView.buttonActivate = ^{
        [weakSelf setButtonsIsActivate:YES];
    };
    
    self.jumpView.passStage = ^{
        weakSelf.view.userInteractionEnabled = NO;
        NSTimeInterval scroe = [(WNXTimeCountView *)weakSelf.countScore stopCalculateTime];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf showResultControllerWithNewScroe:scroe unit:@"s" stage:weakSelf.stage isAddScore:YES];
        });
    };
}

#pragma mark - Super Method
- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];

    [(WNXTimeCountView *)self.countScore startCalculateTime];
}

- (void)pauseGame {
    [(WNXTimeCountView *)self.countScore pause];
    
    [super pauseGame];
}

- (void)continueGame {
    [super continueGame];
    [(WNXTimeCountView *)self.countScore resumed];
}

- (void)playAgainGame {
    [(WNXTimeCountView *)self.countScore cleadData];
    [self.jumpView removeFromSuperview];
    self.jumpView = nil;
    
    [self buildJumpView];
    
    [super playAgainGame];
}

#pragma mark - Action
- (void)jump:(UIButton *)sender {
    [self setButtonsIsActivate:NO];
    [self.jumpView jumpToNextRowWithIndex:(int)sender.tag];
}

@end
