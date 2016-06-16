//
//  WNXBackgroundViewController.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/9.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXBackgroundViewController.h"

@interface WNXBackgroundViewController ()

@end

@implementation WNXBackgroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.bgImageView];
    
}


@end
