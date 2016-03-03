//
//  WNXStrokeLabel.m
//  Hardest
//
//  Created by sfbest on 16/3/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStrokeLabel.h"

@interface WNXStrokeLabel ()

@property (nonatomic, assign) CGFloat storwidth;

@end

@implementation WNXStrokeLabel

- (instancetype)init {
    if (self = [super init]) {
        self.storwidth = 6;
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
    self.textColor = [UIColor blackColor];
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    self.shadowOffset = CGSizeMake(0, 0);
    [super drawTextInRect:rect];
    
    self.shadowOffset = shadowOffset;
}

- (void)setTextStorkeWidth:(CGFloat)width {
    self.storwidth = width;
    [self setNeedsDisplay];
}

@end
