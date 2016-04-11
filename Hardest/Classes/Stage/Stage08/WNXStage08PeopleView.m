//
//  WNXStage08PeopleView.m
//  Hardest
//
//  Created by sfbest on 16/4/11.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage08PeopleView.h"

@interface WNXStage08PeopleView ()
{
    BOOL _isModel1;
    BOOL _isModel2;
    BOOL _isModel3;
    int _ms;
    int _count;
}
@property (weak, nonatomic) IBOutlet UIImageView *peopleIV1;
@property (weak, nonatomic) IBOutlet UIImageView *peopleIV2;
@property (weak, nonatomic) IBOutlet UIImageView *people3;
@property (weak, nonatomic) IBOutlet UIImageView *curtainLeft;
@property (weak, nonatomic) IBOutlet UIImageView *curtainRight;

@property (nonatomic, strong) CADisplayLink *timer;

@end

@implementation WNXStage08PeopleView

- (void)awakeFromNib {
    
}

- (void)showModel {
    _count++;
    while (_isModel1 == NO && _isModel2 == NO && _isModel3 == NO) {
        _isModel1 = (int)arc4random_uniform(2);
        _isModel2 = (int)arc4random_uniform(2);
        _isModel2 = (int)arc4random_uniform(2);
    }
    
    if (_count == 12) {
        _isModel1 = YES;
        _isModel2 = YES;
        _isModel3 = YES;
    }
    
    if (_isModel1) {
        self.peopleIV1.image = [UIImage imageNamed:@"02_girl01-iphone4"];
    } else {
        self.peopleIV1.image = [UIImage imageNamed:@"02_robot01-iphone4"];
    }
    
    if (_isModel2) {
        self.peopleIV2.image = [UIImage imageNamed:@"02_girl02-iphone4"];
    } else {
        self.peopleIV2.image = [UIImage imageNamed:@"02_robot01-iphone4"];
    }
    
    if (_isModel3) {
        self.people3.image = [UIImage imageNamed:@"02_girl03-iphone4"];
    } else {
        self.people3.image = [UIImage imageNamed:@"02_robot01-iphone4"];
    }
    
    [self hiddenCurtain];
}

- (void)hiddenCurtain {
    [UIView animateWithDuration:0.3 animations:^{
        self.curtainLeft.transform = CGAffineTransformMakeTranslation(-self.curtainLeft.frame.size.width, 0);
        self.curtainRight.transform = CGAffineTransformMakeTranslation(self.curtainRight.frame.size.width, 0);
    } completion:^(BOOL finished) {
        if (self.startTakePhoto) {
            self.startTakePhoto();
        }
        [self startTime];
    }];
}

- (void)showCurtain {
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundSayOKName];
    [UIView animateWithDuration:0.5 animations:^{
        self.curtainLeft.transform = CGAffineTransformIdentity;
        self.curtainRight.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (self.nextTakePhoto) {
            self.nextTakePhoto(_count == 12);
        }
    }];
}

- (void)startTime {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateTime {
    _ms++;
    if (_ms == 120) {
        _ms = 0;
        [self.timer invalidate];
        self.timer = nil;
        if (self.shopTakePhoto) {
            self.shopTakePhoto();
            [self showCurtain];
        }
    }
}

- (BOOL)takePhotoWithIndex:(int)index {
    BOOL isSucess;
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundTakePhotoName];
    switch (index) {
        case 0:
            if (_isModel1) {
                isSucess = YES;
            }
            [self showShadowWithIndex:0];
            break;
        case 1:
            if (_isModel2) {
                isSucess = YES;
            }
            [self showShadowWithIndex:1];
            break;
        case 2:
            if (_isModel3) {
                isSucess = YES;
            }
            [self showShadowWithIndex:2];
            break;
        default:
            break;
    }
    
    return isSucess;
}

- (void)showShadowWithIndex:(int)index {
//    switch (index) {
//        case 0:
//            UIImage *
//            if (_isModel1) {
//
//            break;
//        case 1:
//            break;
//        case 2:
//            break;
//        default:
//            break;
//    }
}

@end
