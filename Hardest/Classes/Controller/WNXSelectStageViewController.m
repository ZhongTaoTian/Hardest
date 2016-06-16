//
//  WNXSelectStageViewController.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/2/26.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXSelectStageViewController.h"
#import "WNXStageListView.h"
#import "WNXPrepareViewController.h"

#define kPrepareIdentifier @"prepare"

@interface WNXSelectStageViewController ()
{
    BOOL _hasNewData;
    int _newNum;
    BOOL _hasNewCount;
    int _newCount;
}

@property (nonatomic, strong) WNXStageListView *listView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger page;

@end

@implementation WNXSelectStageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundImageWihtImageName:@"select_bg"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newStageDidUnLock:) name:@"NewStageDidUnLock" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newCount:) name:@"NewCount" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (!self.listView) {
        __weak __typeof(self) weakSelf = self;
        self.listView = [[WNXStageListView alloc] init];
        
        self.listView.didChangeScrollPage = ^(int page) {
            weakSelf.pageControl.currentPage = page;
            weakSelf.page = page;
        };
        
        self.listView.didSelectedStageView = ^(WNXStage *stage) {
            [weakSelf performSegueWithIdentifier:kPrepareIdentifier sender:stage];
        };
        
        [self.view insertSubview:self.listView atIndex:0];
        
        self.page = [[[NSUserDefaults standardUserDefaults] objectForKey:@"lastPage"] integerValue];
        [self.listView setContentOffset:CGPointMake(ScreenWidth * self.page, 0) animated:NO];
    }
    
    if (_hasNewData) {
        
        if ((_newNum - 1) / 6 == self.page) {
            [self.listView reloadStageForNumber:_newNum];
            _hasNewData = NO;
        }
    }
    
    if (_hasNewCount) {
        [self.listView reloadStageForNumber:_newCount - 1];
        _hasNewCount = NO;
    }
}

- (void)setPage:(NSInteger)page {
    if (_hasNewData) {
        
        if (_page == page - 1 && _hasNewData) {
            [self.listView reloadStageForNumber:_newNum];
            _hasNewData = NO;
        }
    }
    
    _page = page;
    
    [[NSUserDefaults standardUserDefaults] setObject:@(page) forKey:@"lastPage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kPrepareIdentifier]) {
        WNXPrepareViewController *prepaerVC = segue.destinationViewController;
        prepaerVC.stage = (WNXStage *)sender;
    }
}

- (void)newCount:(NSNotification *)noti {
    _hasNewCount = YES;
    _newCount = [noti.object intValue];
}

- (void)newStageDidUnLock:(NSNotification *)noti {
    _hasNewData = YES;
    _newNum = [noti.object intValue];
}

@end
