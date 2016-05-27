//
//  WNXBusView.m
//  Hardest
//
//  Created by sfbest on 16/5/27.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXBusView.h"

@interface WNXBusView ()
{
    int _count;
    int _speed;
    
    int _redBoyNum;
    int _yellowGirlNum;
    int _blueBoyNum;
}

@property (nonatomic, strong) CADisplayLink *timer;

@property (nonatomic, copy) NSMutableArray *numArr;
@property (nonatomic, copy) NSMutableArray *windowArr;

@end

@implementation WNXBusView

- (void)awakeFromNib {
    self.numArr = [NSMutableArray array];
    self.windowArr = [NSMutableArray array];

    NSArray *frameArr = [NSArray arrayWithObjects:
                         NSStringFromCGRect(CGRectMake(69, 13, 87, 79)),
                         NSStringFromCGRect(CGRectMake(164, 13, 87, 79)),
                         NSStringFromCGRect(CGRectMake(261, 13, 87, 79)),
                         NSStringFromCGRect(CGRectMake(360, 13, 87, 79)),
                         NSStringFromCGRect(CGRectMake(455, 13, 87, 79)), nil];
    for (int i = 0; i < frameArr.count; i++) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectFromString(frameArr[i])];
        iv.image = [UIImage imageNamed:@"12_bus_Rgirl-iphone4"];
        [self.windowArr addObject:iv];
        iv.hidden = YES;
        [self addSubview:iv];
    }
}

- (void)showBusWithFinish:(void (^)())finish {
    _count++;
    
    _redBoyNum = 0;
    _yellowGirlNum = 0;
    _blueBoyNum = 0;
    
    if (self.timer) {
        [self.timer invalidate];
    }
    
    int child1 = -100;
    int child2 = -100;
    int child3 = -100;
    int child4 = -100;
    int child5 = -100;
    
    [self.numArr removeAllObjects];
    
    if (_count <= 2) {
        child1 = arc4random_uniform(3);
        child2 = arc4random_uniform(3);
        [self.numArr addObject:[NSNumber numberWithInt:child1]];
        [self.numArr addObject:[NSNumber numberWithInt:child2]];
    } else if (_count <= 4) {
        child1 = arc4random_uniform(3);
        child2 = arc4random_uniform(3);
        child3 = arc4random_uniform(3);
        [self.numArr addObject:[NSNumber numberWithInt:child1]];
        [self.numArr addObject:[NSNumber numberWithInt:child2]];
        [self.numArr addObject:[NSNumber numberWithInt:child3]];
    } else if (_count <= 6) {
        child1 = arc4random_uniform(3);
        child2 = arc4random_uniform(3);
        child3 = arc4random_uniform(3);
        child4 = arc4random_uniform(3);
        [self.numArr addObject:[NSNumber numberWithInt:child1]];
        [self.numArr addObject:[NSNumber numberWithInt:child2]];
        [self.numArr addObject:[NSNumber numberWithInt:child3]];
        [self.numArr addObject:[NSNumber numberWithInt:child4]];
    } else {
        child1 = arc4random_uniform(3);
        child2 = arc4random_uniform(3);
        child3 = arc4random_uniform(3);
        child4 = arc4random_uniform(3);
        child5 = arc4random_uniform(3);
        [self.numArr addObject:[NSNumber numberWithInt:child1]];
        [self.numArr addObject:[NSNumber numberWithInt:child2]];
        [self.numArr addObject:[NSNumber numberWithInt:child3]];
        [self.numArr addObject:[NSNumber numberWithInt:child4]];
        [self.numArr addObject:[NSNumber numberWithInt:child5]];
    }
    
    for (int i = 0; i < self.numArr.count; i++) {
        int num = [self.numArr[i] intValue];
        UIImageView *windowIV = self.windowArr[i];
        windowIV.hidden = NO;
        
        if (num == 0) {
            windowIV.image = [UIImage imageNamed:@"12_bus_Bboy-iphone4"];
            _redBoyNum++;
        } else if (num == 1) {
            windowIV.image = [UIImage imageNamed:@"12_bus_Rgirl-iphone4"];
            _yellowGirlNum++;
        } else {
            windowIV.image = [UIImage imageNamed:@"12_bus_Yboy-iphone4"];
            _blueBoyNum++;
        }
    }
    
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateTime {

    
}

@end
