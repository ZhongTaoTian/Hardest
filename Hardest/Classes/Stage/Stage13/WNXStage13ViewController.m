//
//  WNXStage13ViewController.m
//  Hardest
//
//  Created by sfbest on 16/5/4.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage13ViewController.h"

@interface WNXStage13ViewController ()

@end

@implementation WNXStage13ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self buildStageInfo];
}

- (void)buildStageInfo {
    UIImageView *bgIV = [[UIImageView alloc] initWithFrame:ScreenBounds];
    bgIV.image = [UIImage imageNamed:@"11_bg-iphone4"];
    [self.view insertSubview:bgIV belowSubview:self.redButton];
    
    [self bringPauseAndPlayAgainToFront];
}

@end
