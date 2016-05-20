//
//  WNXStage19ViewController.m
//  Hardest
//
//  Created by sfbest on 16/5/19.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage19ViewController.h"
#import "WNXStage19FishView.h"

@interface WNXStage19ViewController ()

@property (nonatomic, strong) WNXStage19FishView *fishView;

@end

@implementation WNXStage19ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    [self removeAllImageView];
    [self setButtonImage:[UIImage imageNamed:@"06_press-iphone4"] contenEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    
    self.fishView = [[WNXStage19FishView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.redButton.frame.size.height)];

    [self addButtonsActionWithTarget:self action:@selector(fishBite:) forControlEvents:UIControlEventTouchDown];
    [self bringPauseAndPlayAgainToFront];

}

- (void)fishBite:(UIButton *)sender {
    [self setButtonsIsActivate:NO];
}

@end
