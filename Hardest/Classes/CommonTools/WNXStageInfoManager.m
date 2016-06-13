//
//  WNXStageInfoManger.m
//  Hardest
//
//  Created by sfbest on 16/2/29.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStageInfoManager.h"
#import "WNXStageInfo.h"

#define fileName @"stageInfos"
#define path [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:fileName]

@interface WNXStageInfoManager ()

@property (nonatomic, strong) NSMutableDictionary *allStageInfos;

@property (nonatomic, strong) NSArray *aaa;

@end

@implementation WNXStageInfoManager

static WNXStageInfoManager *instance = nil;
+ (instancetype)sharedStageInfoManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [WNXStageInfoManager new];
    });
    
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.allStageInfos = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if (!self.allStageInfos) {
            self.allStageInfos = [NSMutableDictionary dictionary];
            WNXStageInfo *info = [WNXStageInfo new];
            info.num = 1;
            [self.allStageInfos setObject:info forKey:@1];
            
            [self saveStageInfo:info];
        }
    }
    
    return self;
}

- (BOOL)saveStageInfo:(WNXStageInfo *)stageInfo {
    
    if (stageInfo.num <= 0) return NO;
    
    [self.allStageInfos setObject:stageInfo forKey:@(stageInfo.num)];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewCount" object:@(stageInfo.num)];
    
    if (stageInfo.rank && (![stageInfo.rank isEqualToString:@"f"]) && (![self stageInfoWithNumber:stageInfo.num + 1] || ![self stageInfoWithNumber:stageInfo.num + 1].unlock)) {
        WNXStageInfo *nextStageInfo = [[WNXStageInfo alloc] init];
        nextStageInfo.num = stageInfo.num + 1;
        [self saveStageInfo:nextStageInfo];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NewStageDidUnLock" object:@(nextStageInfo.num)];
    }

    return [NSKeyedArchiver archiveRootObject:self.allStageInfos toFile:path];
}

- (WNXStageInfo *)stageInfoWithNumber:(int)number {
//    NSAssert(number > 0, @"读取必须大于0啊");

    WNXStageInfo *info = self.allStageInfos[@(number)];
    
    return info;
}

- (BOOL)unlockNextStage {

    for (int i = 2 ; i < 25; i++) {
        NSNumber *num = [NSNumber numberWithInt:i];
        
        if (![self.allStageInfos objectForKey:num]) {
            
            WNXStageInfo *info = [WNXStageInfo new];
            info.num = i;
            [self.allStageInfos setObject:info forKey:num];
            
            return YES;
        }
    }
    
    return NO;
}

@end
