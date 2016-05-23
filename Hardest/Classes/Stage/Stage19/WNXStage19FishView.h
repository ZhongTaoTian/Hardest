//
//  WNXStage19FishView.h
//  Hardest
//
//  Created by sfbest on 16/5/19.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXStage19FishView : UIView

- (void)showFishBite:(NSInteger)index;

- (void)showPromptViewWithIndex:(NSInteger)index;

- (void)showSucessWithIndex:(NSInteger)index finish:(void(^)())finish;

- (void)removeData;
- (void)pause;
- (void)resume;

- (void)removeTimer;

@end
