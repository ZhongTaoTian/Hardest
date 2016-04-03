//
//  WNXStageViewController.m
//  Hardest
//
//  Created by MacBook on 16/4/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStageViewController.h"

@interface WNXStageViewController ()

@end

@implementation WNXStageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self buildStageInfo];
}

- (void)buildStageInfo {
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:@"03_background-iphone4"];
    [self.view insertSubview:bgImageView belowSubview:self.redButton];
    
    
}

@end
