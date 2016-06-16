//
//  WNXStageView.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/2/26.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WNXStage;

@interface WNXStageView : UIView

@property (nonatomic, strong) WNXStage *stage;

+ (instancetype)stageViewWithStage:(WNXStage *)stage frame:(CGRect)frame;

@end
