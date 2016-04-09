//
//  WNXStage07ViewController.m
//  Hardest
//
//  Created by sfbest on 16/4/8.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage07ViewController.h"
#import "WNXStage07View.h"

@interface WNXStage07ViewController ()

@property (nonatomic, strong) WNXStage07View *glassView;

@end

@implementation WNXStage07ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 20)];
    bgImageView.image = [UIImage imageNamed:@"04_background-iphone4"];
    [self.view insertSubview:bgImageView belowSubview:self.playAgainButton];
    
    for (UIButton *btn in self.buttons) {
        [btn setImage:[UIImage imageNamed:@"004_gun-iphone4"] forState:UIControlStateNormal];
        btn.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        [btn addTarget:self action:@selector(gunClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.glassView = [[WNXStage07View alloc] initWithFrame:CGRectMake(0, ScreenHeight - 300 - self.redButton.frame.size.height, ScreenWidth, 300)];
    [self.view addSubview:self.glassView];
    if (self.guideImageView) {
        [self.view bringSubviewToFront:self.guideImageView];
    }
    self.glassView.failBlock = ^{
        NSLog(@"失败");
    };
    
    self.glassView.sucessBlock = ^(int glassCount){
        NSLog(@"成功");
    };
}

- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    
    [self.glassView start];
}

#pragma mark - Action
- (void)gunClick {
    [self.glassView hitGlass];
}

@end
