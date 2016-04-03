//
//  WNXIceView.m
//  Hardest
//
//  Created by MacBook on 16/4/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXIceView.h"
#import "WNXColumnIceView.h"

@interface WNXIceView ()
{
    int _random1;
    int _random2;
    int _random3;
}

@property (nonatomic, strong) NSMutableArray *colViews;

@end

@implementation WNXIceView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.colViews = [NSMutableArray array];
        
        for (int i = 0; i < 3; i++) {
            WNXColumnIceView *colView = [WNXColumnIceView viewFromNib];
            colView.frame = CGRectMake(i * (frame.size.width / 3), 0, frame.size.width / 3, frame.size.height);
            
            [self addSubview:colView];
            [self.colViews addObject:colView];
        }
    }
    
    return self;
}

- (void)showDottedLineView {
    _random1 = arc4random_uniform(4) + 1;
    _random2 = arc4random_uniform(4) + 1;
    _random3 = arc4random_uniform(4) + 1;
    
    for (int i = 0; i < 3; i++) {
        switch (i) {
            case 0:
                [(WNXColumnIceView *)self.colViews[i] showColumnDottedLineWithNum:_random1];
                break;
            case 1:
                [(WNXColumnIceView *)self.colViews[i] showColumnDottedLineWithNum:_random2];
                break;
            case 2:
                [(WNXColumnIceView *)self.colViews[i] showColumnDottedLineWithNum:_random3];
                break;
            default:
                break;
        }
    }
}

@end
