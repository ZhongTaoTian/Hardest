//
//  UIApplication+WNXLoad.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/6/8.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "UIApplication+WNXLoad.h"
#import "WNXFullBackgroundView.h"

#define kLoadingViewTag 10000

@implementation UIApplication (WNXLoad)

+ (void)loading {
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    
    WNXFullBackgroundView *loadView = [[WNXFullBackgroundView alloc] initWithFrame:ScreenBounds];
    loadView.tag = kLoadingViewTag;
    [loadView setBackgroundImageWihtImageName:@"loading_bg"];
    [mainWindow addSubview:loadView];
}

+ (void)unLoading {
    UIView *loadView = [[[UIApplication sharedApplication] keyWindow].subviews lastObject];
    if (loadView.tag == kLoadingViewTag) {
        [loadView removeFromSuperview];
    }
}

@end
