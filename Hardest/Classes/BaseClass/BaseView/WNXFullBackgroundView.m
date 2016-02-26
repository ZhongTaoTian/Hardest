//
//  WXNFullBackgroundView.m
//  Hardest
//
//  Created by sfbest on 16/2/25.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXFullBackgroundView.h"
#import "UIView+WNXImage.h"

@implementation WNXFullBackgroundView
{
    NSString *_bgImageName;
}

- (void)setBackgroundImageWihtImageName:(NSString *)imageName {
    
    _bgImageName = imageName;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    if (_bgImageName) {
        UIImage *bgImage = [UIImage imageNamed:_bgImageName];
        
        // 2.裁剪图片
        CGFloat width = 640;
        CGFloat height = iPhone5?1136:960;
        CGRect cutRect = CGRectMake((bgImage.size.width - width)*0.5, (bgImage.size.height - height)*0.5, width, height);
        CGImageRef imageRef = CGImageCreateWithImageInRect(bgImage.CGImage, cutRect);
        bgImage = [UIImage imageWithCGImage:imageRef];
        
        // 3.绘图
        [bgImage drawInRect:rect];
    }

}

@end
