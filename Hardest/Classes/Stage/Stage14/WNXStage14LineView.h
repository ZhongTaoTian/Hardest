//
//  WNXStage14LineView.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/10.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXStage14LineView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *arrowIV;

- (void)startShakePhoneAnimationWithFinish:(void (^)())finish;

- (void)resumeData;

- (void)arrowPromptWithAngle:(float)angle;

@end
