//
//  WNXEggImageView.m
//  Hardest
//
//  Created by MacBook on 16/5/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXEggImageView.h"

@interface WNXEggImageView ()

@property (nonatomic, strong) UIImageView *eggIV;

@end

@implementation WNXEggImageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.eggIV = [[UIImageView alloc] initWithFrame:frame];
    }
    
    return self;
}

@end
