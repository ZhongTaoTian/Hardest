//
//  WNXStage18ViewController.m
//  Hardest
//
//  Created by sfbest on 16/5/17.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage18ViewController.h"

@interface WNXStage18ViewController ()

@end

@implementation WNXStage18ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    
    [self setButtonImage:[UIImage imageNamed:@"20_same-iphone4"] contenEdgeInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    
    [self bringPauseAndPlayAgainToFront];
}

@end
