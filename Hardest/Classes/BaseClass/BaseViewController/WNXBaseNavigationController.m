//
//  WNXBaseNavigationController.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/2/24.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXBaseNavigationController.h"
#import "UIApplication+WNXLoad.h"
#import "WNXSelectStageViewController.h"

@interface WNXBaseNavigationController ()

@end


@implementation WNXBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([viewController isKindOfClass:[WNXSelectStageViewController class]]) {
        [UIApplication loading];
        [super pushViewController:viewController animated:YES];
    } else {
        [super pushViewController:viewController animated:NO];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [UIApplication unLoading];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    NSArray *array = [super popToRootViewControllerAnimated:NO];
    
    return array;
}

@end
