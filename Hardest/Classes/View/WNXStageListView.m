//
//  WNXStageListView.m
//  Hardest
//
//  Created by sfbest on 16/2/26.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStageListView.h"

@implementation WNXStageListView

- (instancetype)init{
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
        
    }

    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (self.didChangeScrollPage) {
        int page = (scrollView.contentOffset.x / ScreenWidth + 0.5);
        if (page < 0) page = 0;
        if (page > 3) page = 3;
        self.didChangeScrollPage(page);
    }
}

@end
