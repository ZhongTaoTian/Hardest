//
//  WNXBaseGameViewController.h
//  Hardest
//
//  Created by sfbest on 16/3/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WNXGameGuideType) {
    WNXGameGuideTypeNone = 0,
    WNXGameGuideTypeOneFingerClick,
    WNXGameGuideTypeReplaceClick,
    WNXGameGuideTypeMultiPointClick
};

@interface WNXBaseGameViewController : UIViewController

@property (nonatomic, assign) WNXGameGuideType guideType;
@property (nonatomic, strong) WNXStage *stage;

@end
