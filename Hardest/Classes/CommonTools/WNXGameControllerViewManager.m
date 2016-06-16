//
//  WNXGameControllerViewManager.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

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
#import "WNXStage13ViewController.h"
#import "WNXStage14ViewController.h"
#import "WNXStage15ViewController.h"
#import "WNXStage16ViewController.h"
#import "WNXStage17ViewController.h"
#import "WNXStage18ViewController.h"
#import "WNXStage19ViewController.h"
#import "WNXStage20ViewController.h"
#import "WNXStage21ViewController.h"
#import "WNXStage22ViewController.h"
#import "WNXStage23ViewController.h"
#import "WNXStage24ViewController.h"

@implementation WNXGameControllerViewManager

+ (WNXBaseGameViewController *)viewControllerWithStage:(WNXStage *)stage {
    WNXBaseGameViewController *gameVC;
    
    switch (stage.num) {
        case 1:
            gameVC = [WNXStage01ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeOneFingerClick;
            gameVC.scoreboardType = WNXScoreboardTypeCountPTS;
            break;
        case 2:
            gameVC = [WNXStage02ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeOneFingerClick;
            gameVC.scoreboardType = WNXScoreboardTypeTimeMS;
            break;
        case 3:
            gameVC = [WNXStage03ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeReplaceClick;
            gameVC.scoreboardType = WNXScoreboardTypeSecondAndMS;
            break;
        case 4:
            gameVC = [WNXStage04ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeReplaceClick;
            gameVC.scoreboardType = WNXScoreboardTypeTimeMS;
            break;
        case 5:
            gameVC = [WNXStage05ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeMultiPointClick;
            gameVC.scoreboardType = WNXScoreboardTypeSecondAndMS;
            break;
        case 6:
            gameVC = [WNXStage06ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeOneFingerClick;
            gameVC.scoreboardType = WNXScoreboardTypeSecondAndMS;
            break;
        case 7:
            gameVC = [WNXStage07ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeMultiPointClick;
            gameVC.scoreboardType = WNXScoreboardTypeSecondAndMS;
            break;
        case 8:
            gameVC = [WNXStage08ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeMultiPointClick;
            gameVC.scoreboardType = WNXScoreboardTypeCountPTS;
            break;
        case 9:
            gameVC = [WNXStage09ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeNone;
            gameVC.scoreboardType = WNXScoreboardTypeNone;
            break;
        case 10:
            gameVC = [WNXStage10ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeOneFingerClick;
            gameVC.scoreboardType = WNXScoreboardTypeSecondAndMS;
            break;
        case 11:
            gameVC = [WNXStage11ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeOneFingerClick;
            gameVC.scoreboardType = WNXScoreboardTypeTimeMS;
            break;
        case 12:
            gameVC = [WNXStage12ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeNone;
            gameVC.scoreboardType = WNXScoreboardTypeCountPTS;
            break;
        case 13:
            gameVC = [WNXStage13ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeMultiPointClick;
            gameVC.scoreboardType = WNXScoreboardTypeTimeMS;
            break;
        case 14:
            gameVC = [WNXStage14ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeNone;
            gameVC.scoreboardType = WNXScoreboardTypeSecondAndMS;
            break;
        case 15:
            gameVC = [WNXStage15ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeNone;
            gameVC.scoreboardType = WNXScoreboardTypeSecondAndMS;
            break;
        case 16:
            gameVC = [WNXStage16ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeReplaceClick;
            gameVC.scoreboardType = WNXScoreboardTypeCountPTS;
            break;
        case 17:
            gameVC = [WNXStage17ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeNone;
            gameVC.scoreboardType = WNXScoreboardTypeNone;
            break;
        case 18:
            gameVC = [WNXStage18ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeMultiPointClick;
            gameVC.scoreboardType = WNXScoreboardTypeTimeMS;
            break;
        case 19:
            gameVC = [WNXStage19ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeNone;
            gameVC.scoreboardType = WNXScoreboardTypeTimeMS;
            break;
        case 20:
            gameVC = [WNXStage20ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXScoreboardTypeNone;
            gameVC.scoreboardType = WNXScoreboardTypeTimeMS;
            break;
        case 21:
            gameVC = [WNXStage21ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeNone;
            gameVC.scoreboardType = WNXScoreboardTypeTimeMS;
            break;
        case 22:
            gameVC = [WNXStage22ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeNone;
            gameVC.scoreboardType = WNXScoreboardTypeTimeMS;
            break;
        case 23:
            gameVC = [WNXStage23ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeMultiPointClick;
            gameVC.scoreboardType = WNXScoreboardTypeTimeMS;
            break;
        case 24:
            gameVC = [WNXStage24ViewController new];
            gameVC.stage = stage;
            gameVC.guideType = WNXGameGuideTypeNone;
            gameVC.scoreboardType = WNXScoreboardTypeTimeMS;
            break;
        default:
            break;
    }
        
    return gameVC;
}

@end
