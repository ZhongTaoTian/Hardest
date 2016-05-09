//
//  WNXStage13BottomView.h
//  Hardest
//
//  Created by sfbest on 16/5/4.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WNXStage13BottomType) {
    WNXStage13BottomTypeNone = 0,
    WNXStage13BottomTypePeople,
    WNXStage13BottomTypeTick
};

@interface WNXStage13BottomView : UIView

- (void)changeBottomImageViewWihtIndex:(NSInteger)index type:(WNXStage13BottomType)type;

- (void)showPeopleImageViewWithIndex:(NSInteger)index;
- (void)hidePeopleImageViewWithIndex:(NSInteger)index;

- (void)cleanData;

@end
