//
//  WNXStage24ViewController.m
//  Hardest
//
//  Created by sfbest on 16/5/30.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage24ViewController.h"

@interface WNXStage24ViewController ()

@end

@implementation WNXStage24ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    
    [self.leftButton setImage:[UIImage imageNamed:@"22_run-iphone4"] forState:UIControlStateNormal];
    self.leftButton.contentEdgeInsets = UIEdgeInsetsMake(30, 35, 30, 35);
    
    [self.leftButton setImage:[UIImage imageNamed:@"22_jump-iphone4"] forState:UIControlStateNormal];
    self.leftButton.contentEdgeInsets = UIEdgeInsetsMake(30, 35, 30, 35);
    
//    [self.rightButton addTarget:self action:@selector(run) forControlEvents:UIControlEventTouchDown];

    
    [self bringPauseAndPlayAgainToFront];
}

@end
