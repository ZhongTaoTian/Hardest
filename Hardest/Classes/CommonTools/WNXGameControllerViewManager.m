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
            
        default:
            break;
    }
        
    return gameVC;
}

@end
