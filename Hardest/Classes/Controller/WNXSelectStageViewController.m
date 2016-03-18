//
//  WNXSelectStageViewController.m
//  Hardest
//
//  Created by sfbest on 16/2/26.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXSelectStageViewController.h"
#import "WNXStageListView.h"
#import "WNXPrepareViewController.h"

#define kPrepareIdentifier @"prepare"

@interface WNXSelectStageViewController ()

@property (nonatomic, strong) WNXStageListView *listView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation WNXSelectStageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundImageWihtImageName:@"select_bg"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!self.listView) {
        __weak __typeof(self) weakSelf = self;
        self.listView = [[WNXStageListView alloc] init];
        self.listView.didChangeScrollPage = ^(int page) {
            weakSelf.pageControl.currentPage = page;
        };
        
        self.listView.didSelectedStageView = ^(WNXStage *stage) {
            [weakSelf performSegueWithIdentifier:kPrepareIdentifier sender:stage];
        };
        
        [self.view insertSubview:self.listView atIndex:0];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kPrepareIdentifier]) {
        WNXPrepareViewController *prepaerVC = segue.destinationViewController;
        prepaerVC.stage = (WNXStage *)sender;
    }
}

@end
