//
//  WNXBaseGameViewController.m
//  Hardest
//
//  Created by sfbest on 16/3/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXBaseGameViewController.h"
#import "WNXStageInfo.h"

@interface WNXBaseGameViewController ()

@end

@implementation WNXBaseGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initGuideImageView];
    
    [self showGuideImageView];
}

- (void)initGuideImageView {
    self.guideImageView = [[UIImageView alloc] initWithFrame:ScreenBounds];
    [self.view addSubview:self.guideImageView];
}

- (void)showGuideImageView {
    if (!(([self.stage.userInfo.rank isEqualToString:@"f"] || self.stage.userInfo.rank == nil || self.stage.userInfo == nil) && self.guideType != WNXGameGuideTypeNone)) {
        [self.guideImageView removeFromSuperview];
        return;
    }
    
    NSArray *animationImages;
    if (self.guideType == WNXGameGuideTypeOneFingerClick) {
        animationImages = @[[UIImage imageNamed:@"03-1-iphone4"], [UIImage imageNamed:@"03-2-iphone4"]];
    } else if (self.guideType == WNXGameGuideTypeReplaceClick) {
        animationImages = @[[UIImage imageNamed:@"01-1-iphone4"], [UIImage imageNamed:@"01-2-iphone4"]];
    } else if (self.guideType == WNXGameGuideTypeMultiPointClick) {
        animationImages = @[[UIImage imageNamed:@"02-1-iphone4"], [UIImage imageNamed:@"02-2-iphone4"], [UIImage imageNamed:@"02-4-iphone4"], [UIImage imageNamed:@"02-5-iphone4"]];
    }

    self.guideImageView.animationDuration = animationImages.count * 0.15;
    self.guideImageView.animationImages = animationImages;
    self.guideImageView.animationRepeatCount = -1;
    [self.guideImageView startAnimating];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(guideImageViewClick)];
    [self.guideImageView addGestureRecognizer:tap];
}

- (void)guideImageViewClick {
    [self.guideImageView removeFromSuperview];
    
    [self beginRedayGoView];
}

- (void)beginRedayGoView {
    
}

- (void)beginGame {}
- (void)endGame{}


@end
