//
//  WNXGuessFingerView.m
//  Hardest
//
//  Created by sfbest on 16/3/21.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXGuessFingerView.h"

@interface WNXGuessFingerView ()

@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIImageView *leftImageView;

@end

@implementation WNXGuessFingerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(0, frame.origin.y, ScreenWidth, frame.size.height)]) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = NO;
        
        self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 400) * 0.5 - 120, (frame.size.height - 97) * 0.5, 200, 97)];
        self.leftImageView.image = [UIImage imageNamed:@"09_hand02-iphone4right"];
        self.leftImageView.layer.anchorPoint = CGPointMake(0, 0.5);
        [self addSubview:self.leftImageView];
        
        self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth + (400 - ScreenWidth) * 0.5 - 80, (frame.size.height - 97) * 0.5, 200, 97)];
        self.rightImageView.image = [UIImage imageNamed:@"09_hand02-iphone4"];
        self.rightImageView.layer.anchorPoint = CGPointMake(1, 0.5);
        [self addSubview:self.rightImageView];
    }
    
    return self;
}

@end
