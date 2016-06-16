//
//  WNXStage11BottomNumView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/4/28.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage11BottomNumView.h"
#import "WNXStrokeLabel.h"

@interface WNXStage11BottomNumView ()
{
    int _result1;
    int _result2;
    int _result3;
}

@property (nonatomic, strong) WNXStrokeLabel *label1;
@property (nonatomic, strong) WNXStrokeLabel *label2;
@property (nonatomic, strong) WNXStrokeLabel *label3;

@end

@implementation WNXStage11BottomNumView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGFloat labelH = frame.size.height;
        self.label1 = [[WNXStrokeLabel alloc] initWithFrame:CGRectMake(0, 0, labelH, labelH)];
        [self buildLabelWithLabel:self.label1];
        
        self.label2 = [[WNXStrokeLabel alloc] initWithFrame:CGRectMake(labelH, 0, labelH, labelH)];
        [self buildLabelWithLabel:self.label2];
        
        self.label3 = [[WNXStrokeLabel alloc] initWithFrame:CGRectMake(labelH * 2, 0, labelH, labelH)];
        [self buildLabelWithLabel:self.label3];
        
        self.hidden = YES;
        self.userInteractionEnabled = NO;
    }
    
    return self;
}

- (void)buildLabelWithLabel:(WNXStrokeLabel *)label {
    [label setTextStorkeWidth:4];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"0";
    label.font = [UIFont fontWithName:@"TransformersMovie" size:kFontSize];
    [self addSubview:label];
}

- (void)setLabelTextWithNum1:(int)num1 num2:(int)num2 num3:(int)num3 {
    self.hidden = NO;
    _result1 = num1;
    _result2 = num2;
    _result3 = num3;
    self.label1.text = [NSString stringWithFormat:@"%d", num1];
    self.label2.text = [NSString stringWithFormat:@"%d", num2];
    self.label3.text = [NSString stringWithFormat:@"%d", num3];
}

- (int)resultWithIndex:(int)index {
    if (index == 0) {
        return _result1;
    } else if (index == 1) {
        return _result2;
    } else {
        return _result3;
    }
}

@end
