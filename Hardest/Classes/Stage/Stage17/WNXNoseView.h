//
//  WNXNoseView.h
//  Hardest
//
//  Created by sfbest on 16/5/16.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXNoseView : UIView

@property (nonatomic, copy) void(^passStageBlock)();

- (void)showPullAnimationWithIsPullOut:(BOOL)pullOut score:(int)score finish:(void(^)())finish;

- (void)pause;
- (void)resume;

- (void)resumeData;

@end
