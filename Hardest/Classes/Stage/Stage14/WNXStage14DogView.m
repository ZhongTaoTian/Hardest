//
//  WNXStage14DogView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/9.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage14DogView.h"

@interface WNXStage14DogView ()
{
    CGAffineTransform _boneTrans;
}

@property (weak, nonatomic) IBOutlet UIView *boneView;
//@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (weak, nonatomic) IBOutlet UIImageView *rightEye;
@property (weak, nonatomic) IBOutlet UIImageView *leftEye;
@property (nonatomic, assign) float angle;

@end

@implementation WNXStage14DogView

- (void)awakeFromNib {
    self.boneView.clipsToBounds = NO;
    self.boneView.layer.anchorPoint = CGPointMake(0.5, .8);
    self.boneView.hidden = YES;
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
    self.angle = _boneTrans.c;
    
    return _boneTrans.c;
}

- (float)rotationToRightWithSpeed:(float)speed {
    self.boneView.transform = CGAffineTransformRotate(_boneTrans, (M_PI_4 / (100 * (1 - speed))));
    _boneTrans = self.boneView.transform;
    self.angle = _boneTrans.c;
    
    return _boneTrans.c;
}

- (float)shakeToRithgWithOffset:(CGFloat)offset {
    self.boneView.transform = CGAffineTransformRotate(_boneTrans, (M_PI_4 * offset) / 10);
    _boneTrans = self.boneView.transform;
    self.angle = _boneTrans.c;
    
    return _boneTrans.c;
}

- (float)shakeToLeftWithOffset:(CGFloat)offset {
    self.boneView.transform = CGAffineTransformRotate(_boneTrans, (M_PI_4 * offset) / 10);
    _boneTrans = self.boneView.transform;
    self.angle = _boneTrans.c;
    
    return _boneTrans.c;
}

- (void)showBoneViewWithAnimationFinish:(void (^)())finish {
    self.boneView.frame = CGRectMake(self.boneView.frame.origin.x, self.boneView.frame.origin.y - 500, self.boneView.frame.size.width, self.boneView.frame.size.height);
    self.boneView.hidden = NO;
    
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundDogbarkOnceName];
    [UIView animateWithDuration:0.2 animations:^{
        self.boneView.frame = CGRectMake(self.boneView.frame.origin.x, self.boneView.frame.origin.y + 500, self.boneView.frame.size.width, self.boneView.frame.size.height);
    } completion:^(BOOL finished) {
        if (finish) {
            finish();
        }
    }];
}

- (void)startDropBoneDirectionIsRight:(BOOL)isRight finish:(void (^)())finish {
    [UIView animateWithDuration:0.5 animations:^{
        if (isRight) {
            self.boneView.transform = CGAffineTransformRotate(_boneTrans, -0.9);
        } else {
            self.boneView.transform = CGAffineTransformRotate(_boneTrans, 0.9);
        }
    } completion:^(BOOL finished) {
        finish();
    }];
}

// 左边 正数0 ~ 0.8 右边负数 0 ~ -0.8
- (void)setAngle:(float)angle {
    _angle = angle;
    
    if (angle <= 0.1 && angle >= -0.1 ) {
        return;
    }
    
    if (angle < -0.1) {
        self.rightEye.transform = CGAffineTransformMakeTranslation(25 * -angle, 10 * -angle);
        self.leftEye.transform = CGAffineTransformMakeTranslation(10 * -angle, 10 * -angle);
    } else if (angle > 0.1) {
        self.leftEye.transform = CGAffineTransformMakeTranslation(25 * -angle, 10 * angle);
        self.rightEye.transform = CGAffineTransformMakeTranslation(10 * -angle, 10 * angle);
    }
}

- (void)resumeData {
     _boneTrans = CGAffineTransformMakeScale(1, 1);
    
    self.boneView.transform = CGAffineTransformIdentity;
    self.boneView.hidden = YES;
    self.leftEye.transform = CGAffineTransformIdentity;
    self.rightEye.transform = CGAffineTransformIdentity;
    self.angle = 0;
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
