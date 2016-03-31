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
    int _runCount;
    BOOL _isMove;
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
        
        self.peopleIV.animationRepeatCount = 1;
        self.peopleIV.animationDuration = 0.3;
    }
    
    return self;
}

- (void)start {
    if (_isMove) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - kStepsHeight, self.frame.size.width, self.frame.size.height);
    }
    
    _isMove = NO;
    self.bottomView.hidden = NO;
    if (self.stepsArr.count > 0) {
        for (UIView *subView in self.stepsArr) {
            [subView removeFromSuperview];
        }
    }
    
    _randomIndex = arc4random_uniform(15) + 1;
    for (int i = 0; i < _randomIndex; i++) {
        UIImageView *stepsIV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.peopleIV.frame) - 23 + i * kStepsWidth, self.frame.size.height - kStepsHeight - i * kStepsHeight - kStepsHeight, kStepsWidth, kStepsHeight)];
        stepsIV.image = [UIImage imageNamed:@"05_stair-iphone4"];
        stepsIV.tag = i + 100;
        [self.stepsArr addObject:stepsIV];
        [self addSubview:stepsIV];
        
        if (i == _randomIndex - 1) {
            stepsIV.frame = CGRectMake(CGRectGetMaxX(self.peopleIV.frame) - 23 + i * kStepsWidth, self.frame.size.height - kStepsHeight - i * kStepsHeight - kStepsHeight, 70, kStepsHeight);
            self.toiletIV.frame = CGRectMake(CGRectGetMaxX(self.peopleIV.frame) - 23 + 11 + i * kStepsWidth, self.frame.size.height - kStepsHeight - i * kStepsHeight - kStepsHeight - 74, 50, 78);
            [self.stepsArr addObject:self.toiletIV];
        }
    }
    
    [self bringSubviewToFront:self.peopleIV];
}

- (void)runLeft {
    [self runWithIsLeft:YES];
}

- (void)runRight {
    [self runWithIsLeft:NO];
}

- (void)runWithIsLeft:(BOOL)isLeft {
    _runCount++;
    if (_runCount < 3) {
        [UIView animateWithDuration:0.2 animations:^{
            self.peopleIV.frame = CGRectMake(self.peopleIV.frame.origin.x + kStepsWidth, self.peopleIV.frame.origin.y - kStepsHeight, self.peopleIV.frame.size.width, self.peopleIV.frame.size.height);
        }];
    } else {
        if (_runCount == 3) {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + kStepsHeight, self.frame.size.width, self.frame.size.height);
            _isMove = YES;
            self.bottomView.hidden = YES;
        }
        for (UIView *view in self.stepsArr) {
            [UIView animateWithDuration:0.2 animations:^{
                view.frame = CGRectMake(view.frame.origin.x - kStepsWidth, view.frame.origin.y + kStepsHeight, view.frame.size.width, view.frame.size.height);
            }];
        }
        
        UIView *view = [self viewWithTag:_runCount - 3 + 100];
        view.hidden = YES;
    }
    
    if (self.peopleIV.isAnimating) {
        [self.peopleIV startAnimating];
    }
    
    if (isLeft) {
        self.peopleIV.animationImages = @[[UIImage imageNamed:@"05_walk01-iphone4"], [UIImage imageNamed:@"05_walk02-iphone4"]];
    } else {
        self.peopleIV.animationImages = @[[UIImage imageNamed:@"05_walk03-iphone4"], [UIImage imageNamed:@"05_walk04-iphone4"]];
    }
    
    [self.peopleIV startAnimating];
}

- (void)dealloc {
    NSLog(@"第四关View被销毁");
}

@end
