//
//  WNXStage16ViewController.m
//  Hardest
//
//  Created by MacBook on 16/5/15.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage16ViewController.h"
#import "WNXStage16PeopleView.h"

@interface WNXStage16ViewController ()

@property (nonatomic, strong) WNXStage16PeopleView *peopleView;

@end

@implementation WNXStage16ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    UIImageView *bgIV = [[UIImageView alloc] initWithFrame:ScreenBounds];
    bgIV.image = [UIImage imageNamed:@"21_bg-iphone4"];
    [self.view insertSubview:bgIV belowSubview:self.leftButton];
    
    UIView *bottomBlackView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - ScreenWidth / 3 + 10, ScreenWidth, ScreenWidth / 3 - 10)];
    bottomBlackView.backgroundColor = [UIColor blackColor];
    [self.view insertSubview:bottomBlackView belowSubview:self.leftButton];
    
    [self.leftButton setImage:[UIImage imageNamed:@"21_up-iphone4"] forState:UIControlStateNormal];
    self.leftButton.imageEdgeInsets = UIEdgeInsetsMake(35, 40, 35, 40);
    self.leftButton.imageView.contentMode = UIViewContentModeScaleAspectFit;

    
    [self.rightButton setImage:[UIImage imageNamed:@"21_down-iphone4"] forState:UIControlStateNormal];
    self.rightButton.imageEdgeInsets = UIEdgeInsetsMake(5, 40, 5, 40);
    self.rightButton.imageView.contentMode = UIViewContentModeScaleAspectFit;

    [self.view bringSubviewToFront:self.guideImageView];
    [self.leftButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [self.rightButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    self.peopleView = [WNXStage16PeopleView viewFromNib];
    [self.view insertSubview:self.peopleView belowSubview:bottomBlackView];
    
    [self bringPauseAndPlayAgainToFront];
}

- (void)btnClick:(UIButton *)sender {
    sender.enabled = NO;

    if (sender.tag == 1) {
        self.rightButton.enabled = YES;
    } else {
        self.leftButton.enabled = YES;
    }
    [self.peopleView ullUpsWithIndex:sender.tag];
}

@end
