//
//  WNXStage16PeopleView.m
//  Hardest
//
//  Created by MacBook on 16/5/15.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage16PeopleView.h"

@interface WNXStage16PeopleView ()

@property (weak, nonatomic) IBOutlet UIImageView *upIV;
@property (weak, nonatomic) IBOutlet UIImageView *downIV;


@end

@implementation WNXStage16PeopleView

- (void)ullUpsWithIndex:(NSInteger)index {
    if (index == 1) {
        self.upIV.hidden = YES;
        self.downIV.hidden = NO;
    } else {
        self.upIV.hidden = NO;
        self.downIV.hidden = YES;
    }
}

@end
