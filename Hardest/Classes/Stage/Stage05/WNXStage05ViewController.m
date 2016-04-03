//
//  WNXStage05ViewController.m
//  Hardest
//
//  Created by MacBook on 16/4/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage05ViewController.h"

@interface WNXStage05ViewController ()

@end

@implementation WNXStage05ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

#pragma mark - Build UI
- (void)buildStageInfo {
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:@"03_background-iphone4"];
    [self.view insertSubview:bgImageView belowSubview:self.redButton];
    
    [self setButtonsInfo];
    
    [self buildEggRoll];
    
}

- (void)setButtonsInfo {
    for (UIButton *btn in self.buttons) {
        [btn setImage:[UIImage imageNamed:@"03_button-iphone4"] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    }
}

- (void)buildEggRoll {
    CGFloat eggIVW = 100;
    CGFloat eggIVH = 204;
    CGFloat margin = (ScreenWidth / 3 - eggIVW) * 0.5;
    for (int i = 0; i < 3; i++) {
        UIImageView *eggIV = [[UIImageView alloc] initWithFrame:CGRectMake(margin + i * (eggIVW + margin * 2), ScreenHeight - self.redButton.bounds.size.height - 85, eggIVW, eggIVH)];
        eggIV.image = [UIImage imageNamed:@"03_cones-iphone4"];
        [self.view insertSubview:eggIV belowSubview:self.redButton];
    }
    
    [self.view bringSubviewToFront:self.playAgainButton];
    [self.view bringSubviewToFront:self.pauseButton];
    
    if (self.guideImageView) {
        [self.view bringSubviewToFront:self.guideImageView];
    }
}

@end
