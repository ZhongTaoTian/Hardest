//
//  WNXStage11ViewController.m
//  Hardest
//
//  Created by sfbest on 16/4/27.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage11ViewController.h"
#import "WNXStage11View.h"
#import "WNXStage11BottomNumView.h"

@interface WNXStage11ViewController ()

@property (nonatomic, strong) WNXStage11View *blackboardView;
@property (nonatomic, strong) WNXStage11BottomNumView *bottomNumView;

@end

@implementation WNXStage11ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self buildStageInfo];
}

- (void)buildStageInfo {
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:ScreenBounds];
    bgImageView.image = [UIImage imageNamed:@"13_bg-iphone4"];
    [self.view insertSubview:bgImageView belowSubview:self.redButton];
    
    self.blackboardView = [[WNXStage11View alloc] initWithFrame:ScreenBounds];
    [self.view insertSubview:self.blackboardView belowSubview:self.redButton];
    
    self.bottomNumView = [[WNXStage11BottomNumView alloc] initWithFrame:CGRectMake(0, self.redButton.frame.origin.y + 4, ScreenWidth, self.redButton.frame.size.height)];
    [self.view addSubview:self.bottomNumView];
    
    [self bringPauseAndPlayAgainToFront];
    
    [self.redButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [self.yellowButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [self.blueButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
}

#pragma mark - Super Method
- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    
    __weak typeof(self) weakSelf = self;
    [self.blackboardView showSubjectViewWithNums:^(int index1, int index2, int index3) {
        [weakSelf.bottomNumView setLabelTextWithNum1:index1 num2:index2 num3:index3];
    }];
}

#pragma mark - Action
- (void)btnClick:(UIButton *)sender {
    
    if ([self.blackboardView guessResult:[self.bottomNumView resultWithIndex:(int)sender.tag]]) {
        NSLog(@"答对");
    } else {
        NSLog(@"错误");
    }
}

@end
