//
//  WNXStage14DogView.m
//  Hardest
//
//  Created by sfbest on 16/5/9.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage14DogView.h"

@interface WNXStage14DogView ()
{
    CGAffineTransform _boneTrans;
}

@property (weak, nonatomic) IBOutlet UIView *boneView;
//@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (weak, nonatomic) IBOutlet UIImageView *rightEye;
@property (weak, nonatomic) IBOutlet UIImageView *leftEye;
//@property (nonatomic, assign) 

@end

@implementation WNXStage14DogView

- (void)awakeFromNib {
    self.boneView.clipsToBounds = NO;
    self.boneView.layer.anchorPoint = CGPointMake(0.5, .8);
    self.boneView.transform = CGAffineTransformMakeTranslation(0, -500);
    _boneTrans = CGAffineTransformMakeScale(1, 1);
}

//- (UIDynamicAnimator *)animator {
//    if (_animator == nil) {
//        self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self];
//    }
//    return _animator;
//}

- (float)rotationToLeftWithSpeed:(float)speed {
    self.boneView.transform = CGAffineTransformRotate(_boneTrans, -(M_PI_4 / (100 * (1 - speed))));
    _boneTrans = self.boneView.transform;
    return _boneTrans.c;
}

- (float)rotationToRightWithSpeed:(float)speed {
    self.boneView.transform = CGAffineTransformRotate(_boneTrans, (M_PI_4 / (100 * (1 - speed))));
    _boneTrans = self.boneView.transform;
    return _boneTrans.c;
}

- (float)shakeToRithgWithOffset:(CGFloat)offset {
    self.boneView.transform = CGAffineTransformRotate(_boneTrans, (M_PI_4 * offset) / 10);
    _boneTrans = self.boneView.transform;
    
    return _boneTrans.c;
}

- (float)shakeToLeftWithOffset:(CGFloat)offset {
    self.boneView.transform = CGAffineTransformRotate(_boneTrans, (M_PI_4 * offset) / 10);
    _boneTrans = self.boneView.transform;
    
    return _boneTrans.c;
}

- (void)showBoneViewWithAnimationFinish:(void (^)())finish {
    [UIView animateWithDuration:0.3 animations:^{
        self.boneView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (finish) {
            finish();
        }
    }];
}

- (void)startDropBoneDirectionIsRight:(BOOL)isRight finish:(void (^)())finish {
    [UIView animateWithDuration:1.5 animations:^{
        if (isRight) {
            self.boneView.transform = CGAffineTransformRotate(_boneTrans, -0.9);
        } else {
            self.boneView.transform = CGAffineTransformRotate(_boneTrans, 0.9);
        }
    } completion:^(BOOL finished) {
        finish();
    }];
}

//
//- (void)startDropBoneDirectionIsRight:(BOOL)isRight finish:(void (^)())finish {
//    if (isRight) {
//        [self addGravityAndCollsionWithAngle:1.3];
//    } else {
//        [self addGravityAndCollsionWithAngle:1.8];
//    }
//}
//
//- (void)addGravityAndCollsionWithAngle:(float)angle {
//    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]init];
//    [gravity addItem:self.boneView];
//    gravity.magnitude = 0.8;
//    UICollisionBehavior *collision = [[UICollisionBehavior alloc]init];
//    collision.collisionMode = UICollisionBehaviorModeEverything;
//    [collision addItem:self.boneView];
//    collision.translatesReferenceBoundsIntoBoundary = YES;
//    [collision setTranslatesReferenceBoundsIntoBoundaryWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//
//    [self.animator addBehavior:gravity];
//    [self.animator addBehavior:collision];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        [self.animator removeBehavior:gravity];
//        [self.animator removeBehavior:collision];
//    });
//
//}

@end
