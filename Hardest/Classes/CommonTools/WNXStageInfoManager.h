//
//  WNXStageInfoManger.h
//  Hardest
//
//  Created by sfbest on 16/2/29.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WNXStageInfo;

@interface WNXStageInfoManager : NSObject

+ (instancetype)sharedStageInfoManager;

- (BOOL)saveStageInfo:(WNXStageInfo *)stageInfo;;
- (WNXStageInfo *)stageInfoWithNumber:(int)number;

- (BOOL)unlockNextStage;

@end
