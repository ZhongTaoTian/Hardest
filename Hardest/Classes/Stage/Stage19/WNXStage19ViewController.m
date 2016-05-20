//
//  WNXStage19ViewController.m
//  Hardest
//
//  Created by sfbest on 16/5/19.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage19ViewController.h"
#import "WNXStage19FishView.h"
#import "WNXCountTimeView.h"
#import <CoreMotion/CoreMotion.h>

@interface WNXStage19ViewController ()
{
    int _index;
    BOOL _hasFish;
}

@property (nonatomic, strong) WNXStage19FishView *fishView;
@property (nonatomic, assign) int hasFishTime;
@property (nonatomic, strong) CADisplayLink *timer1;
@property (nonatomic, assign) int currentFishIndex;
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, assign) int allScore;

@end

@implementation WNXStage19ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    [self removeAllImageView];
    [super buildStageView];
    
    [self setButtonImage:[UIImage imageNamed:@"06_press-iphone4"] contenEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    
    self.fishView = [[WNXStage19FishView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.redButton.frame.size.height)];
    [self.view addSubview:self.fishView];
    
    self.motionManager = [CMMotionManager new];
    
    [self addButtonsActionWithTarget:self action:@selector(fishBite:) forControlEvents:UIControlEventTouchDown];
    [self bringPauseAndPlayAgainToFront];
}

#pragma mark - Action
- (void)fishBite:(UIButton *)sender {
    if (!_hasFish) {
        [self.timer1 invalidate];
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
    
    [self startGoFishing];
}

#pragma mark - Private Method
- (void)startGoFishing {
    _hasFish = NO;
    [(WNXCountTimeView *)self.countScore cleanData];
    [self setButtonsIsActivate:YES];
    self.hasFishTime = arc4random_uniform(2) * 60 + arc4random_uniform(60);
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
        _hasFish = YES;
        [self.fishView showFishBite:self.currentFishIndex];
        [(WNXCountTimeView *)self.countScore startCalculateTime];
    }
}

- (void)stopMotionAndShowSucess {
    __weak typeof(self) weakSelf = self;
    
    [self.motionManager stopAccelerometerUpdates];
    
    __block WNXResultStateType type;
    
    [(WNXCountTimeView *)weakSelf.countScore stopCalculateByTimeWithTimeBlock:^(int second, int ms) {
        int onceCount = second * 1000 + ms / 60.0 * 1000;
        
        if (onceCount < 350) {
            type = WNXResultStateTypePerfect;
        } else if (onceCount < 420) {
            type = WNXResultStateTypeGreat;
        } else if (onceCount < 500) {
            type = WNXResultStateTypeGood;
        } else {
            type = WNXResultStateTypeOK;
        }
        
        weakSelf.allScore += onceCount;
    }];
    
    [self.fishView showSucessWithIndex:weakSelf.currentFishIndex finish:^{
        [self startGoFishing];
    }];
    
    [self.stateView showStateViewWithType:type];
}

#pragma mark - 加速计
- (void)pushAccelerometer {
    __block CGFloat startX = -100;
    __weak typeof(self) weakSelf = self;
    self.motionManager.accelerometerUpdateInterval = 0.01;
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        CMAcceleration accelera = accelerometerData.acceleration;
        if (startX == -100) {
            startX = accelera.x;
        }
        
        if (accelera.x - startX > 0.4 || accelera.x - startX < -0.4) {
            [weakSelf stopMotionAndShowSucess];
        }
    }];
}


@end
