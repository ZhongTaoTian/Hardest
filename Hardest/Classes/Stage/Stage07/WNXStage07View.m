//
//  WNXStage07View.m
//  Hardest
//
//  Created by sfbest on 16/4/9.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage07View.h"
#import "WNXBreakGlassView.h"

#define kGlassWidth 50
#define kGlassHeight 91

@interface WNXStage07View ()
{
    int _count;
    int _glassCount;
}

@property (nonatomic, strong) NSMutableArray *glassesArr;

@end

@implementation WNXStage07View

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.glassesArr = [NSMutableArray array];
    }
    
    return self;
}

- (void)start {
    [self showGlassView];
}

- (void)showGlassView {
    _glassCount = arc4random_uniform(15) + 1;
    
    if (self.glassesArr.count > 0) {
        [self.glassesArr removeAllObjects];
    }

    int rowCount;
    CGFloat margin;
    for (int i = 0; i < _glassCount; i++) {
        if (_glassCount <= 12) {
            rowCount = 4;
            margin = 50;
        } else {
            rowCount = 5;
            margin = 35;
        }
        CGFloat glassX = (i % rowCount) * kGlassWidth;
        CGFloat glassY = self.frame.size.height - i / rowCount * kGlassHeight - kGlassHeight - 20;
        UIImageView *glassIV = [[UIImageView alloc] initWithFrame:CGRectMake(margin + glassX, glassY, kGlassWidth, kGlassHeight)];
        glassIV.image = [UIImage imageNamed:@"04_cup01-iphone4"];
        [self addSubview:glassIV];
        [self.glassesArr addObject:glassIV];
    }
}

- (void)hitGlass {
    if (self.glassesArr.count > 0) {
        UIImageView *glassIV = [self.glassesArr lastObject];
        [self.glassesArr removeLastObject];
        [self breakGlass:glassIV.center];
        [glassIV removeFromSuperview];
    }
}

- (void)breakGlass:(CGPoint)center {
    WNXBreakGlassView *breakView = [WNXBreakGlassView viewFromNib];
    breakView.frame = CGRectMake(0, 0, breakView.frame.size.width, breakView.frame.size.height);
    breakView.center = center;
    [self addSubview:breakView];
    [breakView showBreakGlass];
}

@end
