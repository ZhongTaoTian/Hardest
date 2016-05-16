//
//  WNXStage17ViewController.m
//  Hardest
//
//  Created by sfbest on 16/5/16.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage17ViewController.h"
#import "WNXNoseView.h"

@interface WNXStage17ViewController ()

@property (nonatomic, strong) UIImageView *pullIV;
@property (nonatomic, strong) WNXNoseView *noseView;

@end

@implementation WNXStage17ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {    
    self.pullIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, ScreenHeight - ScreenWidth / 3, ScreenWidth, ScreenWidth / 3)];
    self.pullIV.image = [UIImage imageNamed:@"15_button-iphone4"];
    [self.view addSubview:self.pullIV];
    
    self.noseView = [WNXNoseView viewFromNib];
    [self.view addSubview:self.noseView];
    
    [self bringPauseAndPlayAgainToFront];
}

@end
