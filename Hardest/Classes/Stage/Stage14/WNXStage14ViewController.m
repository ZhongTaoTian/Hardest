//
//  WNXStage14ViewController.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/9.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage14ViewController.h"
#import "WNXStage14DogView.h"
#import "WNXStage14LineView.h"
#import <CoreMotion/CoreMotion.h>
#import "WNXTimeCountView.h"

@interface WNXStage14ViewController ()
{
    int _index;
    int _count;
    BOOL _isToRight;
    int _randomTime;
}

@property (nonatomic, strong) WNXStage14DogView *dogView;
@property (nonatomic, strong) WNXStage14LineView *lineView;
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, assign) float angle;
@property (nonatomic, assign) NSTimeInterval scroe;

@property (nonatomic, strong) CADisplayLink *timer;

@end

@implementation WNXStage14ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTimer) name:kPauseViewControllerClickBackToMainViewController object:nil];
    
    [self buildStageInfo];
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)buildStageInfo {
    self.bgImageView.image = [UIImage imageNamed:@"16_bg-iphone4"];
    
    self.motionManager = [CMMotionManager new];
    
    self.dogView = [WNXStage14DogView viewFromNib];
    self.dogView.layer.anchorPoint = CGPointMake(0.5, 1);
    self.dogView.frame = CGRectMake(0, ScreenHeight - self.dogView.frame.size.height + 10, ScreenWidth, self.dogView.frame.size.height);
    [self.view addSubview:self.dogView];
    
    self.lineView = [WNXStage14LineView viewFromNib];
    self.lineView.frame = CGRectMake(0, ScreenHeight - self.dogView.frame.size.height - self.lineView.frame.size.height + 60, ScreenWidth, self.lineView.frame.size.height);
    [self.view addSubview:self.lineView];
    
    [self bringPauseAndPlayAgainToFront];
}

#pragma mark - Super Method
- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    
    __weak typeof(self) weakSelf = self;
    [self.lineView startShakePhoneAnimationWithFinish:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.dogView showBoneViewWithAnimationFinish:^{
            [weakSelf.motionManager startAccelerometerUpdates];
            weakSelf.lineView.arrowIV.hidden = NO;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf pushAccelerometer];
                [weakSelf startRotation];
                [(WNXTimeCountView *)weakSelf.countScore startCalculateTime];
            });
        }];
    });
}

- (void)pauseGame {
    self.timer.paused = YES;
    [(WNXTimeCountView *)self.countScore pause];
    [self.motionManager stopAccelerometerUpdates];
    
    [super pauseGame];
}

- (void)continueGame {
    [super continueGame];
    
    [(WNXTimeCountView *)self.countScore resumed];
    [self pushAccelerometer];
    self.timer.paused = NO;
}

- (void)playAgainGame {
    [(WNXTimeCountView *)self.countScore cleadData];
    
    [self.timer invalidate];
    self.timer = nil;
    _index = 0;
    _count = 0;
    
    [self.motionManager stopAccelerometerUpdates];
    
    [self.dogView resumeData];
    [self.lineView resumeData];
    
    
    [super playAgainGame];
}

#pragma mark - 加速计
- (void)pushAccelerometer {
    self.motionManager.accelerometerUpdateInterval = 0.01;
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        CMAcceleration accelera = accelerometerData.acceleration;
        if (accelera.x >= -0.1 && accelera.x <= 0.1) {
            return;
        }
        
        if (accelera.x < 0) {
            self.angle = [self.dogView shakeToLeftWithOffset:accelera.x];
        } else {
            self.angle = [self.dogView shakeToRithgWithOffset:accelera.x];
        }
    }];
}

#pragma mark - Private Method
- (void)startRotation {
    _isToRight = arc4random_uniform(2);
    _randomTime = arc4random_uniform(3) + 3 + arc4random_uniform(10) / 10.0;
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateTime {
    _index++;
    
    float speed;
    if (_index <= 4 * 60) {
        speed = 0.2;
    } else if (_index <= 8 * 60) {
        speed = 0.3;
    } else if (_index <= 12 * 60) {
        speed = 0.4;
    } else if (_index <= 16 * 60) {
        speed = 0.5;
    } else if (_index <= 20 * 60) {
        speed = 0.6;
    } else {
        speed = 0.7;
    }
    _count++;
    if (_isToRight) {
        self.angle = [self.dogView rotationToRightWithSpeed:speed];
    } else {
        self.angle = [self.dogView rotationToLeftWithSpeed:speed];
    }
    
    if (_count == (int)_randomTime * 60) {
        _isToRight = !_isToRight;
        _count = 0;
        _randomTime = arc4random_uniform(3) + 3 + arc4random_uniform(10) / 10.0;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setAngle:(float)angle {
    _angle = angle;
    
    [self.lineView arrowPromptWithAngle:angle];
    
    if (angle > 0.8 || angle < -0.8) {
        self.view.userInteractionEnabled = NO;
        self.scroe = [(WNXTimeCountView *)self.countScore stopCalculateTime];
        [self.motionManager stopAccelerometerUpdates];
        [self.timer invalidate];
        self.timer = nil;
        
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundDogbarkTwoName];
        
        __weak typeof(self) weakSelf = self;
        [self.dogView startDropBoneDirectionIsRight:angle > 0.8 finish:^{
            [weakSelf showResultControllerWithNewScroe:weakSelf.scroe unit:@"秒" stage:weakSelf.stage isAddScore:YES];
        }];
    }
}

@end
