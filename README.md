#iOS游戏开发没有你想的那么难--Hardest

##和大家聊聊天
有段日子没有发布过任何文字和代码了,之前的文章下很多网友留言也没有回复,其实每条评论我都有认真看.只是最近整个人有点迷茫,望大家理解.其实我很期盼大家和我聊聊天,但不要总是聊技术...

##关于项目(代码下载地址在文章最下面点击GitHub链接)
项目说明:考虑到许多不会使用Cocos2D-X和Swift的朋友，此次项目采用Objective-C并且基于UIKit框架实现的.意思就是你会使用UIView,就可以尝试开发游戏了,嘿嘿!

原生项目是采用Cocos2D-X开发的,所以在对图片的动画处理时,有些地方会没有原生显得那么流畅(如切割图片,对图片的变形处理,图片快速替换等),并且在性能上来说,UIKit也不如Cocos2D-X流畅,毕竟术业有专攻.如果是要开发游戏来上架的话,最好采用专门的游戏引擎来搭建项目(Cocos-2D,Unity3D,Sprite Kit等).

开发语言:`Objective-C`

开发工具:`Xcode7.1`

编译环境:`大于Xcode7.0`

辅助工具:`Photoshop CS6`

项目讲解: 把整个项目用文字带着大家过一遍有点不现实.这里我将项目的大体结构和一些主要逻辑,以及主要对象提供的接口功能下面列举出来.建议同学们先看代码,配合代码再来看这篇文章,顺着代码和文字搞懂项目主体逻辑.当需要学习具体功能如何实现时,在看`.m`文件下的实现代码学习如何实现功能,如果有哪些地方不清楚,在简书下面留言或者微博留言.

学习建议:最好使用真机来进行运行调试,有些关卡需要使用加速计与陀螺仪等功能,模拟器是没有的.当遇到实在无法过去的关卡时,点击首页的有些手柄按钮,点击解锁下一关或者在代码启动时,手动写入关卡得分信息即可.

![Hardest](http://ww4.sinaimg.cn/mw690/0068uRu1jw1f4wx92ccj9j30aj0ipgq8.jpg)

##主体架构
### 音效和背景音乐
音效和背景音乐采用了`AVFoundation`框架封装了一个`WNXSoundToolManager`的单利对象,背景音乐采用`AVAudioPlayer`,背景音效采用`AudioServicesPlaySystemSound`.

提供以下方法和属性供全局调用或修改,通过修改`bgMusicType`和`soundType`可以控制背景音乐和音效声音的大小,通过`playSoundWithSoundName:`方法根据音效名称设置播放不同的音效.
```
// 音效或背景音乐播放声音打大小枚举
typedef NS_ENUM(NSInteger, SoundPlayType) {
    SoundPlayTypeHight = 0,
    SoundPlayTypeMiddle,
    SoundPlayTypeLow,
    SoundPlayTypeMute
};

@interface WNXSoundToolManager : NSObject

// 背景音乐声音大小Type
@property (nonatomic, assign) SoundPlayType bgMusicType;
// 音效声音大小Type
@property (nonatomic, assign) SoundPlayType soundType;

// 暂停背景音乐
- (void)pauseBgMusic;
// 停止播放背景音乐
- (void)stopBgMusic;
// 重新播放背景音乐
- (void)playBgMusicWihtPlayAgain:(BOOL)playAgain;
// 播放音效:音效名称
- (void)playSoundWithSoundName:(NSString *)soundName;
// 设置背景音乐音量:音量大小0~1
- (void)setBackgroundMusicVolume:(float)volume;

// 获取SoundManager单利对象
+ (instancetype)sharedSoundToolManager;

@end
```

### 保存和读取玩家关卡记录(WNXStageInfoManager)
如何持久化存储玩家过关信息和每关的得分记录.本项目采用归档和解档的方案.
拿到`WNXStageInfoManager`的单例对象,通过调用Save和Read方法保存或读取关卡信息,当游戏关卡进入结算得分控制器后,判断新记录是否需要保存,如果需要调用保存接口.具体实现代码请参照`WNXStageInfoManager.m`文件
```
// 单例方法
+ (instancetype)sharedStageInfoManager;

// 保存关卡信息
- (BOOL)saveStageInfo:(WNXStageInfo *)stageInfo;
// 读取指定关卡编号的关卡信息
- (WNXStageInfo *)stageInfoWithNumber:(int)number;

// 这个接口是当游戏无法过关时,在RootViewController点击手柄按钮,解锁下一关卡使用(**秘籍~慎用**)
- (BOOL)unlockNextStage;
```

### 启动页动画
启动页动画是目前App比较常见的功能(顺丰优选,顺手付,顺丰海淘等都有).其实这里有一种假象,在AppDelegate的`didFinishLaunchingWithOptions()`方法中,添加一个与启动图片完全一样的AnimVC,将AnimVC设置为keyWindow的rootViewController,在AnimVC的`viewDidApper()`方法中执行动画,当动画完成后通过Block切换keyWindow的rootViewController为首页VC就OK了.
```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    [NSThread sleepForTimeInterval:1.0];
    
    [self setKeyWindow];
    
    return YES;
}

- (void)setKeyWindow {
    __weak typeof(self) weakSelf = self;

    WNXLaunchAnimationViewController *launchAnimationVC = [[WNXLaunchAnimationViewController alloc] init];
    launchAnimationVC.animationFinish = ^{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WNXBaseNavigationController *rootNav = (WNXBaseNavigationController *)[sb instantiateViewControllerWithIdentifier:@"RootNavigationController"];
        weakSelf.window.rootViewController = rootNav;
    };
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = launchAnimationVC;
    [self.window makeKeyAndVisible];
}
```
关于动画这里我就不讲什么了,有兴趣的朋友可以自己参考工程代码研究下.

![启动页动画](http://ww2.sinaimg.cn/mw690/0068uRu1jw1f4wx8obnmmg307u0dxb2b.gif)

### 首页(WNXRootViewController)
首页其实就是一张图片,通过判断当前设备屏幕尺寸,读取当前设备尺寸对应按钮的Plist文件,拿到首页6个按钮位置的Frame,在`touchesBegan()`方法中,通过`CGRectContainsPoint`方法判断当前点击位置时候在指定的Frame内,符合条件时做出对应 的操作,具体代码
```
// 加载当前设备对应首页按钮Frame
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

// 判断点击点是否在对应的Frame内
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
```

### 关卡选择控制器(WNXSelectStageViewController)
关卡选择控制器采用UIScrollView实现,在scrollView放入24个`WNXStageListView`(当然这里也可以自己创建缓存池复用,个人觉得没必要),每个`WNXStageListView`都有对应的一个关卡信息模型`stageModel`,模型属性从工程->Resources->Plist->stages.plist文件中读取,根据`model`里的成员变量,加载关卡对应的信息,如关卡图片,是否解锁,玩家历史得分以及Rank标记等.

每个`WNXStageListView`,根据ID设置不同的Tag,并且提供单击手势,在`stageView`的点击事件中.调用导航控制器,Push到`WNXPrepareViewController`控制器,并将选择关卡的stageModel作为参数传过去,`WNXPrepareViewController`做出相应的展示即可.
选择关卡效果如下图所示

![选择关卡效果图](http://ww3.sinaimg.cn/mw690/0068uRu1jw1f4wx95nud0g307u0dx1l2.gif)

### 关卡准备开始控制器(WNXPrepareViewController)
每个关卡开始游戏前,都会以动画的形式出现本关游戏名称,过关规则,以及历史得分等一系列功能.都是由这个控制器完成的.通过选择关卡时传入的`stageModel`,展示`model`内对应的数据,当用户点击`Play`按钮时,使用`WNXGameControllerViewManager`单例对象,根据传入的`stageModel`,返回对应的关卡ViewController,然后Push到返回的ViewController游戏关卡即可.

![准备开始控制器效果图](http://ww1.sinaimg.cn/mw690/0068uRu1jw1f4wx8zuea7g307u0dxhdw.gif)

### 关卡控制器
24关,每关都有很多重复的功能,这里我们按照不同关卡的属性抽取出几种公共的父类,每个关卡根据自己的需求选择继承相应的控制器,并且在`ViewDidLoad`函数中初始化每个关卡不同的属性,具体分类效果如下图所示

![逻辑图](http://ww2.sinaimg.cn/mw690/0068uRu1jw1f4wx91rcmjj30so0lhjwm.jpg)

####WNXBaseGameViewController --> UIViewController

WNXBaseGameViewController是所有关卡ViewController的基类控制器,提供每个游戏关卡的基本属性设置,并且每个关卡的初始化操作都封装在了这里,每个关卡只需要在自己的ViewDidLoad方法中调用`buildStageInfo()`函数,添加构建自己的UI即可,重写父类的方法,完成每关不同的操作.

公有属性

- `WNXGameGuideType guideType`每关第一次进入关卡,本关游戏手势提示样式
 - `WNXGameGuideTypeNone`无提示
 - `WNXGameGuideTypeOneFingerClick`单个手指头点击
 - `WNXGameGuideTypeReplaceClick`左右按钮交替点击
 - `WNXGameGuideTypeMultiPointClick`多个手指同时点击
 
![单个手指头点击效果](http://ww1.sinaimg.cn/mw690/0068uRu1jw1f4wx8i2msgg307u0dx7l1.gif)

![左右按钮交替点击效果](http://ww2.sinaimg.cn/mw690/0068uRu1jw1f4wx8jmfatg307u0dxayb.gif)

![多个手指同时点击效果样式](http://ww1.sinaimg.cn/mw690/0068uRu1jw1f4wx8itzmog307u0dx4qp.gif)
 
- `WNXStage *stage`每关关卡信息model(model详情)
 
- `WNXScoreboardType`每关计分板样式
 - `WNXScoreboardTypeNone`无计分板
 - `WNXScoreboardTypeCountPTS` ![WNXScoreboardTypeCountPTS]()
 - `WNXScoreboardTypeTimeMS` ![WNXScoreboardTypeTimeMS]()
 - `WNXScoreboardTypeSecondAndMS` ![WNXScoreboardTypeSecondAndMS]()

![WNXScoreboardTypeCountPTS计分板样式](http://ww1.sinaimg.cn/mw690/0068uRu1jw1f4wx90hrdtj308w03ojrp.jpg)

![WNXScoreboardTypeTimeMS计分板样式](http://ww2.sinaimg.cn/mw690/0068uRu1jw1f4wx90s1euj309t03l3yv.jpg)

![WNXScoreboardTypeSecondAndMS计分板样式](http://ww3.sinaimg.cn/mw690/0068uRu1jw1f4wx9149p4j307s03u0t4.jpg)

- `UIView *countScoreView`计分板(考虑有多种样式,使用了UIView,每个关卡在用的时候根据自己类型进行强制转换)

- `WNXStateView *stateView`关卡提示状态View 
- `UIButton *playAgainButton` 重新开始游戏按钮
- `UIButton *pauseButton`暂停按钮

公有方法
```
- (void)beginGame; // 开始游戏
- (void)endGame;   // 结束游戏
- (void)beginRedayGoView; // 开始显示RedayGo动画
- (void)readyGoAnimationFinish; // RedayGo动画显示结束
- (void)pauseGame;    // 暂停游戏
- (void)continueGame; // 继续游戏
- (void)playAgainGame; // 重新开始游戏
- (void)showGameFail; //  游戏失败(部分关卡有, 进入失败ViewController)

// 显示关卡游戏结果
- (void)showResultControllerWithNewScroe:(double)scroe // 玩家得分
                                    unit:(NSString *)unil  // 本关计分器显示单位
                                   stage:(WNXStage *)stage // 关卡信息
                              isAddScore:(BOOL)isAddScroe; // 是否是添加分数(这里偷了个懒,只做了添加动画,应该有分数增长加动画或者减少动画)

// 构建关卡信息
- (void)buildStageInfo;

// 将广告,重新开始,暂停按钮放到最上层
- (void)bringPauseAndPlayAgainToFront;

// 构建显示状态View
- (void)buildStageView;
```
####WNXRYBViewController --> WNXBaseGameViewController
WNXRYBViewController,继承至WNXBaseGameViewController,底部拥有三个按钮,并且默认有三条红黄蓝背景条(拥有高亮时图片),底部按钮默认Tag为0,1,2,游戏大部分关卡为这种样式

公有属性

```
@property (strong, nonatomic) UIImageView *redImageView;
@property (strong, nonatomic) UIImageView *yellowImageView;
@property (strong, nonatomic) UIImageView *blueImageView;

@property (strong, nonatomic) UIButton    *redButton;
@property (strong, nonatomic) UIButton    *yellowButton;
@property (strong, nonatomic) UIButton    *blueButton;

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSArray *buttonImageNames;
```
公有方法
```
- (void)setButtonsIsActivate:(BOOL)isActivate; // 设置全部按钮是否可以点击

- (void)setButtonImage:(UIImage *)image // 当底部按钮图片相同时,设置底部按钮图片
      contenEdgeInsets:(UIEdgeInsets)insets; // 图片的contenEdgeInsets

- (void)removeAllImageView; // 有写关卡不需要红黄蓝背景图片时,删除三个UIImageView

// 底部按钮Action
- (void)addButtonsActionWithTarget:(id)target 
                            action:(SEL)action
                  forControlEvents:(UIControlEvents)forControlEvents;

```

####WNXTwoButtonViewController --> WNXBaseGameViewController
WNXTwoButtonViewController,底部拥有俩个按钮关卡,并且默认带有背景ImageView.

公有属性
```
@property (nonatomic, strong) UIImageView *backgroundIV;

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

```

公有方法
```
// 统一设置按钮是否可以被点击,部分关卡按钮点击后,不允许再次点击
- (void)setButtonActivate:(BOOL)isActivate;
```

####WNXBackgroundViewController --> WNXBaseGameViewController
只带有背景图关卡,项目中有些关卡是采用陀螺仪和加速计的关卡.


关于每一关如何实现,我这里就不一一列举了,有点太多了,但是都并不复杂,写个2~3关基本就能掌握套路了,就个别关卡使用了加速计和陀螺仪,具体实现的代码我都在工程中写的很明白了,在Stage文件夹下,大家自行参考即可.


### 分数结算控制器(WNXResultViewController)
当每个关卡游戏结束后,都会进入分数结算控制器,这里通过在`WNXBaseGameViewController`中封装了一个方法以保证每个关卡控制器都可以直接调用计算得分,当关卡游戏结束后,调用当前关卡的下面函数即可,这里小熊偷了个懒,只实现了相加的功能,不过相信通过参考相加的功能,大家实现相减的功能也是小csae啦~
```
- (void)showResultControllerWithNewScroe:(double)scroe
                                    unit:(NSString *)unil
                                   stage:(WNXStage *)stage
                              isAddScore:(BOOL)isAddScroe;
```
说明下`isAddScore`的作用
- 有些关卡是得分越高越好.这总关卡在显示结果的时候分数是从0一点点网上加的,这种情况isAddScore传入YES

- 有些关卡是得分越少越好,这总卡在显示结果的时候分数是从大网小一点点减少的,这种情况isAddScore传入NO

当结算分数完成后,会出现以下几种情况,跟据不同的得分情况执行不同的逻辑即可,具体逻辑如下所示
####状态一: 游戏失败(当得分小于等于F,不保存得分),出现下图
![得分不够,显示失败](http://ww4.sinaimg.cn/mw690/0068uRu1jw1f4wx8m2glbg307u0dxhdw.gif) 
####状态二: 游戏成功
 - 当前关卡无得分记录,并且得分大于F,保存玩家得分,正常显示得分结果,并且解锁下一关.
  
 ![成功状态1](http://ww4.sinaimg.cn/mw690/0068uRu1jw1f4x0t937k1g307u0dxqva.gif)

 - 当前关卡有记录,但是本次游戏得分没有超越历史记录,正常显示得分结果,不保存本次游戏得分.
  
  ![成功状态2](http://ww1.sinaimg.cn/mw690/0068uRu1jw1f4wx8taxk5g307u0dxqv8.gif)

 - 当前关卡有记录,并且本次游戏得分超越历史记录,显示超越历史得分动画,并且讲本次得分替换掉上一次得分.
  
  ![成功状态3](http://ww3.sinaimg.cn/mw690/0068uRu1jw1f4x0oj1dbfg307u0dxb2c.gif) 



### 失败(WNXFailViewController)
部分关卡会有在游戏中失败的情况,如下图

![游戏失败](http://ww4.sinaimg.cn/mw690/0068uRu1jw1f4wx8qjpf7g307u0dxnpf.gif) 

这里也是在`WNXBaseGameViewController`中封装了一个方法,当关卡失败后,直接调用`showGameFail()`方法,Push到失败控制器即可.

如果需要失败时执行一些操作,如停止计时,停止动画等,在当前关卡重写`showGameFail()`方法,在调用父类方法前调用需要执行的相应代码即可,如下
```
- (void)showGameFail {
    // 需要在游戏失败时执行的相应代码
    // do something
    
    [super showGameFail];
}
```

### 暂停控制器(WNXPauseViewController)
每个游戏关卡都有暂停的功能,所以将暂停的功能封装到`WNXBaseGameViewController`中,并且提供两个接口供子控制器调用,分别为
 - (void)pauseGame; 暂停游戏
 - (void)continueGame; 继续游戏

在每个游戏关卡重写上面两个方法,当玩家点击暂停按钮时,回调用暂停方法,点击返回时,会调用继续方法,具体实现如下

```
// 玩家点击暂停按钮
- (void)pauseGame {
    // 关卡暂停,本关需要执行的相应操作,如暂停计时器,动画等.

    [super pauseGame];
}

- (void)continueGame {
    [super continueGame];
    
    // 继续游戏,继续执行暂停前的操作
}

```

![暂停控制器效果图](http://ww4.sinaimg.cn/mw690/0068uRu1jw1f4wx8xiesbg307u0dxqv6.gif)

### 项目总结
项目写的比较匆忙,基本每天晚上抽空写点,写完也没有回头CodeReview,说实话,这是一个非常非常不好的习惯,大家一定要养成定期回头看看自己写过代码的习惯.随着越网后写,发现前面有很多地方可以修改,我吧有点懒,So你懂的...

感觉光靠文字来讲述一个项目实在是太困难.希望大家还是参考工程代码,当遇到无法看懂或者不理解的时候参考下我写的Blog应该会更好一些.这个游戏项目说实话还是比较简单的,相信大家仔细研究下都可以实现的.游戏还有24关,有兴趣的同学可以尝试自己将剩下的24关自己实现下~

有段日子没使用OC写项目了,如果有任何建议可在简书留言,或者私信,或者在微博留言都可以,我都会看的.

这个项目完事后,可能会很长一段时间,不再写这种大型的开源项目了,因为我个人准备开发一款游戏上架到AppStore,从设计到UI设计以及需求实现都是我一人完成,工作量比较大.PS(现在连做什么都不知道呢...).

以后我会分享一些有意思的小功能,小动画等给大家.希望朋友继续关注维尼的小熊.


### 代码下载地址(如果觉得有帮助,请点击Star★)
[代码下载地址,记得Star★和Follow](https://github.com/ZhongTaoTian)
#### 小熊的技术博客

[点击链接我的博客,欢迎关注](http://www.jianshu.com/users/5fe7513c7a57/latest_articles)

### 小熊的新浪微博
[我的新浪微博,欢迎关注](http://weibo.com/5622363113/profile?topnav=1&wvr=6)

#### 本文为作者原著,转载请注明作者出处,仅供学习交流,严禁用于商业用途


