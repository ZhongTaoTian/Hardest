//
//  WNXBaseGameViewController.m
//  Hardest
//
//  Created by sfbest on 16/3/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXBaseGameViewController.h"
#import "WNXStageInfo.h"
#import "WNXReadyGoView.h"

@interface WNXBaseGameViewController ()
{
    float _volume;
}

@end

@implementation WNXBaseGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initGuideImageView];
    
    [self showGuideImageView];
}

- (void)dealloc {
     NSLog(@"%s", __func__);
}

- (void)initGuideImageView {
    self.guideImageView = [[UIImageView alloc] initWithFrame:ScreenBounds];
    [self.view addSubview:self.guideImageView];
}

- (void)showGuideImageView {
    if (!(([self.stage.userInfo.rank isEqualToString:@"f"] || self.stage.userInfo.rank == nil || self.stage.userInfo == nil) && self.guideType != WNXGameGuideTypeNone)) {
        [self.guideImageView removeFromSuperview];
        return;
    }
    
    NSArray *animationImages;
    if (self.guideType == WNXGameGuideTypeOneFingerClick) {
        animationImages = @[[UIImage imageNamed:@"03-1-iphone4"], [UIImage imageNamed:@"03-2-iphone4"]];
    } else if (self.guideType == WNXGameGuideTypeReplaceClick) {
        animationImages = @[[UIImage imageNamed:@"01-1-iphone4"], [UIImage imageNamed:@"01-2-iphone4"]];
    } else if (self.guideType == WNXGameGuideTypeMultiPointClick) {
        animationImages = @[[UIImage imageNamed:@"02-1-iphone4"], [UIImage imageNamed:@"02-2-iphone4"], [UIImage imageNamed:@"02-4-iphone4"], [UIImage imageNamed:@"02-5-iphone4"]];
    }
    
    self.guideImageView.animationDuration = animationImages.count * 0.15;
    self.guideImageView.animationImages = animationImages;
    self.guideImageView.animationRepeatCount = -1;
    [self.guideImageView startAnimating];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(guideImageViewClick)];
    self.guideImageView.userInteractionEnabled = YES;
    [self.guideImageView addGestureRecognizer:tap];
}

- (void)guideImageViewClick {
    [self.guideImageView removeFromSuperview];
    self.countScore.hidden = NO;
    
    __weak __typeof(self) weakSelf = self;
    if (self.scoreboardType == WNXScoreboardTypeCountPTS) {
        [(WNXScoreboardCountView *)self.countScore startAnimationWithCompletion:^(BOOL finished) {
            [weakSelf beginRedayGoView];
        }];
    }
}

- (void)setScoreboardType:(WNXScoreboardType)scoreboardType {
    _scoreboardType = scoreboardType;
    
    if (scoreboardType == WNXScoreboardTypeNone) {
        return;
    } else if (scoreboardType == WNXScoreboardTypeCountPTS) {
        self.countScore = [WNXScoreboardCountView viewFromNib];
        self.countScore.hidden = YES;
        self.countScore.frame = CGRectMake(-40, -180, self.countScore.frame.size.width, self.countScore.frame.size.height);
        if (self.guideImageView) {
            [self.view insertSubview:self.countScore belowSubview:self.guideImageView];
        } else {
            [self.view addSubview:self.countScore];
        }
        return;
    }
}

#pragma mark -
#pragma mark - public method
- (void)beginRedayGoView {
    [WNXReadyGoView showReadyGoViewWithSuperView:self.view completion:^{
        [self readyGoAnimationFinish];
    }];
}

#pragma mark - 
#pragma ChildViewController method
- (void)readyGoAnimationFinish{}

- (void)beginGame {
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"kMusicType"] == SoundPlayTypeMute) {
        [[WNXSoundToolManager sharedSoundToolManager] setBackgroundMusicVolume:0.3];
        _volume = 0.3;
    }
}
- (void)endGame {
    if (_volume) {
        [[WNXSoundToolManager sharedSoundToolManager] setBackgroundMusicVolume:1.0];
    }
}


@end
