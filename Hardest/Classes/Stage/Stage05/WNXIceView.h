//
//  WNXIceView.h
//  Hardest
//
//  Created by MacBook on 16/4/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXIceView : UIView

@property (nonatomic, copy) void(^failBlock)();

- (void)showDottedLineView;

- (void)addIceWithRed:(BOOL)hasRed yellow:(BOOL)hasYellow blue:(BOOL)hasBlue;

@end
