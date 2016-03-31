//
//  WNXStage04View.m
//  Hardest
//
//  Created by sfbest on 16/3/31.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage04View.h"

#define kStepsHeight 25
#define kStepsWidth 35

@interface WNXStage04View ()
{
    int _randomIndex;
}

@property (nonatomic, strong) UIImageView *peopleIV;
@property (nonatomic, strong) UIImageView *toiletIV;
@property (nonatomic, strong) NSMutableArray *stepsArr;
@property (nonatomic, strong) UIImageView *bottomView;

@end

@implementation WNXStage04View

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.stepsArr = [NSMutableArray array];
        self.peopleIV = [[UIImageView alloc] initWithFrame:CGRectMake(50, frame.size.height - 148 - kStepsHeight, 100, 154)];
        self.peopleIV.image = [UIImage imageNamed:@"05_hold-iphone4"];
        [self addSubview:self.peopleIV];
        
        self.toiletIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 94)];
        self.toiletIV.image = [UIImage imageNamed:@"05_commode-iphone4"];
        [self addSubview:self.toiletIV];
        
        self.bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height - kStepsHeight, ScreenWidth, kStepsHeight)];
        self.bottomView.image = [UIImage imageNamed:@"05_floor-iphone4"];
        [self addSubview:self.bottomView];
    }
    
    return self;
}

- (void)start {
    if (self.stepsArr.count > 0) {
        for (UIView *subView in self.stepsArr) {
            [subView removeFromSuperview];
        }
    }
    
    _randomIndex = arc4random_uniform(3) + 1;
    for (int i = 0; i < _randomIndex; i++) {
        UIImageView *stepsIV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.peopleIV.frame) - 23 + i * kStepsWidth, self.frame.size.height - kStepsHeight - i * kStepsHeight - kStepsHeight, kStepsWidth, kStepsHeight)];
        stepsIV.image = [UIImage imageNamed:@"05_stair-iphone4"];
        [self.stepsArr addObject:stepsIV];
        [self addSubview:stepsIV];
        
        if (i == _randomIndex - 1) {
            stepsIV.frame = CGRectMake(CGRectGetMaxX(self.peopleIV.frame) - 23 + i * kStepsWidth, self.frame.size.height - kStepsHeight - i * kStepsHeight - kStepsHeight, 70, kStepsHeight);
            self.toiletIV.frame = CGRectMake(CGRectGetMaxX(self.peopleIV.frame) - 23 + 11 + i * kStepsWidth, self.frame.size.height - kStepsHeight - i * kStepsHeight - kStepsHeight - 74, 50, 78);
        }
    }
}

@end
