//
//  WNXStage19ViewController.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/19.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage19ViewController.h"
#import "WNXStage19FishView.h"
#import "WNXCountTimeView.h"
#import <CoreMotion/CoreMotion.h>

@interface WNXStage19ViewController ()
{
    int _index;
    BOOL _hasFish;
    BOOL _playAgain;
}

@property (nonatomic, strong) WNXStage19FishView *fishView;
@property (nonatomic, assign) int hasFishTime;
@property (nonatomic, strong) CADisplayLink *timer1;
@property (nonatomic, assign) int currentFishIndex;
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, assign) int allScore;
@property (nonatomic, assign) int count;

@end

@implementation WNXStage19ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    UIImageView *bgIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - ScreenWidth / 3)];
    bgIV.image = [UIImage imageNamed:@"06_bg-iphone4"];
    [self.view insertSubview:bgIV belowSubview:self.countScore];
    
    [self removeAllImageView];
    
    [super buildStageView];
    
    [self buildFishView];
    
    [self setButtonImage:[UIImage imageNamed:@"06_press-iphone4"] contenEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    
    self.motionManager = [CMMotionManager new];
    
    [self addButtonsActionWithTarget:self action:@selector(fishBite:) forControlEvents:UIControlEventTouchDown];
}

- (void)buildFishView {
    self.fishView = [[WNXStage19FishView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.redButton.frame.size.height)];
    [self.view addSubview:self.fishView];
    [self bringPauseAndPlayAgainToFront];
}

#pragma mark - Action
- (void)fishBite:(UIButton *)sender {
    if (!_hasFish || sender.tag != self.currentFishIndex) {
        [self.timer1 invalidate];
        [(WNXCountTimeView *)self.countScore stopCalculateByTimeWithTimeBlock:nil];
        [self.fishView removeTimer];
        [self showGameFail];
        return;
    }
    
    if (sender.tag == self.currentFishIndex) {
        [self setButtonsIsActivate:NO];
        
        [self.fishView showPromptViewWithIndex:sender.tag];
        
        [self pushAccelerometer];
    }
}

#pragma mark - Super Method
- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    
    _playAgain = NO;
    [self startGoFishing];
}

- (void)playAgainGame {
    [self.stateView removeFromSuperview];
    self.stateView = nil;
    _hasFish = NO;
    _playAgain = YES;
    
    [self.fishView removeData];
    [self.fishView removeFromSuperview];
    self.fishView = nil;
    [(WNXCountTimeView *)self.countScore cleanData];
    
    [self.timer1 invalidate];
    self.timer1 = nil;
    
    self.count = 0;
    _index = 0;
    
    [self.motionManager stopAccelerometerUpdates];
    
    [self buildFishView];
    
    [super buildStageView];
    
    [super playAgainGame];
}

- (void)pauseGame {
    [(WNXCountTimeView *)self.countScore pause];
    [self.fishView pause];
    
    [super pauseGame];
}

- (void)continueGame {
    [super continueGame];
    
    [(WNXCountTimeView *)self.countScore continueGame];
    [self.fishView resume];
}

#pragma mark - Private Method
- (void)startGoFishing {
    
    if (_playAgain) {
        return;
    }
    
    _hasFish = NO;
    
    self.count++;
    
    [(WNXCountTimeView *)self.countScore cleanData];
    [self setButtonsIsActivate:YES];
    
    self.hasFishTime = arc4random_uniform(2) * 60 + arc4random_uniform(60) + 10;
    
    if (self.timer1) {
        [self.timer1 invalidate];
    }
    
    _index = 0;
    self.timer1 = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
    [self.timer1 addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    _currentFishIndex = arc4random_uniform(3);
}

- (void)updateTime {
    _index++;
    
    if (_index == self.hasFishTime) {
        [self.timer1 invalidate];
        [self.fishView showFishBite:self.currentFishIndex];
        _hasFish = YES;
        [(WNXCountTimeView *)self.countScore startCalculateTime];
    }
}

- (void)stopMotionAndShowSucess {
    __weak typeof(self) weakSelf = self;
    
    [self.motionManager stopAccelerometerUpdates];
    
    __block WNXResultStateType type;
    
    [(WNXCountTimeView *)weakSelf.countScore stopCalculateByTimeWithTimeBlock:^(int second, int ms) {
        int onceCount = second * 1000 + ms / 60.0 * 1000;
        
        if (onceCount < 400) {
            type = WNXResultStateTypePerfect;
        } else if (onceCount < 500) {
            type = WNXResultStateTypeGreat;
        } else if (onceCount < 600) {
            type = WNXResultStateTypeGood;
        } else {
            type = WNXResultStateTypeOK;
        }
        
        weakSelf.allScore += onceCount;
    }];
    
    [self.fishView showSucessWithIndex:weakSelf.currentFishIndex finish:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (weakSelf.count == 13) {
                [weakSelf showResultControllerWithNewScroe:weakSelf.allScore / 13 unit:@"ms" stage:weakSelf.stage isAddScore:YES];
            } else {
                [weakSelf startGoFishing];
            }
        });
    }];
    
    [self.stateView showStateViewWithType:type];
}

#pragma mark - 加速计
- (void)pushAccelerometer {
    __block CGFloat startX = -1000;
    __weak typeof(self) weakSelf = self;
    self.motionManager.accelerometerUpdateInterval = 0.01;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        CMAcceleration accelera = accelerometerData.acceleration;
        if (startX == -1000) {
            startX = accelera.x;
        }
        
        if (accelera.x - startX > 0.4 || accelera.x - startX < -0.4) {
            [weakSelf stopMotionAndShowSucess];
        }
    }];
}


@end
