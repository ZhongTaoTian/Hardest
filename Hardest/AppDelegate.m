//
//  AppDelegate.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/2/23.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "AppDelegate.h"
#import "WNXLaunchAnimationViewController.h"
#import "WNXBaseNavigationController.h"
#import "WNXResultViewController.h"
#import "WNXStageInfoManager.h"
#import "WNXStageInfo.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    [NSThread sleepForTimeInterval:1.0];
    
    [self setKeyWindow];
    
    return YES;
}

- (void)setKeyWindow {
    __weak typeof(self) weakSelf = self;
    
    WNXLaunchAnimationViewController *launchAnimationVC = [[WNXLaunchAnimationViewController alloc] init];
    launchAnimationVC.animationFinish = ^{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WNXBaseNavigationController *rootNav = (WNXBaseNavigationController *)[sb instantiateViewControllerWithIdentifier:@"RootNavigationController"];
        weakSelf.window.rootViewController = rootNav;
        
//        WNXStageInfo *info1 = [[WNXStageInfo alloc] init];
//        info1.rank = @"e";
//        info1.num = 1;
//        info1.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info1];
//        
//        WNXStageInfo *info2 = [[WNXStageInfo alloc] init];
//        info2.rank = @"s";
//        info2.num = 2;
//        info2.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info2];
//        
//        WNXStageInfo *info3 = [[WNXStageInfo alloc] init];
//        info3.rank = @"s";
//        info3.num = 3;
//        info3.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info3];
//        
//        WNXStageInfo *info4 = [[WNXStageInfo alloc] init];
//        info4.rank = @"a";
//        info4.num = 4;
//        info4.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info4];
//        
//        WNXStageInfo *info5 = [[WNXStageInfo alloc] init];
//        info5.rank = @"s";
//        info5.num = 5;
//        info5.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info5];
//
//        WNXStageInfo *info6 = [[WNXStageInfo alloc] init];
//        info6.rank = @"s";
//        info6.num = 6;
//        info6.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info6];
//        
//        WNXStageInfo *info7 = [[WNXStageInfo alloc] init];
//        info7.rank = @"s";
//        info7.num = 7;
//        info7.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info7];
//        
//        WNXStageInfo *info8 = [[WNXStageInfo alloc] init];
//        info8.rank = @"s";
//        info8.num = 8;
//        info8.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info8];
//        
//        WNXStageInfo *info9 = [[WNXStageInfo alloc] init];
//        info9.rank = @"s";
//        info9.num = 9;
//        info9.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info9];
//        
//        WNXStageInfo *info10 = [[WNXStageInfo alloc] init];
//        info10.rank = @"s";
//        info10.num = 10;
//        info10.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info10];
//        
//        WNXStageInfo *info11 = [[WNXStageInfo alloc] init];
//        info11.rank = @"s";
//        info11.num = 11;
//        info11.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info11];
//        
//        WNXStageInfo *info12 = [[WNXStageInfo alloc] init];
//        info12.rank = @"s";
//        info12.num = 12;
//        info12.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info12];
//        
//        WNXStageInfo *info13 = [[WNXStageInfo alloc] init];
//        info13.rank = @"b";
//        info13.num = 13;
//        info13.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info13];
//        
//        WNXStageInfo *info14 = [[WNXStageInfo alloc] init];
//        info14.rank = @"a";
//        info14.num = 14;
//        info14.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info14];
//        
//        WNXStageInfo *info15 = [[WNXStageInfo alloc] init];
//        info15.rank = @"a";
//        info15.num = 15;
//        info15.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info15];
//        
//        WNXStageInfo *info16 = [[WNXStageInfo alloc] init];
//        info16.rank = @"a";
//        info16.num = 16;
//        info16.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info16];
//        
//        WNXStageInfo *info17 = [[WNXStageInfo alloc] init];
//        info17.rank = @"a";
//        info17.num = 17;
//        info17.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info17];
//        
//        WNXStageInfo *info18 = [[WNXStageInfo alloc] init];
//        info18.rank = @"a";
//        info18.num = 18;
//        info18.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info18];
//        
//        WNXStageInfo *info19 = [[WNXStageInfo alloc] init];
//        info19.rank = @"a";
//        info19.num = 19;
//        info19.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info19];
//        
//        WNXStageInfo *info20 = [[WNXStageInfo alloc] init];
//        info20.rank = @"a";
//        info20.num = 20;
//        info20.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info20];
//
//        WNXStageInfo *info21 = [[WNXStageInfo alloc] init];
//        info21.rank = @"a";
//        info21.num = 21;
//        info21.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info21];
//        
//        WNXStageInfo *info22 = [[WNXStageInfo alloc] init];
//        info22.rank = @"a";
//        info22.num = 22;
//        info22.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info22];
//        
//        WNXStageInfo *info23 = [[WNXStageInfo alloc] init];
//        info23.rank = @"a";
//        info23.num = 23;
//        info23.unlock = YES;
//        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:info23];
        
    };
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = launchAnimationVC;
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
