//
//  WNXCountDownLabel.m
//  Hardest
//
//  Created by sfbest on 16/3/4.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXCountDownLabel.h"

typedef void(^Completion)(void);

@interface WNXCountDownLabel ()
{
    int _index;
}

@property (nonatomic, assign) double time;
@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, copy) Completion completion;

@end

@implementation WNXCountDownLabel

- (instancetype)initWithFrame:(CGRect)frame startTime:(double)time textSize:(CGFloat)size {
    if (self = [super initWithFrame:frame]) {
        _time = time;
        self.text = [NSString stringWithFormat:@"%.1f", time];
        
        UIFont *font = [UIFont fontWithName:@"TransformersMovie" size:size];
        
        if (font) {
            self.font = font;
        } else {
            self.font = [UIFont systemFontOfSize:size];
        }
    }
    
    return self;
}

- (void)startCountDownWithCompletion:(void (^)(void))completion {
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(countDown:)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.completion = completion;
}

- (void)countDown:(CADisplayLink *)timer {
    _index++;
    
    if (_index == 6) {
        self.time -= 0.1;
        self.text = [NSString stringWithFormat:@"%.1f", self.time];
        _index = 0;
    }
    
    if (self.time <= 0) {
        [timer invalidate];
        self.text = @"0.0";
        timer = nil;
        
        if (self.completion) {
            self.completion();
        }
        
    }
}



@end
