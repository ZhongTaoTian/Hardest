//
//  WNXStage01ViewController.m
//  Hardest
//
//  Created by sfbest on 16/3/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage01ViewController.h"
#import "WNXCountDownLabel.h"

@interface WNXStage01ViewController ()

@property (nonatomic, strong) WNXCountDownLabel *timeLabel;

@end

@implementation WNXStage01ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setStageInfo];
    
    [self initTimeLabel];
}

- (void)setStageInfo {
    self.buttonImageNames = @[@"01-btfeather", @"01-btfeather", @"01-btfeather"];
    
    [self.view bringSubviewToFront:self.guideImageView];
    
    [self.redButton addTarget:self action:@selector(featherClick:) forControlEvents:UIControlEventTouchDown];
    [self.yellowButton addTarget:self action:@selector(featherClick:) forControlEvents:UIControlEventTouchDown];
    [self.blueButton addTarget:self action:@selector(featherClick:) forControlEvents:UIControlEventTouchDown];
}

- (void)initTimeLabel {
    self.timeLabel = [[WNXCountDownLabel alloc] initWithFrame:CGRectMake(ScreenWidth - 55, ScreenHeight - self.redButton.frame.size.height - 50, 60, 50) startTime:7.0 textSize:30];
    [self.view insertSubview:self.timeLabel aboveSubview:self.redButton];
}

- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    
    __weak __typeof(&*self)weakSelf = self;
    [self.timeLabel startCountDownWithCompletion:^{
        [weakSelf endGame];
    }];
}

- (void)endGame {
    [super setButtonsIsActivate:NO];
}

#pragma mark - action
- (void)featherClick:(UIButton *)sender {
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundFeatherClickName];
    
}

@end
