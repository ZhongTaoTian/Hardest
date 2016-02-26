//
//  UIView+WXNImage.m
//  Hardest
//
//  Created by sfbest on 16/2/25.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "UIView+WNXImage.h"

@implementation UIView (WXNImage)

- (void)setBackgroundImageWihtImageName:(NSString *)imageName {

}

+ (instancetype)viewFromNib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}

@end
