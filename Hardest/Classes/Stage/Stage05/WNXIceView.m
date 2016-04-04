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
    CGRect _lastRedFrame;
    CGRect _lastYellowFrame;
    CGRect _lastBlueFrame;
}

@property (nonatomic, strong) NSMutableArray *colViews;
@property (nonatomic, strong) NSMutableArray *redIces;
@property (nonatomic, strong) NSMutableArray *yellowIces;
@property (nonatomic, strong) NSMutableArray *blueIces;

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

- (NSMutableArray *)redIces {
    if (!_redIces) {
        _redIces = [NSMutableArray array];
    }
    
    return _redIces;
}

- (NSMutableArray *)yellowIces {
    if (!_yellowIces) {
        _yellowIces = [NSMutableArray array];
    }
    
    return _yellowIces;
}

- (NSMutableArray *)blueIces {
    if (!_blueIces) {
        _blueIces = [NSMutableArray array];
    }
    
    return _blueIces;
}

- (void)addIceWithRed:(BOOL)hasRed yellow:(BOOL)hasYellow blue:(BOOL)hasBlue {
    if (hasRed) {
        UIImageView *iceView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -200, 106, 89)];
        iceView.image = [UIImage imageNamed:[NSString stringWithFormat:@"03_ice0%d-iphone4", arc4random_uniform(6) + 1]];
        [self.redIces addObject:iceView];
        [self addSubview:iceView];
        
        if (self.redIces.count > 1) {
            _lastRedFrame = CGRectMake(_lastRedFrame.origin.x, _lastRedFrame.origin.y - iceView.frame.size.height * 0.56, 106, 89);
        } else {
            _lastRedFrame = CGRectMake((ScreenWidth / 3 - 106) * 0.5, CGRectGetMaxY(((UIView *)self.colViews[0]).frame) - 70, 106, 89);
        }
        
        [UIView animateWithDuration:0.2 animations:^{
            iceView.frame = _lastRedFrame;
        } completion:^(BOOL finished) {
            
        }];
    }
    
    if (hasYellow) {
        UIImageView *iceView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth / 3 - 106) * 0.5 + ScreenWidth / 3, -200, 106, 89)];
        iceView.image = [UIImage imageNamed:[NSString stringWithFormat:@"03_ice0%d-iphone4", arc4random_uniform(6) + 1]];
        [self.yellowIces addObject:iceView];
        [self addSubview:iceView];
        
        if (self.yellowIces.count > 1) {
            _lastYellowFrame = CGRectMake(_lastYellowFrame.origin.x, _lastYellowFrame.origin.y - iceView.frame.size.height * 0.56, 106, 89);
        } else {
            _lastRedFrame = CGRectMake((ScreenWidth / 3 - 106) * 0.5, CGRectGetMaxY(((UIView *)self.colViews[1]).frame) - 70, 106, 89);
        }
        
        [UIView animateWithDuration:0.2 animations:^{
            iceView.frame = _lastYellowFrame;
        } completion:^(BOOL finished) {
            
        }];
    }
    
    if (hasBlue) {
        UIImageView *iceView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth / 3 - 106) * 0.5 + ScreenWidth / 3 * 2, -200, 106, 89)];
        iceView.image = [UIImage imageNamed:[NSString stringWithFormat:@"03_ice0%d-iphone4", arc4random_uniform(6) + 1]];
        [self addSubview:iceView];
        [self.blueIces addObject:iceView];
        
        [UIView animateWithDuration:0.2 animations:^{
            if (self.blueIces.count > 1) {
                CGRect lastFrame = ((UIView *)[self.blueIces lastObject]).frame;
                iceView.frame = CGRectMake(lastFrame.origin.x, lastFrame.origin.y - iceView.frame.size.height * 0.56, 106, 89);
            } else {
                iceView.frame = CGRectMake((ScreenWidth / 3 - 106) * 0.5 + ScreenWidth / 3 * 2, CGRectGetMaxY(((UIView *)self.colViews[2]).frame) - 70, 106, 89);
            }
        } completion:^(BOOL finished) {
            
        }];
    }
}

@end
