//
//  RootViewController.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/2/23.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXRootViewController.h"

@interface WNXRootViewController ()
{
    CGRect _settingFrame;
    CGRect _languageFrame;
    CGRect _moreFrame;
    CGRect _rankFrame;
    CGRect _playFrame;
    CGRect _getFrame;
    BOOL _isNotFristLoad;
}

@end

@implementation WNXRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundImageWihtImageName:@"home_bg.jpg"];
    
    [self loadHomeButtonFrame];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!_isNotFristLoad) {
        [[WNXSoundToolManager sharedSoundToolManager] playBgMusicWihtPlayAgain:YES];
    }
    
    _isNotFristLoad = YES;
}

- (void)loadHomeButtonFrame {
    NSString *framePath = [[NSBundle mainBundle] pathForResource:@"home.plist" ofType:nil];
    NSDictionary *frameDic = [NSDictionary dictionaryWithContentsOfFile:framePath];
    
    NSDictionary *dict;
    
    if (iPhone5) {
        dict = frameDic[@"iphone5"];
    } else {
        dict = frameDic[@"iphone4"];
    }
    
    _settingFrame = CGRectFromString(dict[@"btn_setting_frame"]);
    _languageFrame = CGRectFromString(dict[@"btn_language_frame"]);
    _moreFrame = CGRectFromString(dict[@"btn_more_frame"]);
    _rankFrame = CGRectFromString(dict[@"btn_rank_frame"]);
    _playFrame = CGRectFromString(dict[@"btn_play_frame"]);
    _getFrame = CGRectFromString(dict[@"btn_get_frame"]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:touch.view];
    
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName: kSoundCliclName];
    
    if (CGRectContainsPoint(_settingFrame, touchPoint)) {
        
        [self performSegueWithIdentifier:@"Setting" sender:nil];
        
    } else if (CGRectContainsPoint(_languageFrame, touchPoint)) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kBlogURL]];
        
    } else if (CGRectContainsPoint(_moreFrame, touchPoint)) {
        
        [self performSegueWithIdentifier:@"Rare" sender:nil];
        
    } else if (CGRectContainsPoint(_rankFrame, touchPoint)) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kWeiBoURL]];
        
    } else if (CGRectContainsPoint(_playFrame, touchPoint)) {
        
        [self performSegueWithIdentifier:@"PlayGame" sender:nil];
        
    } else if (CGRectContainsPoint(_getFrame, touchPoint)) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kGithubUrl]];
        
    }
}

@end
