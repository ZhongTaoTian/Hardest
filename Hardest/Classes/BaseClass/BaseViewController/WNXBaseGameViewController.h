//
//  WNXBaseGameViewController.h
//  Hardest
//
//  Created by sfbest on 16/3/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNXScoreboardCountView.h"

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
    WNXScoreboardTypeTimeS
};

@interface WNXBaseGameViewController : UIViewController

@property (nonatomic, assign) WNXGameGuideType guideType;
@property (nonatomic, strong) WNXStage *stage;
@property (nonatomic, assign) WNXScoreboardType scoreboardType;
@property (nonatomic, strong) UIImageView *guideImageView;

// 积分板
@property (nonatomic, strong) UIView *countScore;

- (void)beginGame;

- (void)endGame;

- (void)beginRedayGoView;

- (void)readyGoAnimationFinish;

@end
