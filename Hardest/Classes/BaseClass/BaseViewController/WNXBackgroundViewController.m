//
//  WNXBackgroundViewController.m
//  Hardest
//
//  Created by sfbest on 16/5/9.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXBackgroundViewController.h"

@interface WNXBackgroundViewController ()

@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation WNXBackgroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.bgImageView];
    
}


@end
