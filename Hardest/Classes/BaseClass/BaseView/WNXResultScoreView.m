//
//  WNXResultScoreView.m
//  Hardest
//
//  Created by sfbest on 16/3/15.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXResultScoreView.h"
#import "WNXStage.h"
#import "WNXStageInfo.h"
#import "WNXStageInfoManager.h"

#define BtnWidth 38

@interface WNXResultScoreView ()
{
    CGAffineTransform _boadrIVTransfrom;
    CGAffineTransform _hintIVTransfrom;
    int _index;
    CGFloat _moveX;
    BOOL _isChange;
    double _newScroe;
    WNXStage *_stage;
    WNXStageInfo *_stageInfo;
}

@end

@implementation WNXResultScoreView

- (void)awakeFromNib {
    _stageInfo = [[WNXStageInfo alloc] init];
    for (int i = 0; i < 7; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i + 10;
        btn.userInteractionEnabled = NO;
        btn.frame = CGRectMake(i * 45 - i * 7 + 55, 50, 45, 52);
        [btn setBackgroundImage:[UIImage imageNamed:@"other_score"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%c", [@"SABCDEF" characterAtIndex:i]] forState:UIControlStateNormal];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 6, 7);
        [btn cleanSawtooth];
        [self insertSubview:btn belowSubview:self.hintImageView];
    }
    
    _boadrIVTransfrom = CGAffineTransformMakeTranslation(8 * (45 - 7), 0);
    self.boardImageView.transform = _boadrIVTransfrom;
    [self.boardImageView cleanSawtooth];
    
    _hintIVTransfrom = CGAffineTransformMakeTranslation(0, 0);
    
    self.transform = CGAffineTransformMakeRotation(M_PI_4/6);
    
}

- (void)startCountScoreWithNewScroe:(double)scroe unit:(NSString *)unit stage:(WNXStage *)stage isAddScore:(BOOL)isAddScroe {
    double scorePerBtn = (stage.max - stage.min) / 5;
    double widthPerScore = BtnWidth / scorePerBtn;
    double delta = (scroe - stage.min) * widthPerScore;
    _newScroe = scroe;
    _stage = stage;
    _stageInfo.num = stage.num;
    _stageInfo.unlock = YES;
    _stageInfo.score = scroe;
    
    if (delta > 0) {
        delta = -delta;
    }
    
    _moveX = delta - 45;
    
    if (_moveX > -45) {
        _moveX = -45;
    }
    
    if (_moveX <= -45 - 5 * BtnWidth) {
        _moveX = -45 - 5 * BtnWidth;
    }
    
    if (scroe != stage.min) {
        _moveX -= 2;
    }
    
    if (stage.max - stage.min > 0) {
        if (scroe < stage.min) {
            _moveX = -45;
        }
    } else {
        if (scroe > stage.min) {
            _moveX = -45;
        }
    }
    
    [[CADisplayLink displayLinkWithTarget:self selector:@selector(upData:)] addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    self.unitLabel.text = unit;
    self.scroeLabel.text = [NSString stringWithFormat:stage.unit, scroe];
}

- (void)upData:(CADisplayLink *)timer {
    _index++;
    _hintIVTransfrom = CGAffineTransformTranslate(_hintIVTransfrom, -1.5, 0);
    self.hintImageView.transform = _hintIVTransfrom;
    
    if (_hintIVTransfrom.tx < 0 && !_isChange && _hintIVTransfrom.tx >= -45) {
        _isChange = YES;
        [self.delegate resultScoreViewChangeWithRank:@"f"];
        _stageInfo.rank = @"f";
        [self setButtonBackgroundImageWithTag:16];
    }
    
    if (_hintIVTransfrom.tx < -45 && _hintIVTransfrom.tx > -45 - BtnWidth && _isChange) {
        [self.delegate resultScoreViewChangeWithRank:@"e"];
        _isChange = NO;
        _stageInfo.rank = @"e";
        [self setButtonBackgroundImageWithTag:15];
    }
    
    if (_hintIVTransfrom.tx < -45 - BtnWidth && _hintIVTransfrom.tx >= -45 - 2 * BtnWidth && !_isChange) {
        [self.delegate resultScoreViewChangeWithRank:@"d"];
        _isChange = YES;
        _stageInfo.rank = @"d";
        [self setButtonBackgroundImageWithTag:14];
    }
    
    if (_hintIVTransfrom.tx < -45 - 2 * BtnWidth && _hintIVTransfrom.tx >= -45 - 3 * BtnWidth && _isChange) {
        _isChange = NO;
        _stageInfo.rank = @"c";
        [self.delegate resultScoreViewChangeWithRank:@"c"];
        [self setButtonBackgroundImageWithTag:13];
    }
    
    if (_hintIVTransfrom.tx < -45 - 3 * BtnWidth && _hintIVTransfrom.tx >= -45 - 4 * BtnWidth && !_isChange) {
        _isChange = YES;
        [self.delegate resultScoreViewChangeWithRank:@"b"];
        _stageInfo.rank = @"b";
        [self setButtonBackgroundImageWithTag:12];
    }
    
    if (_hintIVTransfrom.tx < -45 - 4 * BtnWidth && _hintIVTransfrom.tx >= -45 - 5 * BtnWidth && _isChange) {
        _isChange = NO;
        [self.delegate resultScoreViewChangeWithRank:@"a"];
        _stageInfo.rank = @"a";
        [self setButtonBackgroundImageWithTag:11];
    }
    
    if (_hintIVTransfrom.tx < -45 - 5 * BtnWidth && _hintIVTransfrom.tx >= -45 - 6 * BtnWidth && !_isChange) {
        _isChange = YES;
        [self.delegate resultScoreViewChangeWithRank:@"s"];
        [self setButtonBackgroundImageWithTag:10];
        _stageInfo.rank = @"s";
    }
    
    if (_hintIVTransfrom.tx <= _moveX) {
        [timer invalidate];
        timer = nil;
        
        [self showResult];
    }
}

- (void)setButtonBackgroundImageWithTag:(int)tag {
    UIButton *btn = (UIButton *)[self viewWithTag:tag];
    [btn setBackgroundImage:[UIImage imageNamed:@"cureent_score"] forState:UIControlStateNormal];
}

- (void)showResult {
    if (_moveX == -45) {
        [self saveStageUserInfo];
        // 失败
        [self showFail];
        
        return;
    }
    
    if ([self isNewCount]) {
        // 新纪录
        [self showNewCount];
        
        return;
    }
    
    [self saveStageUserInfo];
    [self.delegate resultScoreViewDidRemove];
}

- (BOOL)isNewCount {
    if (_stage.max - _stage.min > 0) {
        if (_newScroe > [[WNXStageInfoManager sharedStageInfoManager] stageInfoWithNumber:_stageInfo.num].score) {
            return YES;
        }
    } else {
        if (_newScroe < [[WNXStageInfoManager sharedStageInfoManager] stageInfoWithNumber:_stageInfo.num].score) {
            return YES;
        }
    }
    
    return NO;
}

- (void)saveStageUserInfo {
    WNXStageInfo *lastStageInfo = [[WNXStageInfoManager sharedStageInfoManager] stageInfoWithNumber:_stageInfo.num];
    if (!lastStageInfo || !lastStageInfo.rank || lastStageInfo.score == 0) {
        [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:_stageInfo];
        return;
    }
    
    if (_stage.max - _stage.min > 0) {
        if (_newScroe > _stage.userInfo.score) {
            [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:_stageInfo];
        }
    } else {
        if (_newScroe < _stage.userInfo.score) {
            [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:_stageInfo];
        }
    }
}

- (void)showNewCount {
    [self.delegate resultScoreViewShowNewCount];
    for (int i = 0; i < 7; i++) {
        UIView *btn = [self viewWithTag:10 + i];
        [btn removeFromSuperview];
    }
    
    [self.hintImageView removeFromSuperview];
    
    [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:_stageInfo];
}

- (void)showFail {
    [self.delegate resultScoreViewShowFailView];
}

@end
