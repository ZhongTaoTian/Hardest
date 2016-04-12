//
//  WNXStage09ViewController.m
//  Hardest
//
//  Created by sfbest on 16/4/12.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage09ViewController.h"

@interface WNXStage09ViewController ()

@end

@implementation WNXStage09ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self buildStageInfo];
}

- (void)buildStageInfo {
    UIImageView *yellowLineIV1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 16)];
    yellowLineIV1.image = [UIImage imageNamed:@"14_line-iphone4"];
    [self.view addSubview:yellowLineIV1];
    
    UIImageView *yellowLineIV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, ScreenHeight - self.redButton.frame.size.height - 16, ScreenWidth, 16)];
    yellowLineIV2.image = [UIImage imageNamed:@"14_line-iphone4"];
    [self.view addSubview:yellowLineIV2];
    
    [self setButtonImage:[UIImage imageNamed:@"14_stopsign-iphone4"] contenEdgeInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    for (UIButton *btn in self.buttons) {
        [btn addTarget:self action:@selector(stopBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
}

#pragma mark - Action 
- (void)stopBtnClick:(UIButton *)sender {

}

@end
