//
//  WNXFootView.m
//  Hardest
//
//  Created by sfbest on 16/3/4.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXFootView.h"

@interface WNXFootView ()
{
    int _flag;
    int _count;
}

@property (nonatomic, strong) UIImageView *footImageView;
@property (nonatomic, strong) UIImageView *shadowImageView;
@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, assign) int index;

@end

@implementation WNXFootView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = NO;
        self.hidden = YES;
        
        self.shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 160, 110, 23)];
        self.shadowImageView.image = [UIImage imageNamed:@"select_shadow"];
        [self addSubview:self.shadowImageView];
        
        self.footImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 180)];
        self.footImageView.image = [UIImage imageNamed:@"01-feet01"];
        [self addSubview:self.footImageView];
    }
    
    return self;
}

- (void)startAnimation {
    self.hidden = NO;
    
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshTime:)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopFootView {
    [self removeFromSuperview];
}

- (void)refreshTime:(CADisplayLink *)timer {
    _flag++;
    
    if (_flag != 45) {
        return;
    }
    
    if (_flag == 45 && _count != 6) {
        _count++;
        _flag = 0;
        
        [self setRandomLocation];
    }
    
}

- (void)setRandomLocation {

    int randomIndex = arc4random_uniform(3);
    while (randomIndex == self.index) {
        randomIndex = arc4random_uniform(3);
    }
    
    self.index = randomIndex;
    
    [self moveFootViewToIndex:self.index];
}

- (void)moveFootViewToIndex:(int)index {
    CGRect newFrame = self.frame;
    newFrame.origin.x = ScreenWidth / 3 * index;
    self.frame = newFrame;
}

- (BOOL)attackFootViewAtIndex:(int)index {
    if (index == self.index) {
        [self startShakeImage];
    }
    
    return self.index == index;
}

- (void)startShakeImage {
    
}

@end
