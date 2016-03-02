//
//  WNXGameControllerViewManager.m
//  Hardest
//
//  Created by sfbest on 16/3/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXGameControllerViewManager.h"
#import "WNXRYBViewController.h"

@implementation WNXGameControllerViewManager

+ (WNXBaseGameViewController *)viewControllerWithStage:(WNXStage *)stage {
    WNXBaseGameViewController *gameVC;
    
    switch (stage.num) {
        case 1:
            gameVC = [[WNXRYBViewController alloc] init];
            gameVC.guideType = WNXGameGuideTypeOneFingerClick;
            break;
            
        default:
            break;
    }
    
    gameVC.stage = stage;
    
    return gameVC;
}

@end
