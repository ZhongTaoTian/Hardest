//
//  WNXStage15RowView.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/13.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXStage15RowView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *leftWoodIV;
@property (weak, nonatomic) IBOutlet UIImageView *rightWoodIV;
@property (weak, nonatomic) IBOutlet UIImageView *middleWoodIV;

- (void)showRowWithIsShowWave:(BOOL)showWave showFinish:(BOOL)finsih isFrist:(BOOL)isFrist;

- (void)startWoodAnimation;

@end
