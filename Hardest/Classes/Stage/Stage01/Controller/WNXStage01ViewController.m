//
//  WNXStage01ViewController.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage01ViewController.h"
#import "WNXCountDownLabel.h"
#import "WNXFootView.h"
#import "WNXFeatherView.h"
#import "WNXScoreboardCountView.h"
#import "WNXStageInfoManager.h"

#define kStage01Duration 7.0

@interface WNXStage01ViewController ()

@property (nonatomic, strong) WNXCountDownLabel *timeLabel;
@property (nonatomic, strong) WNXFootView *footView;
@property (nonatomic, strong) WNXFeatherView *featherView;

@end

@implementation WNXStage01ViewController

- (void)viewDidLoad {    
    [super viewDidLoad];

    [self buildStageInfo];
    

}

#pragma mark - Build UI
- (void)buildStageInfo {
    self.buttonImageNames = @[@"01-btfeather", @"01-btfeather", @"01-btfeather"];
    [self.view bringSubviewToFront:self.guideImageView];
    
    [self addButtonsActionWithTarget:self action:@selector(featherClick:) forControlEvents:UIControlEventTouchDown];
    
    [self initTimeLabel];
    
    [self initFootView];
    
    [self initFeaterView];
    
    [self bringPauseAndPlayAgainToFront];
}

- (void)initTimeLabel {
    self.timeLabel = [[WNXCountDownLabel alloc] initWithFrame:CGRectMake(ScreenWidth - 55, ScreenHeight - self.redButton.frame.size.height - 50, 60, 50)
                                                    startTime:kStage01Duration textSize:30];
    [self.view insertSubview:self.timeLabel aboveSubview:self.redButton];
}

- (void)initFootView {
    self.footView = [[WNXFootView alloc] initWithFrame:CGRectMake(0, ScreenHeight - self.redButton.frame.size.height - 200 - 45, ScreenWidth / 3, 200)];
    [self.view insertSubview:self.footView aboveSubview:self.redButton];
}

- (void)initFeaterView {
    self.featherView = [[WNXFeatherView alloc] initWithFrame:CGRectMake((ScreenWidth / 3 - 100) * 0.5, ScreenHeight - self.redButton.frame.size.height - 160, 100, 73)];
    [self.view insertSubview:self.featherView aboveSubview:self.footView];
}

#pragma mark - Override Method
- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    
    [self beginGame];
    
    __weak __typeof(&*self)weakSelf = self;
    [self.timeLabel startCountDownWithCompletion:^{
        [weakSelf endGame];
    }];
}

- (void)endGame {
    [super endGame];
    self.view.userInteractionEnabled = NO;
    [self.footView stopFootView];
    [self.featherView removeFromSuperview];
    
    [self showResultControllerWithNewScroe:[((WNXScoreboardCountView *)self.countScore).countLabel.text intValue] unit:@"PTS" stage:self.stage isAddScore:YES];
}

- (void)playAgainGame {
    [super playAgainGame];
    [self.footView clean];
    [self.timeLabel clean];
    [self setButtonsIsActivate:NO];
    [((WNXScoreboardCountView *)self.countScore) clean];
}

- (void)beginGame {
    [super beginGame];
    
    [self.footView startAnimation];
}

- (void)pauseGame {
    [super pauseGame];
    
    [self.footView pause];
    [self.timeLabel pause];
}

- (void)continueGame {
    [super continueGame];
    [self.footView continueFootView];
    [self.timeLabel continueWork];
}

#pragma mark - action
- (void)featherClick:(UIButton *)sender {
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundFeatherClickName];
    [self.featherView attack:(int)sender.tag];
    if ([self.footView attackFootViewAtIndex:(int)sender.tag]) {
        [(WNXScoreboardCountView *)self.countScore hit];
    } else {
        [self showMissImageViewAtIndex:(int)sender.tag];
    }
}

- (void)showMissImageViewAtIndex:(int)index {
    UIImageView *missIV = [[UIImageView alloc] initWithFrame:CGRectMake((index * ScreenWidth / 3) + (ScreenWidth / 3 - 80) * 0.5, CGRectGetMinY(self.footView.frame), 80, 31)];
    missIV.image = [UIImage imageNamed:@"01_miss"];
    [self.view insertSubview:missIV belowSubview:self.footView];
    [UIView animateWithDuration:0.15 animations:^{
        missIV.transform = CGAffineTransformMakeTranslation(0, -100);
        missIV.alpha = 0;
    } completion:^(BOOL finished) {
        [missIV removeFromSuperview];
    }];
}

@end
