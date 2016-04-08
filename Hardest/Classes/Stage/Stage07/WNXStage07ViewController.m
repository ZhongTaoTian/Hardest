//
//  WNXStage07ViewController.m
//  Hardest
//
//  Created by sfbest on 16/4/8.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage07ViewController.h"

@interface WNXStage07ViewController ()

@end

@implementation WNXStage07ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.redButton.frame.size.height + 10)];
    bgImageView.image = [UIImage imageNamed:@"04_background-iphone4"];
    [self.view insertSubview:bgImageView belowSubview:self.redButton];
}

@end
