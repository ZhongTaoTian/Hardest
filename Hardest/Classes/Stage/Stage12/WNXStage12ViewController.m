//
//  WNXStage12ViewController.m
//  Hardest
//
//  Created by MacBook on 16/5/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage12ViewController.h"
#import "WNXStage12BottomView.h"
#import "WNXStage12EggView.h"

@interface WNXStage12ViewController ()
{
    NSInteger _allScroe;
}

@property (nonatomic, strong) WNXStage12BottomView *bottomView;
@property (nonatomic, strong) WNXStage12EggView *eggView;

@end

@implementation WNXStage12ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];

}

// 200
- (void)buildStageInfo {
    [self setButtonImage:[UIImage imageNamed:@"01_catch-iphone4"] contenEdgeInsets:UIEdgeInsetsMake(14, 14, 14, 14)];

    self.bottomView = [[WNXStage12BottomView alloc] initWithFrame:CGRectMake(0, ScreenHeight - self.redButton.frame.size.height - 138, ScreenHeight, 144)];
    [self.view insertSubview:self.bottomView belowSubview:self.redButton];
    
    [self.redButton addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchDown];
    [self.yellowButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    self.eggView = [[WNXStage12EggView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 200)];
    [self.view addSubview:self.eggView];
    __weak typeof(self) weakSelf = self;
    self.eggView.failBlock = ^(NSInteger index) {
        [weakSelf.eggView failWithIndex:index];
        [weakSelf.bottomView changeBottomWihtIndex:index imageType:WNXStage12BottomViewTypeFail];
    };
}

- (void)aaa {
    [self.eggView showEgg];
}

#pragma mark - Super Method
- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    [self.view bringSubviewToFront:self.eggView];
    [self bringPauseAndPlayAgainToFront];
}

#pragma mark - Action
- (void)btnClick:(UIButton *)sender {
     NSInteger scroe = [self.eggView grabWithIndex:sender.tag];
    _allScroe += scroe;
}

@end
