//
//  WNXFractionView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/24.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXFractionView.h"

@implementation WNXFractionView

- (instancetype)initWithFrame:(CGRect)frame Denominator:(int)denominator numerator:(int)numerator {
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *numeratorIV = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 66) * 0.5, 190, 60, 66)];
        numeratorIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"stage13_%d", numerator]];
        [self addSubview:numeratorIV];
        
        UIImageView *lineIV = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 80) * 0.5, CGRectGetMaxY(numeratorIV.frame) + 15, 80, 15)];
        lineIV.image = [UIImage imageNamed:@"17_line-iphone4"];
        [self addSubview:lineIV];
        
        UIImageView *denominatorIV = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 66) * 0.5, CGRectGetMaxY(lineIV.frame) + 15, 60, 66)];
        denominatorIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"stage13_%d", denominator]];
        [self addSubview:denominatorIV];
    }
    
    return self;
}

@end
