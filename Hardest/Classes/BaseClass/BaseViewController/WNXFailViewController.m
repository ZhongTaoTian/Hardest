//
//  WNXFailViewController.m
//  Hardest
//
//  Created by sfbest on 16/3/24.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXFailViewController.h"
#import "WNXPrepareViewController.h"
#import "WNXStageInfoManager.h"
#import "WNXSelectStageViewController.h"

typedef void(^RetryButtonClickBlock)();

@interface WNXFailViewController ()

@property (nonatomic, copy) RetryButtonClickBlock retryButtonClickBlock;

@end

@implementation WNXFailViewController

+ (instancetype)initWithStage:(WNXStage *)stage retryButtonClickBlock:(void (^)())retryButtonClickBlock {
    WNXFailViewController *failVC = [[WNXFailViewController alloc] init];
    failVC.stage = stage;
    failVC.retryButtonClickBlock = retryButtonClickBlock;
    
    return failVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)buttonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 10:
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[WNXSelectStageViewController class]]) {
                    [self.navigationController popToViewController:vc animated:NO];
                    return;
                }
            }
            break;
        case 11:
            // 显示Alart
            break;
        case 12:
            // 进入gitHub
            break;
        case 13:
            if (self.retryButtonClickBlock) {
                self.retryButtonClickBlock();
            }
            break;
        default:
            break;
    }
}

@end
