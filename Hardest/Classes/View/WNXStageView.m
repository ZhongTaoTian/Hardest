//
//  WNXStageView.m
//  Hardest
//
//  Created by sfbest on 16/2/26.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStageView.h"
#import "UIView+WNXImage.h"
#import "WNXStage.h"

@interface WNXStageView ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIImageView *edgeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rankShadowView;
@property (weak, nonatomic) IBOutlet UIButton *numButton;
@property (weak, nonatomic) IBOutlet UIImageView *rankImageView;
@property (weak, nonatomic) IBOutlet UIImageView *stageNewImageView;
@property (weak, nonatomic) IBOutlet UIView *lockView;


@end

@implementation WNXStageView

+ (instancetype)stageViewWithStage:(WNXStage *)stage {
    WNXStageView *stageView = [WNXStageView viewFromNib];
    stageView.stage = stage;

    return stageView;
}

- (void)awakeFromNib {
    self.clipsToBounds = NO;
    self.numButton.userInteractionEnabled = NO;
    self.rankImageView.hidden = YES;
    self.stageNewImageView.hidden = YES;
    self.rankShadowView.hidden = YES;
}

- (void)setStage:(WNXStage *)stage {
    _stage = stage;
    self.backgroundImageView.image = [UIImage imageNamed:stage.icon];
    [self.numButton setTitle:[NSString stringWithFormat:@"%d", stage.num] forState:UIControlStateNormal];
    [self updateStageViewInfo];
}

- (void)updateStageViewInfo {
    
}

- (void)startUnLockAnmiation {
    
}

@end
