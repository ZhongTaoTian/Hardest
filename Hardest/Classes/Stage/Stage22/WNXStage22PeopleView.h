//
//  WNXStage22PeopleView.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/25.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXStage22PeopleView : UIView

@property (nonatomic, copy) void (^fartFinish)();
@property (nonatomic, copy) void (^sucess)();

@property (nonatomic, weak) UIImageView *redIV;
@property (nonatomic, weak) UIImageView *yellowIV;
@property (nonatomic, weak) UIImageView *blueIV;

@property (nonatomic, assign) int count;

- (void)startFart;

- (BOOL)fartWithIndex:(int)index;

- (void)removeData;

@end
