//
//  WNXStage15RowView.h
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/13.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import <UIKit/UIKit.h>

@interface WNXStage15RowView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *leftWoodIV;
@property (weak, nonatomic) IBOutlet UIImageView *rightWoodIV;
@property (weak, nonatomic) IBOutlet UIImageView *middleWoodIV;

- (void)showRowWithIsShowWave:(BOOL)showWave showFinish:(BOOL)finsih isFrist:(BOOL)isFrist;

- (void)startWoodAnimation;

@end
