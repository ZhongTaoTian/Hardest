//
//  WNXPrepareViewController.m
//  Hardest
//
//  Created by sfbest on 16/3/1.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXPrepareViewController.h"
#import "WNXPrepareScoreView.h"

@interface WNXPrepareViewController ()

@property (weak, nonatomic) IBOutlet WNXPrepareScoreView *scoreView;
@property (weak, nonatomic) IBOutlet WNXFullBackgroundView *animationView;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *number1Label;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;

@end

@implementation WNXPrepareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.animationView setBackgroundImageWihtImageName:@"select_bg"];
    if (self.stage) {
        [self initStage];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self startTitleAnimation];
}


- (void)initStage {
    self.scoreView.stage = self.stage;
    self.number1Label.text = [NSString stringWithFormat:@"%d", self.stage.num];
    self.numberLabel.text = self.number1Label.text;
    self.iconImageView.image = [UIImage imageNamed:self.stage.icon];
    self.describeLabel.text = self.stage.intro;

    NSArray *array = [self.stage.title componentsSeparatedByString:@"\\n"];

    for (int i = 0; i < array.count; i++) {
        UILabel *label = self.labels[i];
        label.text = array[i];
    }
}

- (void)startTitleAnimation {
    double allTime = 0;
    for (int i = 0; i < self.labels.count; i++) {
        UILabel *titleLabel = self.labels[i];
        
        allTime += (i + 1) * 0.3;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((i + 1) * 0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
            scale.fromValue = @0;
            titleLabel.hidden = NO;
            scale.toValue = @1;
            
            CAKeyframeAnimation *translation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
            translation.values = @[@0, @40, @(-20)];
            
            CAAnimationGroup *group = [CAAnimationGroup animation];
            group.duration = 0.3;
            group.animations = @[scale, translation];
            
            [titleLabel.layer addAnimation:group forKey:nil];
            
            [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundPrepaerTitle(i+1)];
        });
            
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( (allTime + 1) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.animationView removeFromSuperview];
            
            [self showPlayView];
        });
    }

}

- (void)showPlayView {

}

- (IBAction)playGameClick {
    
}

@end
