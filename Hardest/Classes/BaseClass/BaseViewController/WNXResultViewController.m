//
//  WNXResultViewController.m
//  Hardest
//
//  Created by sfbest on 16/3/9.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXResultViewController.h"
#import "WNXResultScoreView.h"
#import "WNXStageInfo.h"
#import "WNXHighScroeTextView.h"

@interface WNXResultViewController () <WNXResultScoreViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *animationIV;
@property (weak, nonatomic) IBOutlet UIImageView *scroeImageView;
@property (weak, nonatomic) IBOutlet WNXResultScoreView *scroeView;
@property (weak, nonatomic) IBOutlet UIImageView *blurBackIV;
@property (nonatomic, strong) WNXHighScroeTextView *highScroeView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fialViewTopConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *failShadowView;


@end

@implementation WNXResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundImageWihtImageName:@"rank_bg"];
    self.scroeView.delegate = self;
    
    self.highScroeView = [[WNXHighScroeTextView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(self.scroeImageView.frame) - 100, ScreenWidth, 200)];
    [self.view insertSubview:self.highScroeView belowSubview:self.scroeImageView];
    
    self.scroeImageView.layer.anchorPoint = CGPointMake(0.5, 1);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self setCountScoreWithNewScroe:0 unit:nil stage:nil isAddScore:NO];
}

- (IBAction)btnClick:(UIButton *)sender {
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundCliclName];
    if (sender.tag == 20) {
        //在来一次
    } else if (sender.tag == 21) {
        // home
    } else if (sender.tag == 22) {
        // 回到选择关卡
    }
}

- (void)setCountScoreWithNewScroe:(double)scroe unit:(NSString *)unit stage:(WNXStage *)stage isAddScore:(BOOL)isAddScroe {
    WNXStage *sss = [[WNXStage alloc] init];
    sss.max = 25;
    sss.min = 20;
    sss.num = 1;
    sss.unit = @"%.f";
    
    sss.userInfo.num = 1;
    sss.userInfo.unlock = NO;
    sss.userInfo.rank = nil;
    [self.scroeView startCountScoreWithNewScroe:19 unit:@"PTS" stage:sss isAddScore:YES];
}

- (void)shakeAnimation {
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.08 initialSpringVelocity:8 options:UIViewAnimationOptionCurveLinear animations:^{
        self.scroeView.transform = CGAffineTransformTranslate(self.scroeView.transform, 0, -10);
        self.scroeImageView.transform = CGAffineTransformMakeTranslation(0, -10);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark WNXResultScoreViewDelegate
- (void)resultScoreViewChangeWithRank:(NSString *)rank {
    self.scroeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"score_%@", rank]];
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:[NSString stringWithFormat:@"scoreGrade_%@.mp3", rank]];
}

- (void)resultScoreViewDidRemove {
    [self showBottomView];
}

- (void)resultScoreViewShowNewCount {
    [self.highScroeView showHighScroeTextView];
    
    self.animationIV.animationImages = @[[UIImage imageNamed:@"scene_light01"],
                                         [UIImage imageNamed:@"scene_light02"],
                                         [UIImage imageNamed:@"scene_light03"]];
    self.animationIV.animationRepeatCount = -1;
    self.animationIV.animationDuration = 0.5;
    
    UIImageView *recordIV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 390, 130)];
    recordIV.transform = CGAffineTransformMakeScale(4, 4);
    recordIV.image = [UIImage imageNamed:@"new_record"];
    [self.scroeView insertSubview:recordIV belowSubview:self.scroeImageView];
    
    UIImageView *recordBlurIV = [[UIImageView alloc] initWithFrame:CGRectMake(-10, -40, 450, 300)];
    recordBlurIV.image = [UIImage imageNamed:@"scene_new"];
    recordBlurIV.hidden = YES;
    [self.scroeView insertSubview:recordBlurIV belowSubview:recordIV];
    
    UIImageView *bordeIV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 390, 130)];
    bordeIV.image = [UIImage imageNamed:@"Result_Scene_light01-iphone4"];
    bordeIV.hidden = YES;
    [self.scroeView insertSubview:bordeIV belowSubview:recordBlurIV];
    
    UIImageView *bordeIV2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 390, 130)];;
    bordeIV2.image = bordeIV.image;
    bordeIV2.hidden = YES;
    [self.scroeView insertSubview:bordeIV2 belowSubview:bordeIV];
    
    [UIView animateWithDuration:0.3 animations:^{
        recordIV.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self shakeAnimation];
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundNewRecordName1];
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundNewRecordName2];
        self.blurBackIV.hidden = NO;
        recordBlurIV.hidden = NO;
        self.animationIV.hidden = NO;
        [self.animationIV startAnimating];
        
        bordeIV.hidden = NO;
        bordeIV2.hidden = NO;

        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            bordeIV.transform = CGAffineTransformMakeScale(1.4, 1.4);
        } completion:^(BOOL finished) {
            [bordeIV removeFromSuperview];
        }];

        
        [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
            bordeIV2.transform = CGAffineTransformMakeScale(1.4, 1.4);
        } completion:^(BOOL finished) {
            [bordeIV2 removeFromSuperview];
        }];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showBottomView];
    });
}

- (void)showBottomView {
    [UIView animateWithDuration:0.4 animations:^{
        self.bottomViewConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

- (void)resultScoreViewShowFailView {
    [self.view setBackgroundImageWihtImageName:@"fail_bg"];
    self.failShadowView.hidden = NO;
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.fialViewTopConstraint.constant = ScreenHeight - 90 - 150 - self.scroeImageView.frame.size.height + 10;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self pressScroeImageView];
    }];
}

- (void)pressScroeImageView {
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.fialViewTopConstraint.constant = ScreenHeight - 90 - 150;
        [self.view layoutIfNeeded];
        
        self.scroeImageView.transform = CGAffineTransformMakeScale(2, 0.01);
    } completion:^(BOOL finished) {
        self.scroeImageView.hidden = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.scroeView removeFromSuperview];

        });
    }];
}

@end
