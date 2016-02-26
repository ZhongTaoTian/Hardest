//
//  WNXSettingViewController.m
//  Hardest
//
//  Created by sfbest on 16/2/26.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXSettingViewController.h"

@interface WNXSettingViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMargin;

@end

@implementation WNXSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundImageWihtImageName:@"setting_bg"];
    
    [self startSetTopMargin];
}

- (void)startSetTopMargin {
    if (iPhone5) {
        self.topMargin.constant = 120;
    } else {
        self.topMargin.constant = 120 - ScreenHeightDifference - 10;
    }
    
    [self.view setNeedsLayout];
}

@end
