//
//  WNXStage03ViewController.m
//  Hardest
//
//  Created by MacBook on 16/3/27.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage03ViewController.h"
#import "WNXStage03HeaderView.h"

@interface WNXStage03ViewController ()

@property (nonatomic, strong) WNXStage03HeaderView *headerView;

@end

@implementation WNXStage03ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self stageInfo];
}

- (void)stageInfo {
    self.backgroundIV.image = [UIImage imageNamed:@"23_bg-iphone4"];
    
    [self.leftButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.rightButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    self.headerView = [[WNXStage03HeaderView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(self.leftButton.frame) - 250, ScreenWidth, 350)];
    [self.view addSubview:self.headerView];
    [self.view insertSubview:self.headerView belowSubview:self.leftButton];
    
    [self buildBottomImageView];
    
    [self.view bringSubviewToFront:self.guideImageView];
}

- (void)buildBottomImageView {
    [self buildBottonImageViewWithFrame:CGRectMake(13, 0, 55, 40) image:[UIImage imageNamed:@"23_Rarrow-iphone4"]];
    [self buildBottonImageViewWithFrame:CGRectMake(78, 0 , 66, 64) image:[UIImage imageNamed:@"23_bticon-iphone4"]];
    [self buildBottonImageViewWithFrame:CGRectMake(ScreenWidth * 0.5 + 13, 0, 66, 64) image:[UIImage imageNamed:@"23_bticon-iphone4"]];
    [self buildBottonImageViewWithFrame:CGRectMake(ScreenWidth * 0.5 + 79 + 10, 0, 55, 40) image:[UIImage imageNamed:@"23_Barrow-iphone4"]];
    
}

- (void)buildBottonImageViewWithFrame:(CGRect)frame image:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.center = CGPointMake(imageView.center.x, self.rightButton.center.y);
    imageView.image = image;
    [self.view addSubview:imageView];
}
#pragma mark - Override Method

#pragma mark - Action
- (void)buttonClick:(UIButton *)sender {
    if (sender.tag == 1) {
        [self.headerView test];
    } else if(sender.tag == 2) {
        [self.headerView test1];
    }
}

@end
