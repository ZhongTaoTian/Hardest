//
//  WNXResultScoreView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/3/15.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

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
    double _scroeUnit;
    double _currentScroe;
    BOOL _isAddScroe;
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
    
    [self.scroeLabel setTextStorkeWidth:5];
    [self.unitLabel setTextStorkeWidth:3];
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
    _isAddScroe = isAddScroe;
    
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
    
    if ([NSString stringWithFormat:stage.format, scroe].length == 3) {
        self.scroeLabel.font = [UIFont fontWithName:@"TransformersMovie" size:95];
    } else if ([NSString stringWithFormat:stage.format, scroe].length == 4) {
        self.scroeLabel.font = [UIFont fontWithName:@"TransformersMovie" size:80];
    } else if ([NSString stringWithFormat:stage.format, scroe].length >= 5) {
        self.scroeLabel.font = [UIFont fontWithName:@"TransformersMovie" size:75];
    }
        
    if (isAddScroe) {
        self.scroeLabel.text = @"0";
    } else {
        self.scroeLabel.text = @"0";
    }
    
    _scroeUnit = scroe / _moveX > 0 ? scroe / _moveX : -(scroe / _moveX);
}

- (void)upData:(CADisplayLink *)timer {
    _index++;
    _hintIVTransfrom = CGAffineTransformTranslate(_hintIVTransfrom, -1.5, 0);
    self.hintImageView.transform = _hintIVTransfrom;
    _currentScroe += _scroeUnit * 1.5;
    
    
    self.scroeLabel.transform = CGAffineTransformMakeTranslation(_hintIVTransfrom.tx * 0.2, 0);
    self.unitLabel.transform = CGAffineTransformMakeTranslation(_hintIVTransfrom.tx * 0.2, 0);
    
    if (_isAddScroe && _currentScroe >= _newScroe) {
        _currentScroe = _newScroe;
    }
    
    if (!_isAddScroe && _currentScroe <= _newScroe) {
        _currentScroe = _newScroe;
    }
    
    self.scroeLabel.text = [NSString stringWithFormat:_stage.format, _currentScroe];
    
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
    
    if ([_stageInfo.rank isEqual:@"s"]) {
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundSName];
    }
    
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundScroeNormalName];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.delegate resultScoreViewDidRemove];
    });
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
        if (_newScroe > lastStageInfo.score) {
            [[WNXStageInfoManager sharedStageInfoManager] saveStageInfo:_stageInfo];
        }
    } else {
        if (_newScroe < lastStageInfo.score) {
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
    NSString *passStr;
    
    if (_stage.max - _stage.min > 0) {
        passStr = [NSString stringWithFormat:@" > %@", [NSString stringWithFormat:_stage.format, _stage.min]];
    } else {
        passStr = [NSString stringWithFormat:@" < %@", [NSString stringWithFormat:_stage.format, _stage.min]];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.delegate resultScoreViewShowFailViewPassScroeStr:passStr userScroeStr:[NSString stringWithFormat:_stage.format, _newScroe]];
    });
}

@end
