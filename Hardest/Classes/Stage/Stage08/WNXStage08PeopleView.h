//
//  WNXStage08PeopleView.h
//  Hardest
//
//  Created by sfbest on 16/4/11.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXStage08PeopleView : UIView

@property (nonatomic, copy) void(^startTakePhoto)();
@property (nonatomic, copy) void(^shopTakePhoto)();
@property (nonatomic, copy) void(^nextTakePhoto)(BOOL isPass);

- (BOOL)takePhotoWithIndex:(int)index;

- (void)showModel;

@end
