//
//  WNXBackViewController.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/2/26.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXBackViewController.h"

@interface WNXBackViewController ()

@end

@implementation WNXBackViewController

- (void)loadView {
    [super loadView];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 50, 48)];
    backButton.adjustsImageWhenHighlighted = NO;
    [backButton setBackgroundImage:[UIImage imageNamed:@"bt_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)backButtonClick {
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundCliclName];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
