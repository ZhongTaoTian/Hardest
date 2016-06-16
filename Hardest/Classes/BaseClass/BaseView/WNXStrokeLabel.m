//
//  WNXStrokeLabel.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//
//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStrokeLabel.h"

@interface WNXStrokeLabel ()

@property (nonatomic, assign) CGFloat storwidth;
@property (nonatomic, strong) UIColor *borderDrawColor;

@end

@implementation WNXStrokeLabel

- (instancetype)init {
    if (self = [super init]) {
        self.storwidth = 6;
        self.borderDrawColor = [UIColor blackColor];
    }
    
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    
    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, self.storwidth);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.textColor = self.borderDrawColor;
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    self.shadowOffset = CGSizeMake(0, 0);
    [super drawTextInRect:rect];
    
    self.shadowOffset = shadowOffset;
}

- (void)setTextStorkeWidth:(CGFloat)width {
    _storwidth = width;
    [self setNeedsDisplay];
}

- (void)setBorderDrawColor:(UIColor *)borderColor {
    _borderDrawColor = borderColor;
    [self setNeedsDisplay];
}

@end
