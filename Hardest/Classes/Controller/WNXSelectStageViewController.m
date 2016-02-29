//
//  WNXSelectStageViewController.m
//  Hardest
//
//  Created by sfbest on 16/2/26.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXSelectStageViewController.h"
#import "WNXStageListView.h"

@interface WNXSelectStageViewController ()

@property (nonatomic, strong) WNXStageListView *listView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;


@end

@implementation WNXSelectStageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundImageWihtImageName:@"select_bg"];
    
    [self.view insertSubview:self.listView atIndex:0];

}

- (WNXStageListView *)listView {
    if (!_listView) {
        __weak __typeof(self) weakSelf = self;
        _listView = [[WNXStageListView alloc] init];
        _listView.didChangeScrollPage = ^(int page){
            weakSelf.pageControl.currentPage = page;
        };
    }

    return _listView;
}



@end
