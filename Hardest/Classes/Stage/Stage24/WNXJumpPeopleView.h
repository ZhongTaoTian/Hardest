//
//  WNXJumpPeopleView.h
//  Hardest
//
//  Created by sfbest on 16/5/31.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXJumpPeopleView : UIView

@property (nonatomic, copy) void (^jumpButtonCanClick)();

- (void)run;

- (void)readyJump;
- (void)startJump;


@end
