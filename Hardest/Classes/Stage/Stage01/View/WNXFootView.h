//
//  WNXFootView.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/4.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXFootView : UIView

- (void)startAnimation;

- (void)stopFootView;

- (BOOL)attackFootViewAtIndex:(int)index;

- (void)pause;
- (void)continueFootView;
- (void)clean;

@end
