//
//  WNXPokerView.m
//  Hardest
//
//  Created by sfbest on 16/5/17.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXPokerView.h"
#import "UIColor+WNXColor.h"

#define kTextRedColor [UIColor colorWithR:222 g:58 b:61]

@interface WNXPokerView ()

@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@property (weak, nonatomic) IBOutlet UIImageView *middleIV;

@end

@implementation WNXPokerView

- (void)awakeFromNib {
    self.bottomLabel.transform = CGAffineTransformMakeRotation(M_PI);
}

- (void)setPokerWithType:(WNXPokerType)type number:(int)number {
    if (type == WNXPokerTypeHearts || type == WNXPokerTypeDiamonds) {
        self.topLabel.textColor = kTextRedColor;
        self.bottomLabel.textColor = kTextRedColor;
    } else {
        self.topLabel.textColor = [UIColor blackColor];
        self.bottomLabel.textColor = [UIColor blackColor];
    }
    
    if (type == WNXPokerTypeHearts) {
        self.middleIV.image = [UIImage imageNamed:@"20_Rheart-iphone4"];
    } else if (type == WNXPokerTypeDiamonds) {
        self.middleIV.image = [UIImage imageNamed:@"20_diamond-iphone4"];
    } else if (type == WNXPokerTypeSpade) {
        self.middleIV.image = [UIImage imageNamed:@"20_Bheart-iphone4"];
    } else {
        self.middleIV.image = [UIImage imageNamed:@"20_Bflower-iphone4"];
    }
    
    int isFlip = arc4random_uniform(2);
    if (isFlip == 1) {
        self.middleIV.transform = CGAffineTransformMakeRotation(M_PI);
    } else {
        self.middleIV.transform = CGAffineTransformIdentity;
    }
    
    self.topLabel.text = [NSString stringWithFormat:@"%d", number];
    self.bottomLabel.text = [NSString stringWithFormat:@"%d", number];
}

@end
