//
//  WNXReadyGoView.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXReadyGoView : UIView

+ (void)showReadyGoViewWithSuperView:(UIView *)superView completion:(void (^)(void))completion;

@end
