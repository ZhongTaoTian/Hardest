//
//  WNXStage23PeopleView.m
//  Hardest
//
//  Created by sfbest on 16/5/27.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage23PeopleView.h"

@interface WNXStage23PeopleView ()

@property (nonatomic, strong) UIImageView *leftIV;
@property (nonatomic, strong) UIImageView *middleIV;
@property (nonatomic, strong) UIImageView *rightIV;

@end

@implementation WNXStage23PeopleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        
        self.leftIV = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth / 3 - 88) * 0.5, 0, 88, 90)];
        self.leftIV.image = [UIImage imageNamed:@"12_Bboy-iphone4"];
        [self addSubview:self.leftIV];
        
        self.middleIV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth / 3 + (ScreenWidth / 3 - 88) * 0.5, 0, 88, 90)];
        self.middleIV.image = [UIImage imageNamed:@"12_Rgirl-iphone4"];
        [self addSubview:self.middleIV];
        
        self.rightIV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth / 3 * 2 + (ScreenWidth / 3 - 88) * 0.5, 0, 88, 90)];
        self.rightIV.image = [UIImage imageNamed:@"12_Yboy-iphone4"];
        [self addSubview:self.rightIV];
    }
    
    return self;
}



@end
