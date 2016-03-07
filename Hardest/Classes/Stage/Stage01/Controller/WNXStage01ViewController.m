//
//  WNXStage01ViewController.m
//  Hardest
//
//  Created by sfbest on 16/3/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage01ViewController.h"
#import "WNXCountDownLabel.h"
#import "WNXFootView.h"

#define kStage01Duration 7.0

@interface WNXStage01ViewController ()

@property (nonatomic, strong) WNXCountDownLabel *timeLabel;
@property (nonatomic, strong) WNXFootView *footView;

@end

@implementation WNXStage01ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setStageInfo];
    
    [self initTimeLabel];
    
    [self initFootView];
}

- (void)setStageInfo {
    self.buttonImageNames = @[@"01-btfeather", @"01-btfeather", @"01-btfeather"];
    
    [self.view bringSubviewToFront:self.guideImageView];
    
    [self.redButton addTarget:self action:@selector(featherClick:) forControlEvents:UIControlEventTouchDown];
    [self.yellowButton addTarget:self action:@selector(featherClick:) forControlEvents:UIControlEventTouchDown];
    [self.blueButton addTarget:self action:@selector(featherClick:) forControlEvents:UIControlEventTouchDown];
}

- (void)initTimeLabel {
    self.timeLabel = [[WNXCountDownLabel alloc] initWithFrame:CGRectMake(ScreenWidth - 55, ScreenHeight - self.redButton.frame.size.height - 50, 60, 50)
                                                    startTime:kStage01Duration textSize:30];
    [self.view insertSubview:self.timeLabel aboveSubview:self.redButton];
    
    
}

- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    
    [self beginGame];
    
    __weak __typeof(&*self)weakSelf = self;
    [self.timeLabel startCountDownWithCompletion:^{
        [weakSelf endGame];
    }];
}

- (void)initFootView {
    self.footView = [[WNXFootView alloc] initWithFrame:CGRectMake(0, ScreenHeight - self.redButton.frame.size.height - 200 - 45, ScreenWidth / 3, 200)];
    [self.view insertSubview:self.footView aboveSubview:self.redButton];
}

- (void)endGame {
    [super setButtonsIsActivate:NO];
    [self.footView stopFootView];
}

- (void)beginGame {
    [super beginGame];
    
    [self.footView startAnimation];
}

#pragma mark - action
- (void)featherClick:(UIButton *)sender {
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundFeatherClickName];
    
    if ([self.footView attackFootViewAtIndex:(int)sender.tag]) {
        // 击中
        [(WNXScoreboardCountView *)self.countScore hit];
    } else {
        // 未击中
        [self showMissImageViewAtIndex:sender.tag];
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
