//
//  WNXStage24ViewController.m
//  Hardest
//
//  Created by sfbest on 16/5/30.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage24ViewController.h"
#import "WNXJumpPeopleView.h"

@interface WNXStage24ViewController ()

@property (nonatomic, strong) UIImageView *seaIV;
@property (nonatomic, strong) WNXJumpPeopleView *peopleView;
@property (nonatomic, strong) UIImageView *leftTapIV;

@end

@implementation WNXStage24ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    
    [self buildBtn];
    
    [self buildPeopleView];
    
    [self buildBackgroud];
    
    [self bringPauseAndPlayAgainToFront];
}

- (void)buildBtn {
    [self.leftButton setImage:[UIImage imageNamed:@"22_run-iphone4"] forState:UIControlStateNormal];
    self.leftButton.contentEdgeInsets = UIEdgeInsetsMake(32, 42, 32, 42);
    [self.leftButton addTarget:self action:@selector(runClick) forControlEvents:UIControlEventTouchDown];
    
    [self.rightButton setImage:[UIImage imageNamed:@"22_jump-iphone4"] forState:UIControlStateNormal];
    self.rightButton.contentEdgeInsets = UIEdgeInsetsMake(32, 42, 32, 42);
    self.rightButton.enabled = NO;
    [self.rightButton addTarget:self action:@selector(readyJump) forControlEvents:UIControlEventTouchDown];
    [self.rightButton addTarget:self action:@selector(startJump) forControlEvents:UIControlEventTouchUpInside];
    
    self.leftTapIV = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth / 2 - 130) * 0.5, ScreenHeight - self.leftButton.frame.size.height - 48 - 5, 130, 48)];
    self.leftTapIV.image = [UIImage imageNamed:@"22_run instruction-iphone4"];
    self.leftTapIV.hidden = YES;
    self.leftTapIV.transform = CGAffineTransformMakeTranslation(0, 150);
    [self.view insertSubview:self.leftTapIV belowSubview:self.leftTapIV];
}

- (void)buildPeopleView {
    self.peopleView = [WNXJumpPeopleView viewFromNib];
    [self.view insertSubview:self.peopleView belowSubview:self.leftButton];
    
    __weak typeof(self) weakSelf = self;
    self.peopleView.jumpButtonCanClick = ^{
        weakSelf.rightButton.enabled = YES;
    };
}

- (void)buildBackgroud {
    self.backgroundIV.image = [UIImage imageNamed:@"22_bg-iphone4"];
    
    self.seaIV = [[UIImageView alloc] initWithFrame:ScreenBounds];
    _seaIV.image = [UIImage imageNamed:@"22_backsea01-iphone4"];
    _seaIV.animationDuration = 1;
    _seaIV.animationImages = @[[UIImage imageNamed:@"22_backsea01-iphone4"], [UIImage imageNamed:@"22_backsea02-iphone4"]];
    _seaIV.animationRepeatCount = -1;
    [self.view insertSubview:_seaIV aboveSubview:self.backgroundIV];
    
    UIImageView *seaIV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, ScreenHeight - ScreenWidth / 3 - 90, ScreenWidth, 100)];
    seaIV2.image = [UIImage imageNamed:@"22_frontsea-iphone4"];
    [self.view insertSubview:seaIV2 aboveSubview:self.seaIV];
    
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.leftButton.frame.origin.y, ScreenWidth, self.leftButton.frame.size.height)];
    [self.view insertSubview:blackView belowSubview:self.leftButton];
}


#pragma mark - Super Method
- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    
    self.leftTapIV.alpha = 1;
    self.leftTapIV.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.leftTapIV.transform = CGAffineTransformIdentity;
    }];
    
    [self.seaIV startAnimating];
}

#pragma mark - Action
- (void)runClick {
    [UIView animateWithDuration:0.5 animations:^{
        self.leftTapIV.alpha = 0;
    }];
    [self.peopleView run];
}

- (void)readyJump {
    self.leftButton.enabled = NO;
    [self.peopleView readyJump];
}

- (void)startJump {
    self.rightButton.enabled = NO;
    [self.peopleView startJump];
}

@end
