//
//  WNXBaseGameViewController.h
//  Hardest
//
//  Created by sfbest on 16/3/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNXScoreboardCountView.h"
#import "WNXResultViewController.h"
#import "WNXStateView.h"

typedef NS_ENUM(NSInteger, WNXGameGuideType) {
    WNXGameGuideTypeNone = 0,
    WNXGameGuideTypeOneFingerClick,
    WNXGameGuideTypeReplaceClick,
    WNXGameGuideTypeMultiPointClick
};

typedef NS_ENUM(NSInteger, WNXScoreboardType) {
    WNXScoreboardTypeNone = 0,
    WNXScoreboardTypeCountPTS,
    WNXScoreboardTypeTimeMS,
    WNXScoreboardTypeSecondAndMS,
    WNXScoreboardTypeTimeS
};

@interface WNXBaseGameViewController : UIViewController

@property (nonatomic, assign) WNXGameGuideType guideType;
@property (nonatomic, strong) WNXStage *stage;
@property (nonatomic, assign) WNXScoreboardType scoreboardType;
@property (nonatomic, strong) UIImageView *guideImageView;
@property (nonatomic, strong) UIView *countScore;
@property (nonatomic, strong) UIButton *playAgainButton;
@property (nonatomic, strong) UIButton *pauseButton;

@property (nonatomic, strong) WNXStateView *stateView;

- (void)beginGame;
- (void)endGame;
- (void)beginRedayGoView;
- (void)readyGoAnimationFinish;
- (void)pauseGame;
- (void)continueGame;
- (void)playAgainGame;
- (void)showGameFail;

- (void)showResultControllerWithNewScroe:(double)scroe unit:(NSString *)unil stage:(WNXStage *)stage isAddScore:(BOOL)isAddScroe;
- (void)buildStageInfo;

- (void)bringPauseAndPlayAgainToFront;

@end
