//
//  WNXPrepareScoreView.h
//  Hardest
//
//  Created by sfbest on 16/3/1.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WNXStage;

@interface WNXPrepareScoreView : UIView

@property (nonatomic, strong) WNXStage *stage;

- (void)showScroeViewWithCompletion:(void (^)(void))completion;

@end
