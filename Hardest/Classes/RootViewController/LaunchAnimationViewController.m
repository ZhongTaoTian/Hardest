//
//  LaunchAnimationViewController.m
//  Hardest
//
//  Created by sfbest on 16/2/23.
//  Copyright © 2016年 sfbest. All rights reserved.
//

#import "LaunchAnimationViewController.h"

#define kMaxHandClickCount 10

@interface LaunchAnimationViewController ()
{
    int _clickCount;
}

@property (weak, nonatomic) IBOutlet UIImageView *handImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bombButtonImageView;
@property (weak, nonatomic) IBOutlet UIImageView *buttonImageView;
@property (weak, nonatomic) IBOutlet UIView *eyeMaskView;
@property (weak, nonatomic) IBOutlet UIImageView *blackIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *normalIconImageView;

@end

@implementation LaunchAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    self.blackIconImageView.hidden = YES;
    self.bombButtonImageView.hidden = YES;
    self.eyeMaskView.hidden = YES;
    
    for (int i = 0; i < kMaxHandClickCount; i++) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:i * 0.1 target:self selector:@selector(handButtonImageViewClickAnimation) userInfo:nil repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}

- (void)handButtonImageViewClickAnimation {
    
    _clickCount++;
    
    [UIView animateWithDuration:0.05 animations:^{
        self.handImageView.transform = CGAffineTransformMakeTranslation(0, 20);
    } completion:^(BOOL finished) {
        self.buttonImageView.image = [UIImage imageNamed:@"play_01-iphone4"];
        [UIView animateWithDuration:0.05 animations:^{
            self.handImageView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            self.buttonImageView.image = [UIImage imageNamed:@"play_00-iphone4"];
            
            if (_clickCount == kMaxHandClickCount - 1) {
                
            }
        }];
    }];
    
 
}

@end
