//
//  WNXRYBViewController.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXBaseGameViewController.h"

@interface WNXRYBViewController : WNXBaseGameViewController

@property (strong, nonatomic) UIImageView *redImageView;
@property (strong, nonatomic) UIImageView *yellowImageView;
@property (strong, nonatomic) UIImageView *blueImageView;

@property (strong, nonatomic) UIButton    *redButton;
@property (strong, nonatomic) UIButton    *yellowButton;
@property (strong, nonatomic) UIButton    *blueButton;

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSArray *buttonImageNames;

- (void)setButtonsIsActivate:(BOOL)isActivate;

- (void)setButtonImage:(UIImage *)image
      contenEdgeInsets:(UIEdgeInsets)insets;

- (void)removeAllImageView;

- (void)addButtonsActionWithTarget:(id)target
                            action:(SEL)action
                  forControlEvents:(UIControlEvents)forControlEvents;

@end
