//
//  WNXStage24ViewController.m
//  Hardest
//
//  Created by sfbest on 16/6/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage24ViewController.h"
#import "WNXCountTimeView.h"
#import "WNXStage24View.h"

@interface WNXStage24ViewController ()

@property (nonatomic, strong) WNXStage24View *cockroachView;

@end

@implementation WNXStage24ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    [self setButtonImage:[UIImage imageNamed:@"stage27_btn-iphone4"] contenEdgeInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    [self addButtonsActionWithTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    [self buildCockroachView];
    
    [self bringPauseAndPlayAgainToFront];
}

- (void)buildCockroachView {
    self.cockroachView = [[WNXStage24View alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view insertSubview:self.cockroachView belowSubview:self.redButton];
    
    __weak typeof(self) weakSelf = self;
    self.cockroachView.startCountTime = ^(BOOL isFrist) {
        NSLog(@"开始计时");
        if (isFrist) {
            [(WNXCountTimeView *)weakSelf.countScore startCalculateTime];
        } else {
            [(WNXCountTimeView *)weakSelf.countScore continueGame];
        }
    };
    
}

#pragma mark - Super Method
- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    
    [self.cockroachView startAppearCockroach];
}

#pragma mark - Action
- (void)btnClick:(UIButton *)sender {
    if ([self.cockroachView hitCockroachWithIndex:sender.tag]) {
        [(WNXCountTimeView *)self.countScore pause];
        
        if (sender.tag == 0) {
            self.redImageView.highlighted = YES;
        } else if (sender.tag == 1) {
            self.yellowImageView.highlighted = YES;
        } else {
            self.blueImageView.highlighted = YES;
        }
        
    } else {
        [self showGameFail];
    }
}

@end
