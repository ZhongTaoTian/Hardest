//
//  WNXStage01ViewController.m
//  Hardest
//
//  Created by sfbest on 16/3/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage01ViewController.h"

@interface WNXStage01ViewController ()

@end

@implementation WNXStage01ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.buttonImageNames = @[@"01-btfeather", @"01-btfeather", @"01-btfeather"];

//    [self.view insertSubview:self.countScore aboveSubview:self.guideImageView];
    [self.view bringSubviewToFront:self.guideImageView];
}

@end
