//
//  WNXResultScoreView.h
//  Hardest
//
//  Created by sfbest on 16/3/15.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WNXStage;

@interface WNXResultScoreView : UIView

- (void)startCountScoreWithNewScroe:(double)scroe unit:(NSString *)unit stage:(WNXStage *)stage isAddScore:(BOOL)isAddScroe;

@end
