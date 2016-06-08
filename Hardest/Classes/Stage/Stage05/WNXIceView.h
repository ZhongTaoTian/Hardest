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
@property (nonatomic, copy) void(^successBlock)(int iceCount);
@property (nonatomic, copy) void(^passBlock)();
@property (nonatomic, assign) BOOL isPass;

- (void)showDottedLineView;

- (void)addIceWithIndex:(NSInteger)index;

@end
