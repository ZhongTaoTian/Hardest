//
//  WNXStage10ViewController.m
//  Hardest
//
//  Created by MacBook on 16/4/23.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage10ViewController.h"

@interface WNXStage10ViewController ()

@end

@implementation WNXStage10ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self buildStageInfo];
}

- (void)buildStageInfo {
    UIImageView *bgIV = [[UIImageView alloc] initWithFrame:ScreenBounds];
    bgIV.image = [UIImage imageNamed:@"08_bg-iphone4"];
    [self.view insertSubview:bgIV belowSubview:self.redButton];
    
    [super bringPauseAndPlayAgainToFront];
}


@end
