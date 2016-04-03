//
//  WNXColumnIceView.m
//  Hardest
//
//  Created by MacBook on 16/4/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXColumnIceView.h"

@implementation WNXColumnIceView

- (instancetype)initWithFrame:(CGRect)frame {
    float scale = 202 / 108;
    if (self = [super initWithFrame:frame]) {
        for (int i = 0; i < 4; i++) {
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height - i * (frame.size.width / scale), frame.size.width, frame.size.width / scale)];
            if (i == 0 || i == 3) {
                image.image = [UIImage imageNamed:@"03_dashed01-iphone4"];
            } else {
                image.image = [UIImage imageNamed:@"03_dashed02-iphone4"];
            }
            
            [self addSubview:image];
        }
    }
    
    self.clipsToBounds = NO;
    
    return self;
}

@end
