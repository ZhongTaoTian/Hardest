//
//  WNXStage12EggView.m
//  Hardest
//
//  Created by MacBook on 16/5/2.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage12EggView.h"
#import "WNXDropEggView.h"

@interface WNXStage12EggView ()
{
    int _count;
}

@property (nonatomic, strong) WNXDropEggView *egg1;
@property (nonatomic, strong) WNXDropEggView *egg2;
@property (nonatomic, strong) WNXDropEggView *egg3;

@end

@implementation WNXStage12EggView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.egg1 = [[WNXDropEggView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth / 3, ScreenHeight - 200)];
        [self buildEggView:self.egg1 tag:0];
        
        self.egg2 = [[WNXDropEggView alloc] initWithFrame:CGRectMake(ScreenWidth / 3, 0, ScreenWidth / 3, ScreenHeight - 200)];
        [self buildEggView:self.egg2 tag:1];
        
        self.egg3 = [[WNXDropEggView alloc] initWithFrame:CGRectMake(ScreenWidth / 3 * 2, 0, ScreenWidth / 3, ScreenHeight - 200)];
        [self buildEggView:self.egg3 tag:2];
    }
    
    return self;
}

- (void)showEgg {
    [self.egg1 showDropEggWithSpeed:3];
    [self.egg2 showDropEggWithSpeed:4];
    [self.egg3 showDropEggWithSpeed:5];
}

- (void)stopEggDropWithIndex:(int)index {

}

- (void)buildEggView:(WNXDropEggView *)eggView tag:(NSInteger)tag {
     __weak typeof(self) weakSelf = self;
    eggView.tag = tag;
    [self addSubview:eggView];
    eggView.failBlock = ^(NSInteger index){
        weakSelf.failBlock(index);
    };
}

- (void)failWithIndex:(NSInteger)index {
    if (index == 0) {
        self.egg1.hidden = YES;
    } else if (index == 1) {
        self.egg2.hidden = YES;
    } else {
        self.egg3.hidden = YES;
    }
    
    [self.egg1 stopDropEgg];
    [self.egg2 stopDropEgg];
    [self.egg3 stopDropEgg];
}

- (NSInteger)grabWithIndex:(NSInteger)index {
    NSInteger scroe;
    if (index == 0) {
        scroe = [self.egg1 grabEgg];
    } else if (index == 1) {
        scroe = [self.egg2 grabEgg];
    } else {
        scroe = [self.egg3 grabEgg];
    }
    
    return scroe;
}

@end
