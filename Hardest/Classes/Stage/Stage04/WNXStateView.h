//
//  WNXStateView.h
//  Hardest
//
//  Created by MacBook on 16/4/1.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,WNXResultStateType) {
    WNXResultStateTypeOK = 0,
    WNXResultStateTypeGood = 1,
    WNXResultStateTypeGreat = 2,
    WNXResultStateTypePerfect = 3,
    WNXResultStateTypeBad = 4
};

@interface WNXStateView : UIView

@property (nonatomic, assign) WNXResultStateType type;

- (void)showStateViewWithType:(WNXResultStateType)type;
- (void)hideStateView;

- (void)showStateViewWithType:(WNXResultStateType)type stageViewHiddenFinishBlock:(void (^)(void))stageViewHiddenFinishBlock;

@end
