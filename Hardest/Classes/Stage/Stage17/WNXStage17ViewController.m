//
//  WNXStage17ViewController.m
//  Hardest
//
//  Created by sfbest on 16/5/16.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage17ViewController.h"
#import "WNXNoseView.h"
#import "WNXPowerView.h"

@interface WNXStage17ViewController ()

@property (nonatomic, strong) UIImageView *pullIV;
@property (nonatomic, strong) WNXNoseView *noseView;
@property (nonatomic, strong) WNXPowerView *powerView;
@property (nonatomic, strong) CADisplayLink *timer;

@end

@implementation WNXStage17ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    self.noseView = [WNXNoseView viewFromNib];
    [self.view addSubview:self.noseView];
    
    self.pullIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, ScreenHeight - ScreenWidth / 3 + 10, ScreenWidth, ScreenWidth / 3 - 10)];
    self.pullIV.image = [UIImage imageNamed:@"15_button-iphone4"];
    self.pullIV.userInteractionEnabled = YES;
    [self.pullIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pullClick)]];
    [self.view addSubview:self.pullIV];
    
    self.powerView = [WNXPowerView viewFromNib];
    self.powerView.frame = CGRectMake(0, ScreenHeight - ScreenWidth / 3 - self.powerView.frame.size.height + 10, self.powerView.frame.size.width, self.powerView.frame.size.height);
    [self.view addSubview:self.powerView];
    
    [self bringPauseAndPlayAgainToFront];
}

- (void)pullClick {
    self.pullIV.hidden = YES;
    [self.noseView showPullAnimationWithIsPullOut:NO score:100 finish:^{
        
    }];
}

@end
