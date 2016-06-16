//
//  WNXFailViewController.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/24.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXFailViewController.h"
#import "WNXPrepareViewController.h"
#import "WNXStageInfoManager.h"
#import "WNXSelectStageViewController.h"

typedef void(^RetryButtonClickBlock)();

@interface WNXFailViewController ()

@property (nonatomic, copy) RetryButtonClickBlock retryButtonClickBlock;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation WNXFailViewController

+ (instancetype)initWithStage:(WNXStage *)stage retryButtonClickBlock:(void (^)())retryButtonClickBlock {
    WNXFailViewController *failVC = [[WNXFailViewController alloc] init];
    failVC.stage = stage;
    failVC.retryButtonClickBlock = retryButtonClickBlock;
    failVC.titleLabel.text = stage.fail;
    return failVC;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.titleLabel.text = self.stage.fail;
}

- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 10) {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[WNXSelectStageViewController class]]) {
                [self.navigationController popToViewController:vc animated:NO];
                return;
            }
        }
    } else if (sender.tag == 11) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"失败原因" message:self.stage.fail delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    } else if (sender.tag == 12) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kAuthorGithubURLString]];
    } else if (sender.tag == 13) {
        if (self.retryButtonClickBlock) {
            self.retryButtonClickBlock();
        }
    }
}

@end
