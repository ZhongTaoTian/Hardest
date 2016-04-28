//
//  WNXStage11View.m
//  Hardest
//
//  Created by sfbest on 16/4/27.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage11View.h"
#import "WNXSubjectView.h"

@interface WNXStage11View ()
{
    BOOL _isFrist;
}

@property (strong, nonatomic) UIImageView *handIV;
@property (strong, nonatomic) WNXSubjectView *subjectView;
@property (assign, nonatomic) int result;

@end

@implementation WNXStage11View

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.handIV = [[UIImageView alloc] initWithFrame:CGRectMake(25, 338, 65, 87)];
        self.handIV.image = [UIImage imageNamed:@"13_hand-iphone4"];
        self.handIV.alpha = 0;
        [self addSubview:self.handIV];
        
        self.subjectView = [[WNXSubjectView alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth, 70)];
        [self addSubview:self.subjectView];
        
        _isFrist = YES;
    }
    
    return self;
}

- (void)showSubjectViewWithNums:(void (^)(int, int, int))nums {
    __weak typeof(self) weakSelf = self;
    if (_isFrist ) {
        [self.subjectView showSubjectViewNums:^(int index1, int index2, int index3, int result) {
            nums(index1, index2, index3);
            weakSelf.result = result;
        }];
        _isFrist = NO;
    } else {
        
    }
}

- (BOOL)guessResult:(int)result {
    [self.subjectView showResultWithResult:result];
    return result == self.result;
}

@end
