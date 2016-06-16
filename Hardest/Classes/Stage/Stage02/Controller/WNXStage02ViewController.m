//
//  WNXStage02ViewController.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/21.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage02ViewController.h"
#import "WNXCountTimeView.h"
#import "WNXGuessFingerView.h"

#define kImageViewHeight 181
#define kImageViewWidth  40

@interface WNXStage02ViewController ()
{
    int _count;
    BOOL _stop;
    int _scroe;
}

@property (nonatomic, strong) WNXGuessFingerView *guessView;
@property (nonatomic, assign) int                winIndex;
@property (nonatomic, strong) UIImageView        *winImageView;
@property (nonatomic, strong) UIImageView        *resultImageView;
@property (nonatomic, strong) WNXStrokeLabel     *resultLabel;

@end

@implementation WNXStage02ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

#pragma mark - Build UI
- (void)buildStageInfo {
    self.buttonImageNames = @[@"09_red-iphone4", @"09_draw-iphone4", @"09_blue-iphone4"];
    [self.view bringSubviewToFront:self.guideImageView];
    
    [self addButtonsActionWithTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    [self setButtonsIsActivate:NO];
    
    [self buildWinImageView];
    
    [self buildGuessImageView];
    
    [self buildRusultView];
    
    [self bringPauseAndPlayAgainToFront];
}

- (void)buildWinImageView {
    self.winImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - kImageViewWidth) * 0.5, 150, kImageViewWidth, kImageViewHeight)];
    self.winImageView.hidden = YES;
    [self.view insertSubview:self.winImageView belowSubview:self.guideImageView];
}

- (void)buildGuessImageView {
    self.guessView = [[WNXGuessFingerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.countScore.frame) + 40, ScreenWidth, 150)];
    [self.view insertSubview:self.guessView aboveSubview:self.winImageView];
    
    __weak typeof(self) weakSelf = self;
    self.guessView.animationFinish = ^(int winIndex){
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundAppearSoundName];
        weakSelf.winIndex = winIndex;
        [weakSelf setButtonsIsActivate:YES];
        [((WNXCountTimeView *)weakSelf.countScore) startCalculateByTimeWithTimeOut:^{
            [weakSelf showGameFail];
        } outTime:10];
    };
}

- (void)buildRusultView {
    self.resultImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 200) * 0.5 - 50, CGRectGetMaxY(self.guessView.frame), 200, 100)];
    self.resultImageView.hidden = YES;
    self.resultImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.resultImageView];
    
    self.resultLabel = [[WNXStrokeLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.resultImageView.frame) - 30, 0, 100, 60)];
    self.resultLabel.center = CGPointMake(self.resultLabel.center.x, self.resultImageView.center.y);
    self.resultLabel.textAlignment = NSTextAlignmentCenter;
    self.resultLabel.font = [UIFont boldSystemFontOfSize:50];
    self.resultLabel.textColor = [UIColor colorWithRed:228 / 255.0 green:120 / 255.0 blue:11 / 255.0 alpha:1];
    [self.resultLabel setTextStorkeWidth:5];
    self.resultLabel.hidden = YES;
    [self.view addSubview:self.resultLabel];
}

#pragma mark - Override Method
- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    
    [self beginGame];
}

- (void)beginGame {
    [super beginGame];
    _count = 20;
    _scroe = 0;
    [((WNXCountTimeView *)self.countScore) cleanData];
    
    [self startGuess];
}

- (void)endGame {
    [super endGame];
    
    [self showResultControllerWithNewScroe:_scroe unit:@"PTS" stage:self.stage isAddScore:YES];
}

- (void)playAgainGame {
    _count = 20;
    _scroe = 0;
    [self.guessView cleanData];
    [self.guessView removeFromSuperview];
    self.guessView = nil;
    
    [((WNXCountTimeView *)self.countScore) cleanData];
    
    [self buildGuessImageView];
    
    [super playAgainGame];
}

- (void)pauseGame {
    [super pauseGame];
    
    [((WNXCountTimeView *)self.countScore) pause];
}

- (void)continueGame {
    [super continueGame];
    
    [((WNXCountTimeView *)self.countScore) continueGame];
}

#pragma mark - Private Method
- (void)startGuess {
    self.winImageView.hidden = YES;
    for (int i = 0; i < 3; i++) {
        UIImageView *rgb = (UIImageView *)[self.view viewWithTag:i+100];
        rgb.highlighted = NO;
    }
    
    [((WNXCountTimeView *)self.countScore) cleanData];
    self.resultLabel.hidden = YES;
    self.resultImageView.hidden = YES;
    
    CGFloat time = _count * 0.05;
    if (time < 0.2) {
        time = 0.2;
    }
    
    _count--;
    [self.guessView startAnimationWithDuration:time];
    
    if (_count == 0) {
        _stop = YES;
    }
}

#pragma mark - Action
- (void)buttonClick:(UIButton *)sender {
    [self setButtonsIsActivate:NO];
    
    UIImageView *lineIV = (UIImageView *)[self.view viewWithTag:sender.tag + 100];
    lineIV.highlighted = YES;
    
    self.winImageView.hidden = NO;
    if (self.winIndex == 1) {
        self.winImageView.frame = CGRectMake((ScreenWidth / 3 - kImageViewWidth) * 0.5 + ScreenWidth / 3, 150, kImageViewWidth, kImageViewHeight);
        self.winImageView.image = [UIImage imageNamed:@"09_word02-iphone4"];
    } else {
        self.winImageView.image = [UIImage imageNamed:@"09_word03-iphone4"];
        self.winImageView.frame = CGRectMake((ScreenWidth / 3 - kImageViewWidth) * 0.5 + (ScreenWidth / 3 * self.winIndex), 150, kImageViewWidth, kImageViewHeight);
    }
    
    __weak __typeof(self) weakSelf = self;
    [((WNXCountTimeView *)self.countScore) stopCalculateByTimeWithTimeBlock:^(int second, int ms) {
        [weakSelf calculateScroeWithSecond:second ms:ms isRight:sender.tag == self.winIndex];
    }];
}

- (void)calculateScroeWithSecond:(int)second ms:(int)ms isRight:(BOOL)right {
    __weak __typeof(self) weakSelf = self;
    self.resultLabel.hidden = NO;
    self.resultImageView.hidden = NO;
    if (right) {
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundRightSoundName];
        if (second == 0) {
            if (ms < 20) {
                self.resultImageView.image = [UIImage imageNamed:@"09_fraction01-iphone4"];
                self.resultLabel.text = @"+6";
                _scroe += 6;
            } else if (ms < 30) {
                self.resultImageView.image = [UIImage imageNamed:@"09_fraction02-iphone4"];
                self.resultLabel.text = @"+3";
                _scroe += 3;
            } else {
                self.resultImageView.image = [UIImage imageNamed:@"09_fraction03-iphone4"];
                self.resultLabel.text = @"+1";
                _scroe += 1;
            }
        } else {
            self.resultImageView.image = [UIImage imageNamed:@"09_fraction03-iphone4"];
            self.resultLabel.text = @"+1";
            _scroe += 1;
        }
        
    } else {
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundWrongSoundName];
        self.resultImageView.image = [UIImage imageNamed:@"09_fraction04-iphone4"];
        self.resultLabel.text = @"-3";
        _scroe -= 3;
    }
    
    [self.guessView showResultAnimationCompletion:^{
        if (!_stop) {
            [weakSelf startGuess];
        } else {
            [self endGame];
        }
    }];
}

@end
