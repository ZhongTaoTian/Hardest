//
//  WNXStage15View.m
//  Hardest
//
//  Created by sfbest on 16/5/12.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage15View.h"
#import "WNXStage15RowView.h"

@interface WNXStage15View ()
{
    int _count;
    CGFloat _rowHeight;
}

@property (strong, nonatomic) NSMutableArray *rowArray;
@property (nonatomic, strong) UIImageView *peopleIV;

@end

@implementation WNXStage15View

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - ScreenWidth / 3)]) {
        self.rowArray = [NSMutableArray array];
        
        WNXStage15RowView *row = [WNXStage15RowView viewFromNib];
        _rowHeight = row.frame.size.height;
        row.frame = CGRectMake(0, self.frame.size.height - _rowHeight + 30, ScreenWidth, _rowHeight);
        [row showRowWithIsShowWave:NO showFinish:NO isFrist:NO];
        [self addSubview:row];
        [self.rowArray addObject:row];
        
        WNXStage15RowView *row2 = [WNXStage15RowView viewFromNib];
        row2.frame = CGRectMake(0, CGRectGetMinY(row.frame) - _rowHeight, ScreenWidth, _rowHeight);
        [row2 showRowWithIsShowWave:YES showFinish:NO isFrist:NO];
        [self addSubview:row2];
        [self.rowArray addObject:row2];
                
        WNXStage15RowView *row3 = [WNXStage15RowView viewFromNib];
        row3.frame = CGRectMake(0, CGRectGetMinY(row2.frame) - _rowHeight, ScreenWidth, _rowHeight);
        [row3 showRowWithIsShowWave:NO showFinish:NO isFrist:YES];
        [self addSubview:row3];
        [self.rowArray addObject:row3];
        
        self.peopleIV = [[UIImageView alloc] initWithFrame:CGRectMake(kCountStartX(87), 165, 87, 106)];
        self.peopleIV.image = [UIImage imageNamed:@"18_hold-iphone4"];
        [self addSubview:self.peopleIV];
    }
    
    return self;
}

- (BOOL)jumpToNextRowWithIndex:(int)index {
    
    for (WNXStage15RowView *row in self.rowArray) {
        CGRect rowFrame = row.frame;
        row.frame = CGRectMake(0, rowFrame.origin.y - _rowHeight, ScreenWidth, _rowHeight);
        if (CGRectGetMaxY(row.frame) < 0) {
            [row removeFromSuperview];
            [self.rowArray removeLastObject];
        }
    }
    
    WNXStage15RowView *row = [WNXStage15RowView viewFromNib];
    row.frame = CGRectMake(0, self.frame.size.height - row.frame.size.height + 30, ScreenWidth, row.frame.size.height);
    if (_count % 3 == 0) {
        [row showRowWithIsShowWave:YES showFinish:NO isFrist:NO];
    } else {
        [row showRowWithIsShowWave:NO showFinish:NO isFrist:NO];
    }
    [self addSubview:row];
    [self.rowArray insertObject:row atIndex:0];
    
    [self bringSubviewToFront:self.peopleIV];
    
    _count++;
    
    return YES;
}

@end
