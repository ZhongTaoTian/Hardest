//
//  WNXStage12BottomView.h
//  Hardest
//
//  Created by MacBook on 16/5/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WNXStage12BottomViewType) {
    WNXStage12BottomViewTypeNormal = 0,
    WNXStage12BottomViewTypeFail,
    WNXStage12BottomViewTypeSucess
};

@interface WNXStage12BottomView : UIView

- (void)changeBottomWihtIndex:(NSInteger)index imageType:(WNXStage12BottomViewType)imageType;

@end
