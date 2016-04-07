//
//  WNXStage06PeolpeView.h
//  Hardest
//
//  Created by MacBook on 16/4/7.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXStage06PeolpeView : UIView

@property (nonatomic, copy) void (^failBlock)();

- (void)punchTheFace;

- (void)cleanData;

- (BOOL)doneBtnClick;

@end
