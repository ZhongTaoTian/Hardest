//
//  WNXTimeCountView.m
//  Hardest
//
//  Created by sfbest on 16/3/28.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXTimeCountView.h"
#import "WNXStrokeLabel.h"

@interface WNXTimeCountView ()
{
    CGAffineTransform _transform;
}

@property (weak, nonatomic) IBOutlet WNXStrokeLabel *label1;
@property (weak, nonatomic) IBOutlet WNXStrokeLabel *label2;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation WNXTimeCountView

- (void)awakeFromNib {
    [self.label1 setTextStorkeWidth:3];
    [self.label2 setTextStorkeWidth:3];
    
    self.layer.anchorPoint = CGPointMake(0, 1);
    self.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [self.backgroundImageView cleanSawtooth];
    
    UIFont *font1 = [UIFont fontWithName:@"TransformersMovie" size:110];
    UIFont *font2 = [UIFont fontWithName:@"TransformersMovie" size:50];
    if (font1 && font2) {
        self.label1.font = font1;
        self.label2.font = font2;
    }
}

- (void)startAnimationWithCompletion:(void (^)(BOOL))completion {
    [UIView animateWithDuration:0.4 animations:^{
        self.transform = CGAffineTransformMakeRotation(M_PI_4 / 8);
        _transform = self.transform;
    } completion:^(BOOL finished) {
        if (completion) {
            completion(YES);
        }
    }];
}

- (void)startCalculateTime {

}

@end
