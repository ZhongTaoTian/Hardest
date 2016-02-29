//
//  WNXStage.h
//  Hardest
//
//  Created by sfbest on 16/2/29.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WNXStageUserInfo;

@interface WNXStage : NSObject

@property (nonatomic, assign) int num;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *format;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, assign) double max;
@property (nonatomic, assign) double min;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *unit;

@property (nonatomic, strong) WNXStageUserInfo *userInfo;

+ (instancetype)stageWithDict:(NSDictionary *)dict;

@end
