//
//  WNXStage19FishView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/5/19.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage19FishView.h"
#import "WNXFishView.h"

@interface WNXStage19FishView ()

@property (nonatomic, strong) WNXFishView *fishView1;
@property (nonatomic, strong) WNXFishView *fishView2;
@property (nonatomic, strong) WNXFishView *fishView3;

@property (nonatomic, strong) UIImageView *goodsIV;

@end

@implementation WNXStage19FishView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        
        self.fishView1 = [WNXFishView viewFromNib];
        [self addSubview:self.fishView1];
        
        self.fishView2 = [WNXFishView viewFromNib];
        self.fishView2.frame = CGRectMake(ScreenWidth / 3, 0, ScreenWidth / 3, frame.size.height);
        [self addSubview:self.fishView2];
        
        self.fishView3 = [WNXFishView viewFromNib];
        self.fishView3.frame = CGRectMake(ScreenWidth / 3 * 2, 0, ScreenWidth / 3, frame.size.height);
        [self addSubview:self.fishView3];
        
        self.goodsIV = [UIImageView new];
        [self addSubview:self.goodsIV];
    }
    
    return self;
}

- (void)showFishBite:(NSInteger)index {
    if (index == 0) {
        [self.fishView1 startFishBite];
    } else if (index == 1) {
        [self.fishView2 startFishBite];
    } else {
        [self.fishView3 startFishBite];
    }
}

- (void)showPromptViewWithIndex:(NSInteger)index {
    if (index == 0) {
        [self.fishView1 showBlackView];
    } else if (index == 1) {
        [self.fishView2 showBlackView];
    } else {
        [self.fishView3 showBlackView];
    }
}

- (void)showSucessWithIndex:(NSInteger)index finish:(void (^)())finish {
    
    if (index == 0) {
        [self.fishView1 showSucess];
    } else if (index == 1) {
        [self.fishView2 showSucess];
    } else {
        [self.fishView3 showSucess];
    }
    
    int imageIndex = arc4random_uniform(3) + 1;
    if (imageIndex == 1) {
        self.goodsIV.frame = CGRectMake(kCountStartX(150), 160, 150, 180);
    } else if (imageIndex == 2) {
        self.goodsIV.frame = CGRectMake(kCountStartX(150), 160, 150, 111);
    } else {
        self.goodsIV.frame = CGRectMake(kCountStartX(150), 160, 150, 135);
    }
    
    self.goodsIV.transform = CGAffineTransformMakeScale(0, 0);
    self.goodsIV.hidden = NO;
    self.goodsIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"06_success0%d-iphone4", imageIndex]];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.goodsIV.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundCatchFishName];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.goodsIV.hidden = YES;
            
            if (finish) {
                finish();
            }
            
            if (index == 0) {
                [self.fishView1 resumeData];
            } else if (index == 1) {
                [self.fishView2 resumeData];
            } else {
                [self.fishView3 resumeData];
            }
        });

    }];
}

- (void)pause {
    [self.fishView1 pause];
    [self.fishView2 pause];
    [self.fishView3 pause];
}

- (void)resume {
    [self.fishView1 resume];
    [self.fishView2 resume];
    [self.fishView3 resume];
}

- (void)removeData {
    [self removeTimer];
    
    [self.fishView1 removeFromSuperview];
    [self.fishView2 removeFromSuperview];
    [self.fishView3 removeFromSuperview];
    
    self.fishView1 = nil;
    self.fishView2 = nil;
    self.fishView3 = nil;
}

- (void)removeTimer {
    [self.fishView1 killTimer];
    [self.fishView2 killTimer];
    [self.fishView3 killTimer];
}

@end
