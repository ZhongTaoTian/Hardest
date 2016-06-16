//
//  WNXRYBViewController.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXRYBViewController.h"

#define kNormalImageNames @[@"00_Rbg01-iphone4", @"00_Ybg01-iphone4", @"00_Bbg01-iphone4"]
#define kHighImageNames @[@"00_Rbg02-iphone4", @"00_Ybg02-iphone4", @"00_Bbg02-iphone4"]
#define kBottomButtonImageNames @[@"00_Rbt-iphone4", @"00_Ybt-iphone4", @"00_Bbt-iphone4"]

@interface WNXRYBViewController ()

@end

@implementation WNXRYBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackgroundImages];
    
    [self setBottomButtons];
    
    self.buttons = [NSMutableArray array];
    [self.buttons addObjectsFromArray:@[self.redButton, self.blueButton, self.yellowButton]];
}

- (void)setBackgroundImages {
    self.redImageView = [[UIImageView alloc] init];
    [self setImageView:self.redImageView tag:100];
    
    self.yellowImageView = [[UIImageView alloc] init];
    [self setImageView:self.yellowImageView tag:101];
    
    self.blueImageView = [[UIImageView alloc] init];
    [self setImageView:self.blueImageView tag:102];
    
}

- (void)setBottomButtons {
    self.redButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButton:self.redButton tag:0];
    
    self.yellowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButton:self.yellowButton tag:1];
    
    self.blueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButton:self.blueButton tag:2];
}

- (void)setImageView:(UIImageView *)imageView tag:(int)tag {
    imageView.frame = CGRectMake((tag - 100) * ScreenWidth / 3, 0, ScreenWidth / 3, ScreenHeight);
    imageView.tag = tag;
    imageView.image = [UIImage imageNamed:kNormalImageNames[tag - 100]];
    imageView.highlightedImage = [UIImage imageNamed:kHighImageNames[tag - 100]];
    [self.view insertSubview:imageView belowSubview:self.playAgainButton];
}

- (void)setButton:(UIButton *)btn tag:(int)tag {
    CGFloat btnW = ScreenWidth / 3;
    btn.frame = CGRectMake(tag * btnW, ScreenHeight - btnW, btnW, btnW);
    btn.adjustsImageWhenHighlighted = NO;
    btn.tag = tag;
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage imageNamed:kBottomButtonImageNames[tag]] forState:UIControlStateNormal];
    btn.contentEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:btn];
}

- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    [self setButtonsIsActivate:YES];
    self.view.userInteractionEnabled = YES;
}

- (void)setButtonsIsActivate:(BOOL)isActivate {
    self.redButton.userInteractionEnabled = isActivate;
    self.yellowButton.userInteractionEnabled = isActivate;
    self.blueButton.userInteractionEnabled = isActivate;
}

- (void)setButtonImage:(UIImage *)image contenEdgeInsets:(UIEdgeInsets)insets {
    for (UIButton *btn in self.buttons) {
        [btn setImage:image forState:UIControlStateNormal];
        btn.contentEdgeInsets = insets;
    }
}

- (void)setButtonImageNames:(NSArray *)buttonImageNames {
    if (buttonImageNames.count != 3 ) return;
    
    [self.redButton setImage:[UIImage imageNamed:buttonImageNames[0]] forState:UIControlStateNormal];
    [self.yellowButton setImage:[UIImage imageNamed:buttonImageNames[1]] forState:UIControlStateNormal];
    [self.blueButton setImage:[UIImage imageNamed:buttonImageNames[2]] forState:UIControlStateNormal];
}

- (void)removeAllImageView {
    [self.redImageView removeFromSuperview];
    [self.yellowImageView removeFromSuperview];
    [self.blueImageView removeFromSuperview];
}

- (void)addButtonsActionWithTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)forControlEvents {
    [self.redButton addTarget:target action:action forControlEvents:forControlEvents];
    [self.yellowButton addTarget:target action:action forControlEvents:forControlEvents];
    [self.blueButton addTarget:target action:action forControlEvents:forControlEvents];
}

@end
