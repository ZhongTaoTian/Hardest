//
//  WNXStage.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/2/29.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage.h"

@implementation WNXStage

+ (instancetype)stageWithDict:(NSDictionary *)dict {
    WNXStage *stage = [WNXStage new];
    stage.icon = dict[@"icon"];
    stage.format = dict[@"format"];
    stage.max = [dict[@"max"] doubleValue];
    stage.min = [dict[@"min"] doubleValue];
    stage.title = dict[@"title"];
    stage.intro = dict[@"intro"];
    stage.unit = dict[@"unit"];
    stage.fail = dict[@"fail"];
    return stage;
}

@end
