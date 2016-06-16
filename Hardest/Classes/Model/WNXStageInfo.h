//
//  WNXStageUserInfo.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/2/29.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WNXStageInfo : NSObject <NSCoding>

@property (nonatomic, copy) NSString *rank;
@property (nonatomic, assign) int num;
@property (nonatomic, assign) double score;
@property (nonatomic, assign, getter = isUnlock) BOOL unlock;


@end
