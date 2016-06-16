//
//  WNXStageListView.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/2/26.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXStageListView.h"
#import "WNXStage.h"
#import "WNXStageView.h"
#import "WNXStageInfoManager.h"

@implementation WNXStageListView

- (instancetype)init {
    if (self = [super initWithFrame:ScreenBounds]) {
        self.contentSize = CGSizeMake(ScreenWidth * 4, ScreenHeight);
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.delegate = self;
        
        NSArray *bgNames = @[@"select_easy_bg", @"select_normal_bg", @"select_hard_bg", @"select_insane_bg"];
        for (int i = 0; i < 4; i++) {
            WNXFullBackgroundView *listView = [[WNXFullBackgroundView alloc] initWithFrame:CGRectMake(i * ScreenWidth, 0, ScreenWidth, ScreenHeight)];
            [listView setBackgroundImageWihtImageName:bgNames[i]];
            [self addSubview:listView];
        }
        
        [self loadStageInfo];
    }

    return self;
}

- (void)reloadStageForNumber:(int)num {
    WNXStageView *stageView = (WNXStageView *)[self viewWithTag:100 + num - 1];
    WNXStage *newStage = stageView.stage;
    stageView.stage.userInfo = [[WNXStageInfoManager sharedStageInfoManager] stageInfoWithNumber:num];
    stageView.stage = newStage;
}

- (void)loadStageInfo {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"stages.plist" ofType:nil];
    NSArray *stageArr = [NSArray arrayWithContentsOfFile:path];
    
    CGFloat stageViewW = 120;
    CGFloat stageViewH = 100;
    CGFloat viewMaxgin = ScreenWidth - stageViewW * 2 - 25 * 2;
    CGFloat topMagin = iPhone5 ? 130 : 80;
    WNXStageInfoManager *manager = [WNXStageInfoManager sharedStageInfoManager];
    
    for (int i = 0; i < stageArr.count; i++) {
        WNXStage *stage = [WNXStage stageWithDict:stageArr[i]];
        stage.num = i + 1;
        stage.userInfo = [manager stageInfoWithNumber:i + 1];

        CGFloat scrollX = ((int)(i / 6)) * ScreenWidth;
        CGFloat startX = 25 + ((i % 6) / 3) * (stageViewW + viewMaxgin) + scrollX;
        CGFloat startY = topMagin + (i % 3) * (stageViewH + 30);
        
        WNXStageView *stageView = [WNXStageView stageViewWithStage:stage frame:CGRectMake(startX, startY, stageViewW, stageViewH)];
        stageView.tag = 100 + i;
        [self insertSubview:stageView atIndex:5];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stageViewDidSelected:)];
        [stageView addGestureRecognizer:tap];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (self.didChangeScrollPage) {
        int page = (scrollView.contentOffset.x / ScreenWidth + 0.5);
        if (page < 0) page = 0;
        if (page > 3) page = 3;
        self.didChangeScrollPage(page);
    }
}

- (void)stageViewDidSelected:(UITapGestureRecognizer *)tap {
    if (self.didSelectedStageView) {
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundSelectedStage];
        self.didSelectedStageView(((WNXStageView *)tap.view).stage);
    }
}

@end
