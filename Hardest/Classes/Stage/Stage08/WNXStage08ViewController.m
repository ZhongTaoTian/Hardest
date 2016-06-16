//
//  WNXStage08ViewController.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/4/11.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage08ViewController.h"
#import "WNXStage08PeopleView.h"
#import "WNXScoreboardCountView.h"

@interface WNXStage08ViewController ()

@property (nonatomic, strong) WNXStage08PeopleView *photoView;

@end

@implementation WNXStage08ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self buildStageInfo];
}

- (void)buildStageInfo {
    [self removeAllImageView];
    UIImageView *bgImageIV = [[UIImageView alloc] initWithFrame:CGRectMake(-20, 0, ScreenWidth + 40, ScreenHeight)];
    bgImageIV.image = [UIImage imageNamed:@"02_background01-iphone4"];
    [self.view insertSubview:bgImageIV belowSubview:self.redButton];
    
    self.photoView = [WNXStage08PeopleView viewFromNib];
    self.photoView.frame = CGRectMake(0, ScreenHeight - self.redButton.frame.size.height - self.photoView.frame.size.height, ScreenWidth, self.photoView.frame.size.height);
    [self.view insertSubview:self.photoView aboveSubview:self.redButton];
    
    [self setButtonImage:[UIImage imageNamed:@"02_camera-iphone4"] contenEdgeInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    
    [self setPhotoViewBlock];
        
    [self addButtonsActionWithTarget:self action:@selector(cameraClick:) forControlEvents:UIControlEventTouchDown];
    
    [self bringPauseAndPlayAgainToFront];
}

- (void)cameraClick:(UIButton *)sender {
    if ([self.photoView takePhotoWithIndex:(int)sender.tag]) {
        [((WNXScoreboardCountView *)self.countScore) hit];
    } else {
        [self.photoView stopTime];
        [self setButtonsIsActivate:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showGameFail];
        });
    }
}

- (void)setPhotoViewBlock {
    __weak typeof(self) weakSelf = self;
    self.photoView.startTakePhoto = ^{
        [weakSelf setButtonsIsActivate:YES];
    };
    
    self.photoView.shopTakePhoto = ^{
        [weakSelf setButtonsIsActivate:NO];
    };
    
    self.photoView.nextTakePhoto = ^(BOOL isPass){
        if (!isPass) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.photoView showModel];
            });
        } else {
            [weakSelf showResultControllerWithNewScroe:[((WNXScoreboardCountView *)weakSelf.countScore).countLabel.text intValue] unit:@"PTS" stage:weakSelf.stage isAddScore:YES];
        }
    };
}

#pragma mark - Super Method
- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    [self setButtonsIsActivate:NO];
    [self.photoView showModel];
}

- (void)playAgainGame {
    [self.photoView cleanDate];
    [(WNXScoreboardCountView *)self.countScore clean];
    [super playAgainGame];
}

- (void)pauseGame {
    [self.photoView pause];
    [super pauseGame];
}

- (void)continueGame {
    [super continueGame];
    [self.photoView resume];
}

@end
