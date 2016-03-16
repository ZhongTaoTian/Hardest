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

@interface WNXResultViewController () <WNXResultScoreViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *animationIV;
@property (weak, nonatomic) IBOutlet WNXFullBackgroundView *blurBackView;
@property (weak, nonatomic) IBOutlet UIButton *againBtn;
@property (weak, nonatomic) IBOutlet UIButton *homeBtn;
@property (weak, nonatomic) IBOutlet UIButton *againBtn2;
@property (weak, nonatomic) IBOutlet UIImageView *scroeImageView;
@property (weak, nonatomic) IBOutlet WNXResultScoreView *scroeView;


@end

@implementation WNXResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundImageWihtImageName:@"rank_bg"];
    [self.blurBackView setBackgroundImageWihtImageName:@"scene_bg"];
    
    self.scroeView.delegate = self;
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
    [self.scroeView startCountScoreWithNewScroe:85 unit:@"PTS" stage:sss isAddScore:YES];
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
    NSLog(@"没有失败.没有新纪录");
}

- (void)resultScoreViewShowNewCount {
    NSLog(@"显示新纪录");
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
    
    [UIView animateWithDuration:0.3 animations:^{
        recordIV.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self shakeAnimation];
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundNewRecordName1];
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundNewRecordName2];
        self.blurBackView.hidden = NO;
        recordBlurIV.hidden = NO;
        self.animationIV.hidden = NO;
        [self.animationIV startAnimating];
    }];
}

- (void)resultScoreViewShowFailView {
    NSLog(@"游戏失败");
}

@end
