//
//  WNXResultScoreView.m
//  Hardest
//
//  Created by sfbest on 16/3/15.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXResultScoreView.h"
#import "WNXStage.h"

@interface WNXResultScoreView ()
{
    CGAffineTransform _boadrIVTransfrom;
    CGAffineTransform _hintIVTransfrom;
}

@property (nonatomic, strong) NSMutableArray *scroeBtns;
@property (nonatomic, weak) IBOutlet UIImageView *hintImageView;
@property (nonatomic, weak) IBOutlet UIImageView *boardImageView;
@property (nonatomic, weak) IBOutlet UIButton    *playAgainBtn;
@property (nonatomic, weak) IBOutlet UIButton    *homeBtn;
@property (nonatomic, weak) IBOutlet UILabel     *scroeLabel;
@property (nonatomic, weak) IBOutlet UILabel     *unitLabel;
@property (nonatomic, weak) IBOutlet UIView      *labelView;

@end

@implementation WNXResultScoreView

- (void)awakeFromNib {
    self.scroeBtns = [NSMutableArray array];
    
    for (int i = 0; i < 7; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i + 10;
        btn.userInteractionEnabled = NO;
        btn.frame = CGRectMake(i * 45 - i * 7 + 55, 50, 45, 52);
        [btn setBackgroundImage:[UIImage imageNamed:@"other_score"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%c", [@"SABCDEF" characterAtIndex:i]] forState:UIControlStateNormal];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 6, 7);
        [btn cleanSawtooth];
        [self insertSubview:btn belowSubview:self.hintImageView];
    }

    _boadrIVTransfrom = CGAffineTransformMakeTranslation(8 * (45 - 7), 0);
    self.boardImageView.transform = _boadrIVTransfrom;
    [self.boardImageView cleanSawtooth];
    
    self.transform = CGAffineTransformMakeRotation(M_PI_4/6);
    
    [[self playAgainBtn] addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick:(UIButton *)sender {
    if (sender.tag == 20) {
        
    } else if (sender.tag == 21) {
    
    }
}

- (void)startCountScoreWithNewScroe:(double)scroe unit:(NSString *)unit stage:(WNXStage *)stage isAddScore:(BOOL)isAddScroe {
    /*
     1.计算指示器最终要停留的x
     */
    // 1.1.计算每个积分卡占据多少分数
    double scorePerBtn = (stage.max - stage.min) / 5;
    
    // 1.2.计算每分占据多少宽度
    double widthPerScore = 38 / scorePerBtn;
    
    // 1.3.算出跟F的x的宽度差距
    double delta = (scroe - stage.min) * widthPerScore;
    
    if (delta > 0) {
        delta = -delta;
    }
    
    [[CADisplayLink displayLinkWithTarget:self selector:@selector(upData:)] addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    self.unitLabel.text = unit;
    self.scroeLabel.text = [NSString stringWithFormat:stage.unit, scroe];
}

- (void)upData:(CADisplayLink *)timer {


}

@end
