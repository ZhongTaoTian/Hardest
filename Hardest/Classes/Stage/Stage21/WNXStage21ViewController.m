//
//  WNXStage21ViewController.m
//  Hardest
//
//  Created by sfbest on 16/5/24.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage21ViewController.h"

@interface WNXStage21ViewController ()

@end

@implementation WNXStage21ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    self.backgroundIV.image = [UIImage imageNamed:@"13_bg-iphone4"];
    
    UIImageView *lineIV = [[UIImageView alloc] initWithFrame:CGRectMake(156, 0, 8, ScreenHeight)];
    lineIV.image = [UIImage imageNamed:@"17_blackline-iphone4"];
    [self.view insertSubview:lineIV belowSubview:self.leftButton];
    
    [self.leftButton setImage:[UIImage imageNamed:@"17_bigger-iphone4"] forState:UIControlStateNormal];
    self.leftButton.contentEdgeInsets = UIEdgeInsetsMake(50, 30, 15, 30);

    [self.rightButton setImage:[UIImage imageNamed:@"17_bigger-iphone4"] forState:UIControlStateNormal];
    self.rightButton.contentEdgeInsets = UIEdgeInsetsMake(50, 30, 15, 30);
    
    UIImageView *arrow1 = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth / 2 - 40) * 0.5, ScreenHeight - 80, 40, 20)];
    arrow1.image = [UIImage imageNamed:@"17_triangle-iphone4"];
    [self.view addSubview:arrow1];
    
    UIImageView *arrow2 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth / 2 + (ScreenWidth / 2 - 40) * 0.5, ScreenHeight - 80, 40, 20)];
    arrow2.image = [UIImage imageNamed:@"17_triangle-iphone4"];
    [self.view addSubview:arrow2];
    
    [self buildNumberView];
}

- (void)buildNumberView {}

@end
