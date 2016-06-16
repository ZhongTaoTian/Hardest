//
//  WNXScoreboardCountView.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNXStrokeLabel.h"
@interface WNXScoreboardCountView : UIView

@property (weak, nonatomic) IBOutlet WNXStrokeLabel *countLabel;

- (void)startAnimationWithCompletion:(void (^)(BOOL finished))completion;

- (void)hit;

- (void)clean;

- (void)setScore:(NSInteger)score;

@end
