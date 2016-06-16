//
//  WNXStage.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/2/29.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import <Foundation/Foundation.h>

@class WNXStageInfo;

@interface WNXStage : NSObject

@property (nonatomic, assign) int num;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *format;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, assign) double max;
@property (nonatomic, assign) double min;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *fail;

@property (nonatomic, strong) WNXStageInfo *userInfo;

+ (instancetype)stageWithDict:(NSDictionary *)dict;

@end
