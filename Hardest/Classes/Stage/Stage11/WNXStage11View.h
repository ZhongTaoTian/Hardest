//
//  WNXStage11View.h
//  Hardest
//
//  Created by sfbest on 16/4/27.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXStage11View : UIView

- (void)showSubjectViewWithNums:(void (^)(int index1, int index2, int index3))nums;

- (BOOL)guessResult:(int)result;

@end
