//
//  WNXStage02ViewController.m
//  Hardest
//
//  Created by sfbest on 16/3/21.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage02ViewController.h"
#import "WNXCountTimeView.h"
#import "WNXGuessFingerView.h"

@interface WNXStage02ViewController ()

@property (nonatomic, strong) WNXGuessFingerView *guessView;

@end

@implementation WNXStage02ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setStageInfo];
    
    [self buildGuessImageView];
}

#pragma mark - Build UI
- (void)setStageInfo {
    self.buttonImageNames = @[@"09_red-iphone4", @"09_draw-iphone4", @"09_blue-iphone4"];
    [self.view bringSubviewToFront:self.guideImageView];
    
    [self.redButton addTarget:self action:@selector(featherClick:) forControlEvents:UIControlEventTouchDown];
    [self.yellowButton addTarget:self action:@selector(featherClick:) forControlEvents:UIControlEventTouchDown];
    [self.blueButton addTarget:self action:@selector(featherClick:) forControlEvents:UIControlEventTouchDown];
    
    [self setButtonsIsActivate:NO];
}

- (void)buildGuessImageView {
    self.guessView = [[WNXGuessFingerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.countScore.frame) + 50, ScreenWidth, 150)];
    [self.view insertSubview:self.guessView belowSubview:self.guideImageView];
}

#pragma mark - Override Method
- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    
    [self beginGame];
}

- (void)beginGame {
    
    
}

#pragma mark - Action
- (void)featherClick:(UIButton *)sender {
    
}

@end
