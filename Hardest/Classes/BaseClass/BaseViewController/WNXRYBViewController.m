//
//  WNXRYBViewController.m
//  Hardest
//
//  Created by sfbest on 16/3/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXRYBViewController.h"

@interface WNXRYBViewController ()

@end

@implementation WNXRYBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setButtonsImageWiht:(NSArray *)imagesName {
    if (imagesName.count != 3) return;
    
    [self.redButton setImage:[UIImage imageNamed:imagesName[0]] forState:UIControlStateNormal];
    [self.redButton setImage:[UIImage imageNamed:imagesName[1]] forState:UIControlStateNormal];
    [self.redButton setImage:[UIImage imageNamed:imagesName[2]] forState:UIControlStateNormal];
}

- (IBAction)bottomButtonClick:(UIButton *)sender {
}


@end
