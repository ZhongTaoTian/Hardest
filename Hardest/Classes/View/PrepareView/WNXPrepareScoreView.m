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
    
    double dif = stage.max - stage.min;
    double equal = dif / 5;

    ((UILabel *)self.labels[0]).text = [NSString stringWithFormat:stage.format, stage.min];
    ((UILabel *)self.labels[5]).text = [NSString stringWithFormat:stage.format, stage.max];
    
    for (int i = 1; i < self.labels.count; i++) {
        UILabel *label = self.labels[i];
        label.text = [NSString stringWithFormat:stage.format, stage.min + equal * i];
    }
}

- (void)showScroeView {
    
}

@end
