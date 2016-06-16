//
//  WNXStage22PeopleView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/25.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage22PeopleView.h"
#import "WNXStrokeLabel.h"
#import "UIColor+WNXColor.h"

@interface WNXStage22PeopleView ()
{
    int _clickCount;
    BOOL _isReomve;
}

@property (nonatomic, strong) UIImageView *leftIV;
@property (nonatomic, strong) UIImageView *middleIV;
@property (nonatomic, strong) UIImageView *rightIV;

@property (nonatomic, strong) WNXStrokeLabel *countLabel;
@property (nonatomic, strong) UIImageView *fartIV;

@property (nonatomic, strong) NSMutableArray *numArr;

@end

@implementation WNXStage22PeopleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - ScreenWidth / 3)]) {
        
        self.leftIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 160, 140, 263)];
        self.leftIV.image = [UIImage imageNamed:@"24_Bbt_stand-iphone4"];
        [self addSubview:self.leftIV];
        
        self.middleIV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth / 3 , 160, 140, 263)];
        self.middleIV.image = [UIImage imageNamed:@"24_Ybt_stand-iphone4"];
        [self addSubview:self.middleIV];
        
        self.rightIV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth / 3 * 2, 160, 140, 263)];
        self.rightIV.image = [UIImage imageNamed:@"24_Rbt_stand-iphone4"];
        [self addSubview:self.rightIV];
        
        UIImageView *shadow1 = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth / 3 - 90) * 0.5, CGRectGetMaxY(self.rightIV.frame) - 20, 90, 32)];
        shadow1.image = [UIImage imageNamed:@"24_shadow-iphone4"];
        [self insertSubview:shadow1 belowSubview:self.leftIV];
        
        UIImageView *shadow2 = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth / 3 - 90) * 0.5 + ScreenWidth / 3, CGRectGetMaxY(self.rightIV.frame) - 20, 90, 32)];
        shadow2.image = [UIImage imageNamed:@"24_shadow-iphone4"];
        [self insertSubview:shadow2 belowSubview:self.leftIV];
        
        UIImageView *shadow3 = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth / 3 - 90) * 0.5 + ScreenWidth / 3 * 2 + 5, CGRectGetMaxY(self.rightIV.frame) - 20, 90, 32)];
        shadow3.image = [UIImage imageNamed:@"24_shadow-iphone4"];
        [self insertSubview:shadow3 belowSubview:self.leftIV];
        
        self.fartIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 76)];
        self.fartIV.hidden = YES;
        self.fartIV.image = [UIImage imageNamed:@"24_fart01-iphone4"];
        [self addSubview:self.fartIV];
        
        self.countLabel = [[WNXStrokeLabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth / 3, 50)];
        self.countLabel.textColor = [UIColor colorWithR:24 g:128 b:231];
        [self.countLabel setTextStorkeWidth:6];
        [self.countLabel setBorderDrawColor:[UIColor whiteColor]];
        self.countLabel.textAlignment = NSTextAlignmentCenter;
        self.countLabel.font = [UIFont fontWithName:@"TransformersMovie" size:80];
        self.countLabel.hidden = YES;
        [self addSubview:self.countLabel];
        
        _count = 3;
        
        self.numArr = [NSMutableArray array];
    }
    
    return self;
}

- (void)startFart {
    _clickCount = 0;
    if (self.numArr.count > 0) {
        [self.numArr removeAllObjects];
    }
    
    _count++;
    for (int fartCount = 1; fartCount <= _count; fartCount++) {
        
        int fartNum = arc4random_uniform(3);
        [self.numArr addObject:[NSNumber numberWithInt:fartNum]];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((fartCount - 1) * 0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (_isReomve) {
                return;
            }
            
            NSString *soundName;
            if (fartNum == 0) {
                soundName = kSoundFart01Nmae;
            } else if (fartNum == 1) {
                soundName = kSoundFart02Name;
            } else {
                soundName = kSoundFart03Name;
            }
            
            [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:soundName];
            
            if (_isReomve) {
                return;
            }
            
            NSLog(@"%@", self);
            
            if (fartNum == 0) {
                self.leftIV.image = [UIImage imageNamed:@"24_Bbt_fart-iphone4"];
                self.redIV.highlighted = YES;
                self.fartIV.frame = CGRectMake(0 , 300, 100, 76);
                self.countLabel.frame = CGRectMake(0, 370, ScreenWidth / 3, 80);
            } else if (fartNum == 1) {
                self.middleIV.image = [UIImage imageNamed:@"24_Ybt_fart-iphone4"];
                self.yellowIV.highlighted = YES;
                self.fartIV.frame = CGRectMake(ScreenWidth / 3 , 300, 100, 76);
                self.countLabel.frame = CGRectMake(ScreenWidth / 3, 370, ScreenWidth / 3, 80);
            } else if (fartNum == 2) {
                self.rightIV.image = [UIImage imageNamed:@"24_Rbt_fart-iphone4"];
                self.blueIV.highlighted = YES;
                self.fartIV.frame = CGRectMake(ScreenWidth / 3 * 2 , 300, 100, 76);
                self.countLabel.frame = CGRectMake(ScreenWidth / 3 * 2, 370, ScreenWidth / 3, 80);
            }
            
            self.countLabel.text = [NSString stringWithFormat:@"%d", fartCount];
            self.fartIV.hidden = NO;
            self.countLabel.hidden = NO;
            
            [UIView animateWithDuration:0.2 animations:^{
                self.fartIV.alpha = 0;
            } completion:^(BOOL finished) {
                self.fartIV.hidden = YES;
                self.fartIV.alpha = 1;
            }];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
                self.leftIV.image = [UIImage imageNamed:@"24_Bbt_stand-iphone4"];
                self.middleIV.image = [UIImage imageNamed:@"24_Ybt_stand-iphone4"];
                self.rightIV.image = [UIImage imageNamed:@"24_Rbt_stand-iphone4"];
                
                self.blueIV.highlighted = NO;
                self.redIV.highlighted = NO;
                self.yellowIV.highlighted = NO;
                self.countLabel.hidden = YES;
                
                if (fartCount == _count) {
                    if (self.fartFinish) {
                        self.fartFinish();
                    }
                }
            });
            
        });
    }
}

- (BOOL)fartWithIndex:(int)index {
    BOOL result;
    
    if (self.numArr.count > 0) {
        int fartIndex = [self.numArr[0] intValue];
        
        result = index == fartIndex;
        
        NSString *soundName;
        if (index == 0) {
            soundName = kSoundFart01Nmae;
        } else if (index == 1) {
            soundName = kSoundFart02Name;
        } else {
            soundName = kSoundFart03Name;
        }
        
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:soundName];
        
        if (result) {
            _clickCount++;
            if (index == 0) {
                self.leftIV.image = [UIImage imageNamed:@"24_Bbt_fart-iphone4"];
                self.redIV.highlighted = YES;
                self.fartIV.frame = CGRectMake(0 , 300, 100, 76);
                self.countLabel.frame = CGRectMake(0, 370, ScreenWidth / 3, 80);
                
            } else if (index == 1) {
                self.middleIV.image = [UIImage imageNamed:@"24_Ybt_fart-iphone4"];
                self.yellowIV.highlighted = YES;
                self.fartIV.frame = CGRectMake(ScreenWidth / 3 , 300, 100, 76);
                self.countLabel.frame = CGRectMake(ScreenWidth / 3, 370, ScreenWidth / 3, 80);
                
            } else {
                self.rightIV.image = [UIImage imageNamed:@"24_Rbt_fart-iphone4"];
                self.blueIV.highlighted = YES;
                self.fartIV.frame = CGRectMake(ScreenWidth / 3 * 2 , 300, 100, 76);
                self.countLabel.frame = CGRectMake(ScreenWidth / 3 * 2, 370, ScreenWidth / 3, 80);
            }
            
            self.fartIV.hidden = NO;
            self.countLabel.text = [NSString stringWithFormat:@"%d", _clickCount];
            self.countLabel.hidden = NO;
            
            [UIView animateWithDuration:0.2 animations:^{
                self.fartIV.alpha = 0;
            } completion:^(BOOL finished) {
                self.fartIV.hidden = YES;
                self.fartIV.alpha = 1;
            }];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.leftIV.image = [UIImage imageNamed:@"24_Bbt_stand-iphone4"];
                self.middleIV.image = [UIImage imageNamed:@"24_Ybt_stand-iphone4"];
                self.rightIV.image = [UIImage imageNamed:@"24_Rbt_stand-iphone4"];
                
                self.blueIV.highlighted = NO;
                self.redIV.highlighted = NO;
                self.yellowIV.highlighted = NO;
                self.countLabel.hidden = YES;
            });

            [self.numArr removeObjectAtIndex:0];
            
            if (self.numArr.count == 0) {
                if (self.sucess) {
                    self.sucess();
                }
            }
        } else {
            if (index == 0) {
                self.leftIV.image = [UIImage imageNamed:@"24_Bbt_fart-iphone4"];
                self.redIV.highlighted = YES;
                self.fartIV.frame = CGRectMake(0 , 300, 100, 76);
                
            } else if (index == 1) {
                self.middleIV.image = [UIImage imageNamed:@"24_Ybt_fart-iphone4"];
                self.yellowIV.highlighted = YES;
                self.fartIV.frame = CGRectMake(ScreenWidth / 3 , 300, 100, 76);
            } else {
                self.rightIV.image = [UIImage imageNamed:@"24_Rbt_fart-iphone4"];
                self.blueIV.highlighted = YES;
                self.fartIV.frame = CGRectMake(ScreenWidth / 3 * 2 , 300, 100, 76);
            }
            
            self.fartIV.hidden = NO;
            
            [UIView animateWithDuration:0.2 animations:^{
                self.fartIV.alpha = 0;
            } completion:^(BOOL finished) {
                self.fartIV.hidden = YES;
                self.fartIV.alpha = 1;
            }];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.leftIV.image = [UIImage imageNamed:@"24_Bbt_stand-iphone4"];
                self.middleIV.image = [UIImage imageNamed:@"24_Ybt_stand-iphone4"];
                self.rightIV.image = [UIImage imageNamed:@"24_Rbt_stand-iphone4"];
                
                self.blueIV.highlighted = NO;
                self.redIV.highlighted = NO;
                self.yellowIV.highlighted = NO;
                self.countLabel.hidden = YES;
            });
        }
    }
    
    return result;
}

- (void)removeData {
    self.fartFinish = nil;
    self.sucess = nil;
    
    self.redIV = nil;
    self.yellowIV = nil;
    self.blueIV = nil;
    
    _isReomve = YES;
    
    self.numArr = nil;
    
    [self removeFromSuperview];
}

- (void)dealloc {
    NSLog(@"销毁了");
}

@end
