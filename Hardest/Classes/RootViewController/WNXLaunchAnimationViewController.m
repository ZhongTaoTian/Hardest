//
//  LaunchAnimationViewController.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/2/23.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXLaunchAnimationViewController.h"

#define kMaxHandClickCount 15
#define kClickAnimationDuration 0.1

@interface WNXLaunchAnimationViewController ()
{
    int _clickCount;
    int _keyCount;
    BOOL _isNotFristLoad;
}

@property (weak, nonatomic) IBOutlet UIImageView *handImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bombButtonImageView;
@property (weak, nonatomic) IBOutlet UIImageView *buttonImageView;
@property (weak, nonatomic) IBOutlet UIView *eyeMaskView;
@property (weak, nonatomic) IBOutlet UIImageView *blackIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *normalIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomBombImageView;
@property (weak, nonatomic) IBOutlet UIImageView *topBombImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *topBombImageView2;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *smokeImageViews;


@end

@implementation WNXLaunchAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.clipsToBounds = NO;
    
    if (!iPhone5) {
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 480, 320, ScreenHeightDifference)];
        bottomView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bottomView];
    }
    
    self.handImageView.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    
    if (!_isNotFristLoad && !iPhone5) {
        CGRect newFrame = self.view.frame;
        newFrame.origin.y -= ScreenHeightDifference;
        self.view.frame = newFrame;
    }
    
    [super viewDidAppear:animated];
    
    self.blackIconImageView.hidden = YES;
    self.bombButtonImageView.hidden = YES;
    self.eyeMaskView.hidden = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.handImageView.hidden = NO;
        for (int i = 0; i < kMaxHandClickCount; i++) {
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:i * kClickAnimationDuration target:self selector:@selector(handButtonImageViewClickAnimation) userInfo:nil repeats:NO];
            [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        }
        
        _isNotFristLoad = YES;
    });
}

- (void)handButtonImageViewClickAnimation {
    self.handImageView.hidden = NO;
    _clickCount++;
    
    [UIView animateWithDuration:kClickAnimationDuration * 0.5 animations:^{
        self.handImageView.transform = CGAffineTransformMakeTranslation(0, 20);
    } completion:^(BOOL finished) {
        
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundLaunchClickName];
        
        self.buttonImageView.image = [UIImage imageNamed:@"play_01-iphone4"];
        [UIView animateWithDuration:kClickAnimationDuration * 0.5 animations:^{
            self.handImageView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            self.buttonImageView.image = [UIImage imageNamed:@"play_00-iphone4"];
            
            if (_clickCount == kMaxHandClickCount - 1) {
                [self startBombAnimation];
                
            }
        }];
    }];
    
}

- (void)startBombAnimation {
    
    self.topBombImageView2.layer.anchorPoint = CGPointMake(0.5, 1);
    self.topBombImageView1.layer.anchorPoint = CGPointMake(0.5, 1);
    self.bottomBombImageView.layer.anchorPoint = CGPointMake(0.5, 1);
    
    self.bottomBombImageView.hidden = NO;
    self.topBombImageView2.hidden = NO;
    self.topBombImageView1.hidden = NO;
    
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundLaunchBoum];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.bottomBombImageView.transform = CGAffineTransformMakeScale(4.0, 4.0);
        self.topBombImageView1.transform = CGAffineTransformMakeScale(4.0, 4.0);
        self.topBombImageView2.transform = CGAffineTransformMakeScale(4.0, 4.0);
    } completion:^(BOOL finished) {
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundLaunchBoum2];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.buttonImageView removeFromSuperview];
            
            self.normalIconImageView.hidden = YES;
            self.blackIconImageView.hidden = NO;
            self.bottomBombImageView.hidden = YES;
            self.topBombImageView1.hidden = YES;
            self.topBombImageView2.hidden = YES;
            self.bombButtonImageView.hidden = NO;
            self.handImageView.image = [UIImage imageNamed:@"boy_03-iphone4"];
            
            [self smokeAnimation];
            
        });
    }];
}

- (void)smokeAnimation {
    
    for (int i = 0; i < self.smokeImageViews.count; i++) {
        UIImageView *smokeImageView = self.smokeImageViews[i];
        smokeImageView.layer.anchorPoint = CGPointMake(0.5, 1);
        smokeImageView.hidden = NO;
        
        [[CADisplayLink displayLinkWithTarget:self selector:@selector(update:)] addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        
        [UIView animateWithDuration:0.9 animations:^{
            smokeImageView.transform = CGAffineTransformMakeScale(1, 2);
            smokeImageView.alpha = 0.4;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                smokeImageView.alpha = 0;
            } completion:^(BOOL finished) {
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (self.animationFinish) {
                        self.animationFinish();
                    }
                });
                
            }];
        }];
    }
    
}

- (void)update:(CADisplayLink *)timer {
    _keyCount++;
    
    if (_keyCount == 15) {
        self.eyeMaskView.hidden = NO;
    }
    
    if (_keyCount == 30) {
        self.eyeMaskView.hidden = YES;
    }
    
    if (_keyCount == 45) {
        self.eyeMaskView.hidden = NO;
    }
    
    if (_keyCount == 60) {
        self.eyeMaskView.hidden = YES;
    }
    
    if (_keyCount == 20 || _keyCount == 40) {
        for (int i = 0; i < self.smokeImageViews.count; i++) {
            UIImageView *smokeImageView = self.smokeImageViews[i];
            if (_keyCount == 20) {
                smokeImageView.image = [UIImage imageNamed:@"smoke_stream_02-iphone4"];
            } else {
                smokeImageView.image = [UIImage imageNamed:@"smoke_stream_01-iphone4"];
            }
        }
    }
    
    if (_keyCount == 60) {
        [timer invalidate];
    }
}

@end
