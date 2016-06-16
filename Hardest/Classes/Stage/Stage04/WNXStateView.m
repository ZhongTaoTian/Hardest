//
//  WNXStateView.m
//  Hardest
//
//  Created by MacBook on 16/4/1.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStateView.h"

@interface WNXStateView ()
@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;
@property (weak, nonatomic) IBOutlet UIImageView *circleImageView;

@property (nonatomic, copy) void (^hiddenFinsih)();
@property (nonatomic, copy) void (^showFinish)();

@end

@implementation WNXStateView

- (void)awakeFromNib {
    self.hidden = YES;
}

- (void)setType:(WNXResultStateType)type {
    _type = type;
    
    switch (type) {
        case WNXResultStateTypeGood:
            self.stateImageView.image = [UIImage imageNamed:@"00_good-iphone4"];
            self.circleImageView.image = [UIImage imageNamed:@"00_circle-iphone4"];
            break;
        case WNXResultStateTypeGreat:
            self.stateImageView.image = [UIImage imageNamed:@"00_great-iphone4"];
            self.circleImageView.image = [UIImage imageNamed:@"00_circle-iphone4"];
            break;
        case WNXResultStateTypeOK:
            self.stateImageView.image = [UIImage imageNamed:@"00_okay-iphone4"];
            self.circleImageView.image = [UIImage imageNamed:@"00_circle-iphone4"];
            break;
        case WNXResultStateTypePerfect:
            self.stateImageView.image = [UIImage imageNamed:@"00_perfect-iphone4"];
            self.circleImageView.image = [UIImage imageNamed:@"00_circle-iphone4"];
            break;
        case WNXResultStateTypeBad:
            self.stateImageView.image = [UIImage imageNamed:@"00_bad-iphone4"];
            self.circleImageView.image = [UIImage imageNamed:@"00_cross-iphone4"];
            break;
        default:
            break;
    }
}

- (void)showStateViewWithType:(WNXResultStateType)type {
    self.type = type;
    self.hidden = NO;
    switch (type) {
        case WNXResultStateTypeOK:
            [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundOKName];
            break;
        case WNXResultStateTypeGood:
            [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundGoodName];
            break;
        case WNXResultStateTypeGreat:
            [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundGreatName];
            break;
        case WNXResultStateTypePerfect:
            [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundPerfectName];
        case WNXResultStateTypeBad:
        {
            NSString *badName = [NSString stringWithFormat:@"instantFail0%d.mp3", arc4random_uniform(3) + 2];
            [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:badName];
        }
            break;
        default:
            break;
    }
    
    [self insertSubview:self.circleImageView belowSubview:self.stateImageView];
    [self.superview bringSubviewToFront:self];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
    });
}

- (void)showStateViewWithType:(WNXResultStateType)type stageViewHiddenFinishBlock:(void (^)(void))stageViewHiddenFinishBlock {
    self.type = type;
    self.hidden = NO;
    self.hiddenFinsih = stageViewHiddenFinishBlock;
    switch (type) {
        case WNXResultStateTypeOK:
            [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundOKName];
            break;
        case WNXResultStateTypeGood:
            [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundGoodName];
            break;
        case WNXResultStateTypeGreat:
            [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundGreatName];
            break;
        case WNXResultStateTypePerfect:
            [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundPerfectName];
            break;
        case WNXResultStateTypeBad:
        {
            NSString *badName = [NSString stringWithFormat:@"instantFail0%d.mp3", arc4random_uniform(3) + 2];
            [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:badName];
        }
            break;
        default:
            break;
    }
    
    [self insertSubview:self.circleImageView belowSubview:self.stateImageView];
    [self.superview bringSubviewToFront:self];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
        if (self.hiddenFinsih) {
            self.hiddenFinsih();
        }
    });
}

- (void)showBadStateWithFinish:(void (^)())finish {
    self.hidden = NO;
    self.stateImageView.layer.anchorPoint = CGPointMake(1, 0.5);
    self.stateImageView.frame = CGRectMake(self.stateImageView.frame.origin.x + self.stateImageView.frame.size.width * 0.5, self.stateImageView.frame.origin.y, self.stateImageView.frame.size.width, self.stateImageView.frame.size.height);
    
    self.showFinish = finish;
    
    NSString *badName = [NSString stringWithFormat:@"instantFail0%d.mp3", arc4random_uniform(3) + 2];
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:badName];
    
    self.stateImageView.image = [UIImage imageNamed:@"00_bad-iphone4"];
    self.circleImageView.image = [UIImage imageNamed:@"00_cross-iphone4"];
    
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.stateImageView.transform = CGAffineTransformMakeRotation(-M_2_PI);
    } completion:^(BOOL finished) {
        
        self.hidden = YES;
        if (self.showFinish) {
            self.showFinish();
        }
        
    }];
}

- (void)hideStateView {
    self.hidden = YES;
}

- (void)removeData {
    self.showFinish = nil;
    self.hiddenFinsih = nil;
    [self removeFromSuperview];
}

@end
