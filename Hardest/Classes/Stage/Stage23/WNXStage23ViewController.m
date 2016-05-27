//
//  WNXStage23ViewController.m
//  Hardest
//
//  Created by sfbest on 16/5/27.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage23ViewController.h"
#import "WNXStage10BottomNumView.h"
#import "WNXStage23PeopleView.h"
#import "WNXBusView.h"

@interface WNXStage23ViewController ()

@property (nonatomic, strong) WNXStage10BottomNumView *numView;
@property (nonatomic, strong) WNXStage23PeopleView *peopleView;
@property (nonatomic, strong) WNXBusView *busView;

@end

@implementation WNXStage23ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    [self removeAllImageView];
    
    [self buildBottomNumberView];
    
    [self buildBgImageView];
    
    [self buildPeopleView];
    
    [self buildBusView];
    
    [self addButtonsActionWithTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    [self bringPauseAndPlayAgainToFront];
}

- (void)buildBusView {
    self.busView = [WNXBusView viewFromNib];
//    self.busView.hidden = YES;
    self.busView.frame = CGRectMake(0, 130, self.busView.frame.size.width, self.busView.frame.size.height);
    [self.view addSubview:self.busView];
}

- (void)buildBottomNumberView {
    self.numView = [[WNXStage10BottomNumView alloc] initWithFrame:CGRectMake(0, self.redButton.frame.origin.y + 4, ScreenWidth, self.redButton.frame.size.height)];
    self.numView.userInteractionEnabled = NO;
    self.numView.hidden = YES;
    [self.view insertSubview:self.numView aboveSubview:self.blueButton];
}

- (void)buildBgImageView {
    UIImageView *bgIV = [[UIImageView alloc] initWithFrame:ScreenBounds];
    bgIV.image = [UIImage imageNamed:@"12_bg-iphone4"];
    [self.view insertSubview:bgIV belowSubview:self.redButton];
}

- (void)buildPeopleView {
    self.peopleView = [[WNXStage23PeopleView alloc] initWithFrame:CGRectMake(0, ScreenHeight - ScreenWidth / 3 - 90, ScreenWidth, 100)];
    self.peopleView.hidden = YES;
    [self.view addSubview:self.peopleView];
}

#pragma mark - Super Method
- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    
    [self.view bringSubviewToFront:self.busView];
}

#pragma mark - Action
- (void)btnClick:(UIButton *)sender {
    [self.numView addNumWithIndex:(int)sender.tag];
}


@end
