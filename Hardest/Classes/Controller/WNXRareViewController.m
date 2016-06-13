//
//  WNXRareViewController.m
//  Hardest
//
//  Created by sfbest on 16/6/12.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXRareViewController.h"
#import "WNXStageInfoManager.h"

@interface WNXRareViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation WNXRareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundImageWihtImageName:@"setting_bg"];
}

- (IBAction)unlockNextStage:(UIButton *)sender {
    
    sender.enabled = NO;
    
    NSString *title;
    
    if ([[WNXStageInfoManager sharedStageInfoManager] unlockNextStage]) {
        title = @"解锁成功";
    } else {
        title = @"已经全部解锁了";
    }
    
    self.titleLabel.text = title;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popToRootViewControllerAnimated:NO];
    });
}

- (IBAction)pause:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}


@end
