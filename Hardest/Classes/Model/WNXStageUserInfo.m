//
//  WNXStageUserInfo.m
//  Hardest
//
//  Created by sfbest on 16/2/29.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStageUserInfo.h"

#define kRank @"rank"
#define kScore @"score"
#define kUnlock @"unlock"
#define kNum @"num"

@implementation WNXStageUserInfo

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.num = [coder decodeIntForKey:kNum];
        self.score = [coder decodeDoubleForKey:kScore];
        self.unlock = [coder decodeBoolForKey:kUnlock];
        self.rank = [coder decodeObjectForKey:kRank];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:self.num forKey:kNum];
    [aCoder encodeDouble:self.score forKey:kScore];
    [aCoder encodeBool:self.isUnlock forKey:kUnlock];
    [aCoder encodeObject:self.rank forKey:kRank];
}

@end
