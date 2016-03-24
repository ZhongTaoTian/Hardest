//
//  WNXFailViewController.h
//  Hardest
//
//  Created by sfbest on 16/3/24.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXFailViewController : UIViewController

@property (nonatomic, strong) WNXStage *stage;

+ (instancetype)initWithStage:(WNXStage *)stage retryButtonClickBlock:(void(^)())retryButtonClickBlock;

@end
