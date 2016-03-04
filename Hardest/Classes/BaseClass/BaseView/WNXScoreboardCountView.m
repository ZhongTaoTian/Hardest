//
//  WNXScoreboardCountView.m
//  Hardest
//
//  Created by sfbest on 16/3/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXScoreboardCountView.h"
#import "WNXStrokeLabel.h"

@interface WNXScoreboardCountView ()

@property (weak, nonatomic) IBOutlet WNXStrokeLabel *countLabel;
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
}

- (void)startAnimationWithCompletion:(void (^)(BOOL))completion{

    [UIView animateWithDuration:0.4 animations:^{
        self.transform = CGAffineTransformMakeRotation(M_PI_4 / 8);
    } completion:^(BOOL finished) {
        if (completion) {
            completion(YES);
        }
    }];
}

@end
