//
//  WNXResultScoreView.h
//  Hardest
//
//  Created by sfbest on 16/3/15.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WNXResultScoreViewDelegate <NSObject>

- (void)resultScoreViewChangeWithRank:(NSString *)rank;
- (void)resultScoreViewShowFailView;
- (void)resultScoreViewShowNewCount;
- (void)resultScoreViewDidRemove;

@end

@class WNXStage;

@interface WNXResultScoreView : UIView

@property (nonatomic, weak) IBOutlet UIImageView *hintImageView;
@property (nonatomic, weak) IBOutlet UIImageView *boardImageView;
@property (nonatomic, weak) IBOutlet UILabel     *scroeLabel;
@property (nonatomic, weak) IBOutlet UILabel     *unitLabel;
@property (nonatomic, weak) IBOutlet UIView      *labelView;

@property (nonatomic, weak) id <WNXResultScoreViewDelegate> delegate;

- (void)startCountScoreWithNewScroe:(double)scroe unit:(NSString *)unit stage:(WNXStage *)stage isAddScore:(BOOL)isAddScroe;

@end
