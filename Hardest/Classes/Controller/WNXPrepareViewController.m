//
//  WNXPrepareViewController.m
//  Hardest
//
//  Created by sfbest on 16/3/1.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXPrepareViewController.h"

@interface WNXPrepareViewController ()

@property (weak, nonatomic) IBOutlet WNXFullBackgroundView *animationView;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *number1Label;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;

@end

@implementation WNXPrepareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)playGameClick {
}


@end
