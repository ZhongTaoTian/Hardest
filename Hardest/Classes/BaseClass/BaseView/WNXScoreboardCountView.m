//
//  WNXScoreboardCountView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//
//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXScoreboardCountView.h"

@interface WNXScoreboardCountView ()
{
    CGAffineTransform _transform;
    int _count;
    int _allScore;
}

@property (weak, nonatomic) IBOutlet WNXStrokeLabel *ptsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation WNXScoreboardCountView

- (void)awakeFromNib {
    self.clipsToBounds = NO;
    [self.countLabel setTextStorkeWidth:3];
    [self.ptsLabel setTextStorkeWidth:3];
    
    self.layer.anchorPoint = CGPointMake(0, 1);
    self.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [self.backgroundImageView cleanSawtooth];
    
    
    UIFont *font1 = [UIFont fontWithName:@"TransformersMovie" size:100];
    UIFont *font2 = [UIFont fontWithName:@"TransformersMovie" size:50];
    if (font1 && font2) {
        self.countLabel.font = font1;
        self.ptsLabel.font = font2;
    }
}

- (void)clean {
    self.countLabel.text = @"000";
    _count = 0;
    _allScore = 0;
}

- (void)startAnimationWithCompletion:(void (^)(BOOL))completion{
    [UIView animateWithDuration:0.4 animations:^{
        self.transform = CGAffineTransformMakeRotation(M_PI_4 / 8);
        _transform = self.transform;
    } completion:^(BOOL finished) {
        if (completion) {
            completion(YES);
        }
    }];
}

- (void)hit {
    [self startShakeAnimation];
    _count++;
    if (_count <= 9) {
        self.countLabel.text = [NSString stringWithFormat:@"00%d", _count];
    } else if (_count >= 10 && _count < 100) {
        self.countLabel.text = [NSString stringWithFormat:@"0%d", _count];
    } else {
        self.countLabel.text = [NSString stringWithFormat:@"%d", _count];
    }
}

- (void)setScore:(NSInteger)score {
    _allScore += score;
    [self startShakeAnimation];
    if (_allScore <= 9) {
        self.countLabel.text = [NSString stringWithFormat:@"00%d", _allScore];
    } else if (_allScore >= 10 && _allScore < 100) {
        self.countLabel.text = [NSString stringWithFormat:@"0%d", _allScore];
    } else {
        self.countLabel.text = [NSString stringWithFormat:@"%d", _allScore];
    }
}

- (void)startShakeAnimation {
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformTranslate(_transform, 15, 3);
    } completion:^(BOOL finished) {
        self.transform = CGAffineTransformTranslate(_transform, 0, 0);
    }];
}

@end
