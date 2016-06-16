//
//  WNXStage11View.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/4/27.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStage11View.h"
#import "WNXSubjectView.h"

@interface WNXStage11View ()
{
    BOOL _isFrist;
    int _count;
}


@property (strong, nonatomic) WNXSubjectView *subjectView;
@property (assign, nonatomic) int result;

@end

@implementation WNXStage11View

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.subjectView = [[WNXSubjectView alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth, 70)];
        [self addSubview:self.subjectView];
        
        _isFrist = YES;
    }
    
    return self;
}

- (void)showSubjectViewWithNums:(void (^)(int, int, int))nums {
    __weak typeof(self) weakSelf = self;
    _count++;
    if (_count == 17) {
        self.passState();
        return;
    }
    
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundWriteName];
    if (_isFrist ) {
        [self.subjectView showSubjectViewNums:^(int index1, int index2, int index3, int result) {
            nums(index1, index2, index3);
            weakSelf.result = result;
        }];
        _isFrist = NO;
    } else {
        [self.subjectView showNextSubjectViewNums:^(int index1, int index2, int index3, int result) {
            nums(index1, index2, index3);
            weakSelf.result = result;
        }];
    }
}

- (void)setSubjectPlayAgain {
    self.subjectView.isPlayAgain = NO;
}

- (void)showHandViewAnimationFinish:(void (^)(void))finish {
    [self.subjectView showHandViewWithAnimationFinish:^{
        finish();
    }];
}

- (void)guessResult:(int)result {
    __weak typeof(self) weakSelf = self;
    [self.subjectView showResultWithResult:result finish:^{
        weakSelf.handViewShowAnimation(weakSelf.result == result);
    }];
}

- (void)cleanData {
    _isFrist = YES;
    _count = 0;
    [self.subjectView cleanData];
}

@end
