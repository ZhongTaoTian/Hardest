//
//  WNXStage16ViewController.m
//  Hardest
//
//  Created by MacBook on 16/5/15.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage16ViewController.h"
#import "WNXStage16PeopleView.h"
#import "WNXScoreboardCountView.h"
#import "WNXCountDownLabel.h"
#import "UIColor+WNXColor.h"

#define kTextOrangeColor [UIColor colorWithR:252 g:120 b:35]

@interface WNXStage16ViewController ()
{
    BOOL _frist;
}

@property (nonatomic, strong) WNXStage16PeopleView *peopleView;
@property (nonatomic, strong) WNXCountDownLabel *timeLabel;
@property (nonatomic, assign) int count;

@end

@implementation WNXStage16ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ;
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
    self.rightButton.enabled = NO;
    
    [self.view bringSubviewToFront:self.guideImageView];
    [self.leftButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [self.rightButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    self.peopleView = [WNXStage16PeopleView viewFromNib];
    [self.view insertSubview:self.peopleView belowSubview:bottomBlackView];
    
    self.timeLabel = [[WNXCountDownLabel alloc] initWithFrame:CGRectMake(210, 325, 110, 90) startTime:6.0 textSize:60];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.transform = CGAffineTransformMakeRotation(-M_PI_4 / 12);
    [self.timeLabel setTextColor:kTextOrangeColor borderColor:[UIColor blackColor] borderWidth:5];
    [self.view addSubview:self.timeLabel];
    
    _frist = YES;
    
    [self bringPauseAndPlayAgainToFront];
}

- (void)btnClick:(UIButton *)sender {
    sender.enabled = NO;
    _count++;
    [(WNXScoreboardCountView *)self.countScore hit];
    if (sender.tag == 1) {
        self.rightButton.enabled = YES;
    } else {
        self.leftButton.enabled = YES;
    }
    [self.peopleView ullUpsWithIndex:sender.tag];
    if (_frist) {
        __weak typeof(self) weakSelf = self;
        [(WNXCountDownLabel *)self.timeLabel startCountDownWithCompletion:^{
            [weakSelf.view setUserInteractionEnabled:NO];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf showResultControllerWithNewScroe:weakSelf.count unit:@"PTS" stage:weakSelf.stage isAddScore:YES];
            });
        }];
        _frist = NO;
    }
}

- (void)pauseGame {
    [(WNXCountDownLabel *)self.timeLabel pause];
    
    [super pauseGame];
}

- (void)continueGame {
    [super continueGame];
    [(WNXCountDownLabel *)self.timeLabel continueWork];
}

- (void)playAgainGame {
    [self.view setUserInteractionEnabled:NO];
    [self.peopleView resumeData];
    [self.timeLabel clean];
    [(WNXScoreboardCountView *)self.countScore clean];
    _frist = YES;
    self.leftButton.enabled = YES;;
    self.rightButton.enabled = NO;
    
    [super playAgainGame];
}

@end
