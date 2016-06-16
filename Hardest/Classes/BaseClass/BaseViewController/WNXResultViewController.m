//
//  WNXResultViewController.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/9.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXResultViewController.h"
#import "WNXResultScoreView.h"
#import "WNXStageInfo.h"
#import "WNXHighScroeTextView.h"
#import "WNXPrepareViewController.h"
#import "WNXStageInfoManager.h"
#import "WNXSelectStageViewController.h"

@interface WNXResultViewController () <WNXResultScoreViewDelegate>
{
    BOOL _notFrist;
    double _scroeNew;
    NSString *_unit;
    WNXStage *_stage;
    BOOL _isAddScroe;
    BOOL _hasNewCount;
}

@property (weak, nonatomic) IBOutlet UIImageView *animationIV;
@property (weak, nonatomic) IBOutlet UIImageView *scroeImageView;
@property (weak, nonatomic) IBOutlet WNXResultScoreView *scroeView;
@property (weak, nonatomic) IBOutlet UIImageView *blurBackIV;
@property (nonatomic, strong) WNXHighScroeTextView *highScroeView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fialViewTopConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *failShadowView;
@property (weak, nonatomic) IBOutlet UILabel *userScroeLabel;
@property (weak, nonatomic) IBOutlet UILabel *passLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cageImageView;
@property (weak, nonatomic) IBOutlet UIView *failBackgrounView;
@property (weak, nonatomic) IBOutlet UILabel *countScroeLabel;
@property (weak, nonatomic) IBOutlet UIButton *reBtn;

@end

@implementation WNXResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundImageWihtImageName:@"rank_bg"];
    self.scroeView.delegate = self;
    
    self.highScroeView = [[WNXHighScroeTextView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(self.scroeImageView.frame) - 100, ScreenWidth, 200)];
    [self.view insertSubview:self.highScroeView belowSubview:self.scroeImageView];
    
    self.scroeImageView.layer.anchorPoint = CGPointMake(0.5, 1);
    self.reBtn.hidden = YES;
    self.cageImageView.transform = CGAffineTransformMakeTranslation(0, -ScreenHeight);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!_notFrist) {
        _notFrist = YES;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.countScroeLabel.hidden = YES;
            [self.countScroeLabel removeFromSuperview];
            self.scroeView.hidden = NO;
            self.scroeImageView.hidden = NO;
            [self.scroeView startCountScoreWithNewScroe:_scroeNew unit:_unit stage:_stage isAddScore:_isAddScroe];
        });
    }
}

- (IBAction)btnClick:(UIButton *)sender {
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundCliclName];
    if (sender.tag == 20) {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[WNXPrepareViewController class]]) {
                _stage.userInfo = [[WNXStageInfoManager sharedStageInfoManager] stageInfoWithNumber:_stage.num];
                ((WNXPrepareViewController *)vc).stage = _stage;
                [self.navigationController popToViewController:vc animated:NO];
                
                [self removeNewCountView];
                
                return;
            }
        }
        
    } else if (sender.tag == 21) {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[WNXSelectStageViewController class]]) {
                [self.navigationController popToViewController:vc animated:NO];
                
                [self removeNewCountView];
                
                return;
            }
        }
    }
}

- (void)dealloc {
    NSLog(@"被销毁了");
}

- (void)setCountScoreWithNewScroe:(double)scroe unit:(NSString *)unit stage:(WNXStage *)stage isAddScore:(BOOL)isAddScroe {
    _scroeNew = scroe;
    _unit = unit;
    _stage = stage;
    _isAddScroe = isAddScroe;
}

- (void)shakeAnimation {
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.08 initialSpringVelocity:8 options:UIViewAnimationOptionCurveLinear animations:^{
        self.scroeView.transform = CGAffineTransformTranslate(self.scroeView.transform, 0, -10);
        self.scroeImageView.transform = CGAffineTransformMakeTranslation(0, -10);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)removeNewCountView {
    if (!_hasNewCount) {
        return;
    }

    [self.highScroeView hideHighScroeTextView];
    [self.animationIV stopAnimating];
    self.animationIV = nil;
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
    _hasNewCount = YES;
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

- (void)resultScoreViewShowFailViewPassScroeStr:(NSString *)passScroe userScroeStr:(NSString *)userScroe {
    [self.view setBackgroundImageWihtImageName:@"fail_bg"];
    self.failShadowView.hidden = NO;
    self.userScroeLabel.text = [NSString stringWithFormat:@"你的分数: %@ %@", userScroe, _stage.unit];
    self.passLabel.text = [NSString stringWithFormat:@"闯关分数: %@ %@", passScroe, _stage.unit];
    
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundFailDropName];
    
    [UIView animateWithDuration:0.2 delay:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.fialViewTopConstraint.constant = ScreenHeight - 90 - 150 - self.scroeImageView.frame.size.height + 10;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundFailScreamName];
        [self pressScroeImageView];
    }];
}

- (void)pressScroeImageView {
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.fialViewTopConstraint.constant = ScreenHeight - 90 - 150;
        [self.view layoutIfNeeded];
        
        self.scroeImageView.transform = CGAffineTransformMakeScale(2, 0.01);
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UIView *grayBG = [[UIView alloc] initWithFrame:ScreenBounds];
            grayBG.backgroundColor = [UIColor blackColor];
            grayBG.alpha = 0.3;
            [self.view insertSubview:grayBG belowSubview:self.failBackgrounView];
            
            self.scroeImageView.hidden = YES;
            [self.scroeView removeFromSuperview];
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.cageImageView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                self.failBackgrounView.hidden = NO;
                [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundcageDropName];
            }];
        });
    }];
}

@end
