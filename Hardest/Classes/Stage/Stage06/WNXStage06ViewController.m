//
//  WNXStage06ViewController.m
//  Hardest
//
//  Created by sfbest on 16/4/5.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage06ViewController.h"

@interface WNXStage06ViewController ()

@end

@implementation WNXStage06ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    self.backgroundIV.image = [UIImage imageNamed:@"19_bg-iphone4"];
    [self.leftButton setImage:[UIImage imageNamed:@"19_slap-iphone4"] forState:UIControlStateNormal];
    self.leftButton.contentEdgeInsets = UIEdgeInsetsMake(30, 30, 30, 30);
    
    [self.rightButton setImage:[UIImage imageNamed:@"19_done-iphone4"] forState:UIControlStateNormal];
    [self.rightButton setContentEdgeInsets:UIEdgeInsetsMake(30, 30, 30, 30)];
}

@end
