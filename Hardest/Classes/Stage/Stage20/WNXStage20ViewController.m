//
//  WNXStage20ViewController.m
//  Hardest
//
//  Created by sfbest on 16/5/23.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage20ViewController.h"
#import "WNXStage20DiceView.h"

@interface WNXStage20ViewController ()

@property (nonatomic, strong) WNXStage20DiceView *diceView;

@end

@implementation WNXStage20ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    [self setButtonImage:[UIImage imageNamed:@"11_tick-iphone4"] contenEdgeInsets:UIEdgeInsetsMake(25, 25, 25, 25)];
    
    self.diceView = [[WNXStage20DiceView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.redButton.frame.size.height)];
    [self.view insertSubview:self.diceView belowSubview:self.redButton];
    [self bringPauseAndPlayAgainToFront];
    
    [self.redButton addTarget:self action:@selector(aa) forControlEvents:UIControlEventTouchDown];

}

- (void)aa {
    [self.diceView startShakeDice];
}



- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    
}

@end
