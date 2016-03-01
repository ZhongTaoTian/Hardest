//
//  WNXStageListView.h
//  Hardest
//
//  Created by sfbest on 16/2/26.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WNXStage;

@interface WNXStageListView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, copy) void (^didChangeScrollPage)(int page);
@property (nonatomic, copy) void (^didSelectedStageView)(WNXStage *stage);

@end
