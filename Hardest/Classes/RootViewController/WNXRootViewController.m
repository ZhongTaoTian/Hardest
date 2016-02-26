//
//  RootViewController.m
//  Hardest
//
//  Created by sfbest on 16/2/23.
//  Copyright © 2016年 sfbest. All rights reserved.
//

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
    
    if (CGRectContainsPoint(_settingFrame, touchPoint)) {
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName: kSoundCliclName];
        
        [self performSegueWithIdentifier:@"Setting" sender:nil];
        
    } else if (CGRectContainsPoint(_languageFrame, touchPoint)) {
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName: kSoundCliclName];
    } else if (CGRectContainsPoint(_moreFrame, touchPoint)) {
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName: kSoundCliclName];
    } else if (CGRectContainsPoint(_rankFrame, touchPoint)) {
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName: kSoundCliclName];
    } else if (CGRectContainsPoint(_playFrame, touchPoint)) {
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName: kSoundCliclName];
       
        [self performSegueWithIdentifier:@"PlayGame" sender:nil];
        
    } else if (CGRectContainsPoint(_getFrame, touchPoint)) {
        [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName: kSoundCliclName];
    }
    
}

@end
