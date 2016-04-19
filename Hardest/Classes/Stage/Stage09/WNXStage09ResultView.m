//
//  WNXStage09ResultView.m
//  Hardest
//
//  Created by MacBook on 16/4/19.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage09ResultView.h"
#import "WNXStrokeLabel.h"

@interface WNXStage09ResultView ()
@property (weak, nonatomic) IBOutlet UIImageView *stageImageView;
@property (weak, nonatomic) IBOutlet WNXStrokeLabel *timeLabel;

@end

@implementation WNXStage09ResultView

- (void)awakeFromNib {
    [self.timeLabel setTextStorkeWidth:3];
    self.timeLabel.font = [UIFont fontWithName:@"TransformersMovie" size:25];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.hidden = YES;
    self.backgroundColor = [UIColor clearColor];
}

- (void)showResultViewWithTime:(NSTimeInterval)time {
    self.hidden = NO;
    if (time <= 0.2) {
        self.stageImageView.image = [UIImage imageNamed:@"00_perfect-iphone4"];
    } else if (time <= 0.4) {
        self.stageImageView.image = [UIImage imageNamed:@"00_great-iphone4"];
    } else {
        self.stageImageView.image = [UIImage imageNamed:@"00_okay-iphone4"];
    }
    
    self.timeLabel.text = [NSString stringWithFormat:@"%.2f", time];
}

@end
