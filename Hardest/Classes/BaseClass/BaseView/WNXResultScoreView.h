//
//  WNXResultScoreView.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/15.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNXStrokeLabel.h"

@protocol WNXResultScoreViewDelegate <NSObject>

- (void)resultScoreViewChangeWithRank:(NSString *)rank;
- (void)resultScoreViewShowFailViewPassScroeStr:(NSString *)passScroe userScroeStr:(NSString *)userScroe;
- (void)resultScoreViewShowNewCount;
- (void)resultScoreViewDidRemove;

@end

@class WNXStage;

@interface WNXResultScoreView : UIView

@property (nonatomic, weak) IBOutlet UIImageView    *hintImageView;
@property (nonatomic, weak) IBOutlet UIImageView    *boardImageView;
@property (nonatomic, weak) IBOutlet WNXStrokeLabel *scroeLabel;
@property (nonatomic, weak) IBOutlet WNXStrokeLabel *unitLabel;
@property (nonatomic, weak) IBOutlet UIView         *labelView;

@property (nonatomic, weak) id <WNXResultScoreViewDelegate> delegate;

- (void)startCountScoreWithNewScroe:(double)scroe unit:(NSString *)unit stage:(WNXStage *)stage isAddScore:(BOOL)isAddScroe;

@end
