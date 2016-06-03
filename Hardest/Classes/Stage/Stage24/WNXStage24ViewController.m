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
}

- (void)buildCockroachView {
    self.cockroachView = [[WNXStage24View alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view insertSubview:self.cockroachView belowSubview:self.redButton];
}

#pragma mark - Action
- (void)btnClick:(UIButton *)sender {
    [self.cockroachView startAppearCockroach];
}

@end
