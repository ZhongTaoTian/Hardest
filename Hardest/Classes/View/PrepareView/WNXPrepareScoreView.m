//
//  WNXPrepareScoreView.m
//  Hardest
//
//  Created by sfbest on 16/3/1.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXPrepareScoreView.h"
#import "WNXStage.h"
#import "WNXStageInfo.h"

@interface WNXPrepareScoreView ()

@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UIImageView *scoreImageView;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;

@end

@implementation WNXPrepareScoreView

- (void)setStage:(WNXStage *)stage {
    _stage = stage;
    
    for (int i = 100; i < 106; i++) {
        UILabel *label = (UILabel *)[self viewWithTag:i];
        label.text = [NSString stringWithFormat:stage.format, stage.min + (label.tag - 100) * ((stage.max - stage.min) / 5)];
    }
    
    if (!self.stage.userInfo.rank) {
        [self.arrowImageView removeFromSuperview];
        [self.scoreImageView removeFromSuperview];
    } else {
        [self calculateArrowLocation];
    }
}

- (void)showScroeView {
    
}

- (void)calculateArrowLocation {
    
}

@end
