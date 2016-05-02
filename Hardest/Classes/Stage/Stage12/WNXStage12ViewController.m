//
//  WNXStage12ViewController.m
//  Hardest
//
//  Created by MacBook on 16/5/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage12ViewController.h"
#import "WNXStage12BottomView.h"

@interface WNXStage12ViewController ()

@property (nonatomic, strong) WNXStage12BottomView *bottomView;

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
    
    
}

@end
