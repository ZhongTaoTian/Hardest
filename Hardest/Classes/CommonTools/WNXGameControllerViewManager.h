//
//  WNXGameControllerViewManager.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WNXBaseGameViewController.h"

@interface WNXGameControllerViewManager : NSObject

+ (WNXBaseGameViewController *)viewControllerWithStage:(WNXStage *)stage;

@end
