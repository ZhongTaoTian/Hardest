//
//  WNXStage15ViewController.m
//  Hardest
//
//  Created by sfbest on 16/5/12.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage15ViewController.h"
#import "WNXStage15View.h"


@interface WNXStage15ViewController ()

@property (nonatomic, strong) WNXStage15View *jumpView;

@end

@implementation WNXStage15ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:ScreenBounds];
    bgView.image = [UIImage imageNamed:@"stage36_bg-iphone4"];
    [self.view insertSubview:bgView belowSubview:self.redButton];
    
    self.jumpView = [WNXStage15View new];
    [self.view insertSubview:self.jumpView belowSubview:self.redButton];
    
    [self.redButton addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchDown];
    
    [self bringPauseAndPlayAgainToFront];
}

- (void)aaa {
    [self.jumpView jumpToNextRowWithIndex:0];
}

@end
