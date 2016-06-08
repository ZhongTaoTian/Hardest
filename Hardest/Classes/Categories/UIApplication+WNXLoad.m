//
//  UIApplication+WNXLoad.m
//  Hardest
//
//  Created by sfbest on 16/6/8.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

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
