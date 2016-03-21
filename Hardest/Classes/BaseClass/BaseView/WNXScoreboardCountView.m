//
//  WNXScoreboardCountView.m
//  Hardest
//
//  Created by sfbest on 16/3/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXScoreboardCountView.h"

@interface WNXScoreboardCountView ()
{
    CGAffineTransform _transform;
    int _count;
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

- (void)startShakeAnimation {
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformTranslate(_transform, 15, 3);
    } completion:^(BOOL finished) {
        self.transform = CGAffineTransformTranslate(_transform, 0, 0);
    }];
}

@end
