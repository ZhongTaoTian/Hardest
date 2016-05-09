//
//  WNXStage14ViewController.m
//  Hardest
//
//  Created by sfbest on 16/5/9.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage14ViewController.h"
#import "WNXStage14DogView.h"

@interface WNXStage14ViewController ()

@property (nonatomic, strong) WNXStage14DogView *dogView;

@end

@implementation WNXStage14ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self buildStageInfo];
}

- (void)buildStageInfo {
    self.bgImageView.image = [UIImage imageNamed:@"16_bg-iphone4"];
 
    self.dogView = [WNXStage14DogView viewFromNib];
    self.dogView.frame = ScreenBounds;
    [self.view addSubview:self.dogView];
    
    [self bringPauseAndPlayAgainToFront];
}

@end
