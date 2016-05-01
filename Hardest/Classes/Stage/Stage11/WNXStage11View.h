//
//  WNXStage11View.h
//  Hardest
//
//  Created by sfbest on 16/4/27.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXStage11View : UIView

@property (nonatomic, copy) void (^handViewShowAnimation) (BOOL isRight);

- (void)showSubjectViewWithNums:(void (^)(int index1, int index2, int index3))nums;

- (void)guessResult:(int)result;

- (void)showHandViewAnimationFinish:(void (^) (void))finish;

@end
