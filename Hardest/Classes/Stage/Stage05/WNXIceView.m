//
//  WNXIceView.m
//  Hardest
//
//  Created by MacBook on 16/4/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

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
    int _count;
    int _isSucess;
}

@property (nonatomic, strong) NSMutableArray *colViews;
@property (nonatomic, strong) NSMutableArray *redIces;
@property (nonatomic, strong) NSMutableArray *yellowIces;
@property (nonatomic, strong) NSMutableArray *blueIces;

@end

@implementation WNXIceView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
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
    _count++;
    
    _isSucess = NO;
    _random1 = arc4random_uniform(4) + 1;
    _random2 = arc4random_uniform(4) + 1;
    _random3 = arc4random_uniform(4) + 1;
    for (UIView *tmpView in self.redIces) {
        [tmpView removeFromSuperview];
    }
    for (UIView *tmpView in self.yellowIces) {
        [tmpView removeFromSuperview];
    }
    
    for (UIView *tmpView in self.blueIces) {
        [tmpView removeFromSuperview];
    }
    
    [self.redIces removeAllObjects];
    [self.yellowIces removeAllObjects];
    [self.blueIces removeAllObjects];
    
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
    
    self.superview.userInteractionEnabled = YES;
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

- (void)addIceWithIndex:(NSInteger)index {
    if (index == 0) {
        UIImageView *iceView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -200, 106, 89)];
        iceView.image = [UIImage imageNamed:[NSString stringWithFormat:@"03_ice0%d-iphone4", arc4random_uniform(6) + 1]];
        [self.redIces addObject:iceView];
        [self addSubview:iceView];
        
        if (self.redIces.count > 1) {
            _lastRedFrame = CGRectMake(_lastRedFrame.origin.x, _lastRedFrame.origin.y - iceView.frame.size.height * 0.56, 106, 89);
        } else {
            _lastRedFrame = CGRectMake((ScreenWidth / 3 - 106) * 0.5, CGRectGetMaxY(((UIView *)self.colViews[0]).frame) - 70, 106, 89);
        }
        
        [UIView animateWithDuration:0.15 animations:^{
            iceView.frame = _lastRedFrame;
        } completion:^(BOOL finished) {
            [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundArrivalName];
            [self examineState];
        }];
    }
    
    if (index == 1) {
        UIImageView *iceView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth / 3 - 106) * 0.5 + ScreenWidth / 3, -200, 106, 89)];
        iceView.image = [UIImage imageNamed:[NSString stringWithFormat:@"03_ice0%d-iphone4", arc4random_uniform(6) + 1]];
        [self.yellowIces addObject:iceView];
        [self addSubview:iceView];
        
        if (self.yellowIces.count > 1) {
            _lastYellowFrame = CGRectMake(_lastYellowFrame.origin.x, _lastYellowFrame.origin.y - iceView.frame.size.height * 0.56, 106, 89);
        } else {
            _lastYellowFrame = CGRectMake((ScreenWidth / 3 - 106) * 0.5 + ScreenWidth / 3, CGRectGetMaxY(((UIView *)self.colViews[1]).frame) - 70, 106, 89);
        }
        
        [UIView animateWithDuration:0.15 animations:^{
            iceView.frame = _lastYellowFrame;
        } completion:^(BOOL finished) {
            [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundArrivalName];
            [self examineState];
        }];
    }
    
    if (index == 2) {
        UIImageView *iceView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth / 3 - 106) * 0.5 + ScreenWidth / 3 * 2, -200, 106, 89)];
        iceView.image = [UIImage imageNamed:[NSString stringWithFormat:@"03_ice0%d-iphone4", arc4random_uniform(6) + 1]];
        [self addSubview:iceView];
        [self.blueIces addObject:iceView];
        
        if (self.blueIces.count > 1) {
            _lastBlueFrame = CGRectMake(_lastBlueFrame.origin.x, _lastBlueFrame.origin.y - iceView.frame.size.height * 0.56, 106, 89);
        } else {
            _lastBlueFrame = CGRectMake((ScreenWidth / 3 - 106) * 0.5 + ScreenWidth / 3 * 2, CGRectGetMaxY(((UIView *)self.colViews[2]).frame) - 70, 106, 89);
        }
        
        [UIView animateWithDuration:0.15 animations:^{
            iceView.frame = _lastBlueFrame;
        } completion:^(BOOL finished) {
            [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundArrivalName];
            [self examineState];
        }];
    }
}

- (void)examineState {
    if (self.redIces.count > _random1 || self.yellowIces.count > _random2 || self.blueIces.count > _random3) {
        self.superview.userInteractionEnabled = NO;
        NSMutableArray *failViewArr = [NSMutableArray array];
        if (self.redIces.count > _random1) {
            for (int i = _random1; i < self.redIces.count; i++) {
                UIView *tmpView = self.redIces[i];
                [failViewArr addObject:tmpView];
            }
        }
        
        if (self.yellowIces.count > _random2) {
            for (int i = _random2; i < self.yellowIces.count; i++) {
                UIView *tmpView = self.yellowIces[i];
                [failViewArr addObject:tmpView];
            }
        }
        
        if (self.blueIces.count > _random3) {
            for (int i = _random3; i < self.blueIces.count; i++) {
                UIView *tmpView = self.blueIces[i];
                [failViewArr addObject:tmpView];
            }
        }
        
        [UIView animateWithDuration:0.1 animations:^{
            for (UIView *tmpView in failViewArr) {
                tmpView.alpha = 0;
            }
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                for (UIView *tmpView in failViewArr) {
                    tmpView.alpha = 1;
                }
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    for (UIView *tmpView in failViewArr) {
                        tmpView.alpha = 0;
                    }
                } completion:^(BOOL finished) {
                    self.failBlock();
                }];
            }];
        }];
        
    }
    
    if (self.redIces.count == _random1 && self.yellowIces.count == _random2 && self.blueIces.count == _random3) {
        self.superview.userInteractionEnabled = NO;
        if (_count == 9) {
            self.isPass = YES;
            self.passBlock();
        }
        
        if (!_isSucess) {
            self.successBlock(_random1 + _random2 + _random3);
            _isSucess = YES;
        }
    }
}

@end
