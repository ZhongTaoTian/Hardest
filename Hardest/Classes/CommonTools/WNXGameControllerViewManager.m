//
//  WNXGameControllerViewManager.m
//  Hardest
//
//  Created by sfbest on 16/3/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXGameControllerViewManager.h"
#import "WNXRYBViewController.h"
#import "WNXStage01ViewController.h"
#import "WNXStage02ViewController.h"
#import "WNXStage03ViewController.h"
#import "WNXStage04ViewController.h"
#import "WNXStage05ViewController.h"
#import "WNXStage06ViewController.h"
#import "WNXStage07ViewController.h"
#import "WNXStage08ViewController.h"
#import "WNXStage09ViewController.h"
#import "WNXStage10ViewController.h"
#import "WNXStage11ViewController.h"
#import "WNXStage12ViewController.h"

@implementation WNXGameControllerViewManager

+ (WNXBaseGameViewController *)viewControllerWithStage:(WNXStage *)stage {
    WNXBaseGameViewController *gameVC;
    
    switch (stage.num) {
        case 1:
            gameVC = [[WNXStage01ViewController alloc] init];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeOneFingerClick;
            gameVC.scoreboardType = WNXScoreboardTypeCountPTS;
            break;
        case 2:
            gameVC = [[WNXStage02ViewController alloc] init];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeOneFingerClick;
            gameVC.scoreboardType = WNXScoreboardTypeTimeMS;
            break;
        case 3:
            gameVC = [[WNXStage03ViewController alloc] init];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeReplaceClick;
            gameVC.scoreboardType = WNXScoreboardTypeSecondAndMS;
            break;
        case 4:
            gameVC = [[WNXStage04ViewController alloc] init];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeReplaceClick;
            gameVC.scoreboardType = WNXScoreboardTypeTimeMS;
            break;
        case 5:
            gameVC = [[WNXStage05ViewController alloc] init];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeMultiPointClick;
            gameVC.scoreboardType = WNXScoreboardTypeSecondAndMS;
            break;
        case 6:
            gameVC = [[WNXStage06ViewController alloc] init];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeOneFingerClick;
            gameVC.scoreboardType = WNXScoreboardTypeSecondAndMS;
            break;
        case 7:
            gameVC = [[WNXStage07ViewController alloc] init];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeMultiPointClick;
            gameVC.scoreboardType = WNXScoreboardTypeSecondAndMS;
            break;
        case 8:
            gameVC = [[WNXStage08ViewController alloc] init];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeMultiPointClick;
            gameVC.scoreboardType = WNXScoreboardTypeCountPTS;
            break;
        case 9:
            gameVC = [[WNXStage09ViewController alloc] init];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeNone;
            gameVC.scoreboardType = WNXScoreboardTypeNone;
            break;
        case 10:
            gameVC = [[WNXStage10ViewController alloc] init];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeOneFingerClick;
            gameVC.scoreboardType = WNXScoreboardTypeSecondAndMS;
            break;
        case 11:
            gameVC = [[WNXStage11ViewController alloc] init];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeOneFingerClick;
            gameVC.scoreboardType = WNXScoreboardTypeTimeMS;
            break;
        case 12:
            gameVC = [[WNXStage12ViewController alloc] init];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeNone;
            gameVC.scoreboardType = WNXScoreboardTypeCountPTS;
            break;
        default:
            break;
    }
        
    return gameVC;
}

@end
