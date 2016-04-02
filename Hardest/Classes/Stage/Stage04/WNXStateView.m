//
//  WNXStateView.m
//  Hardest
//
//  Created by MacBook on 16/4/1.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStateView.h"

@interface WNXStateView ()
@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;
@property (weak, nonatomic) IBOutlet UIImageView *circleImageView;

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
            break;
        case WNXResultStateTypeGreat:
            self.stateImageView.image = [UIImage imageNamed:@"00_great-iphone4"];
            break;
        case WNXResultStateTypeOK:
            self.stateImageView.image = [UIImage imageNamed:@"00_okay-iphone4"];
            break;
        case WNXResultStateTypePerfect:
            self.stateImageView.image = [UIImage imageNamed:@"00_perfect-iphone4"];
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

- (void)hideStateView {
    self.hidden = YES;
}

@end
