//
//  WNXBaseNavigationController.m
//  Hardest
//
//  Created by sfbest on 16/2/24.
//  Copyright © 2016年 sfbest. All rights reserved.
//

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
