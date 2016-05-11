//
//  WNXStage14DogView.h
//  Hardest
//
//  Created by sfbest on 16/5/9.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXStage14DogView : UIView


- (void)showBoneViewWithAnimationFinish:(void(^)())finish;

- (float)rotationToRightWithSpeed:(float)speed;;
- (float)rotationToLeftWithSpeed:(float)speed;

- (float)shakeToRithgWithOffset:(CGFloat)offset;
- (float)shakeToLeftWithOffset:(CGFloat)offset;

- (void)startDropBoneDirectionIsRight:(BOOL)isRight finish:(void(^)())finish;

@end
