//
//  WNXStage04ViewController.m
//  Hardest
//
//  Created by sfbest on 16/3/31.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage04ViewController.h"

@interface WNXStage04ViewController ()

@end

@implementation WNXStage04ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setStageInfo];
}

- (void)setStageInfo {
    self.backgroundIV.image = [UIImage imageNamed:@"05_bg-iphone4"];
    
    [self.leftButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.rightButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    [self.view bringSubviewToFront:self.guideImageView];
}

- (void)buttonClick:(UIButton *)sender {

}

@end
