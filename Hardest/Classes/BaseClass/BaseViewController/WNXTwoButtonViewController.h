//
//  WNXTwoButtonViewController.h
//  Hardest
//
//  Created by MacBook on 16/3/27.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXBaseGameViewController.h"

@interface WNXTwoButtonViewController : WNXBaseGameViewController

@property (nonatomic, strong) UIImageView *backgroundIV;

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

- (void)setButtonActivate:(BOOL)isActivate;

@end
