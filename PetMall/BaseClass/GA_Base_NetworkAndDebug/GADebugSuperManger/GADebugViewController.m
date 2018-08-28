//
//  GADebugViewController.m
//  GADebugManger
//
//  Created by 王光辉 on 15/11/7.
//  Copyright © 2015年 WGH. All rights reserved.
//
#ifdef DEBUG

#define K_DebugView_UI_Screen_W  [[UIScreen mainScreen] bounds].size.width
#define K_DebugView_UI_Screen_H  [[UIScreen mainScreen] bounds].size.height
#define puGongYingBuildInfo @"puGongYingBuildInfo"
#import "GADebugViewController.h"
#import "GADebugActionView.h"
#import "GADebugServerView.h"
#import "GADebugUILineView.h"
#import "GADebugCrashView.h"
#import "GADebugNetworkView.h"
#import "GADebugPerformanceView.h"
#import "GADebugUserDefaultView.h"
#import "GALostFramesView.h"
#import "GADebugAdsView.h"
#define ABNOTIFIERX_SWITCH 1
#import "ABNotifier.h"
#import "GADeviceUtil.h"
#import "GAURLProtocol.h" // 网络监控
@interface GADebugViewController ()<UITableViewDataSource,UITableViewDelegate,ABNotifierDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *actionTableView;
@property (nonatomic, strong) NSArray *actions;
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIView *debugView;
@property (nonatomic, strong) NSDictionary *puGongYingdic;
@end

@implementation GADebugViewController

#pragma mark - 单例
static GADebugViewController *instance_;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [[GADebugViewController alloc] init];
        instance_.view.frame = CGRectMake(0, 0, K_DebugView_UI_Screen_W, 25);
        //注册protocol
        [GAURLProtocol registerClass:[GAURLProtocol class]];
#if DEBUG
        [instance_ ABNotifierCreash]; // 开启debug
#endif
        
    });
    return instance_;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [super allocWithZone:zone];
    });
    return instance_;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化
    [self initialization];
    
    self.view.backgroundColor = [UIColor clearColor];
    UISwipeGestureRecognizer *recognizer1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromRight:)];
    [recognizer1 setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:recognizer1];
    
    UISwipeGestureRecognizer *recognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromLeft:)];
    [recognizer2 setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:recognizer2];
}
- (BOOL)prefersStatusBarHidden
{
    return NO;
}
#pragma mark - 初始化
- (void)initialization
{
    // 数据源
    self.actions = @[@"服务",@"UI测试",@"崩溃",@"网络",@"内存",@"UD",@"丢帧",@"内存泄露",@"更新"];
    // 功能区
    self.actionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.debugView.frame), CGRectGetHeight(self.debugView.frame) - 50)];
    self.actionTableView.delegate = self;
    self.actionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.actionTableView.dataSource = self;
    self.actionTableView.rowHeight = 50;
    self.actionTableView.backgroundColor = [UIColor clearColor];
    [self.debugView addSubview:self.actionTableView];
    
    // 收起按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"收起" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, CGRectGetHeight(self.debugView.frame) - 40, CGRectGetWidth(self.debugView.frame), 40);
    [self.debugView addSubview:btn];
    btn.backgroundColor = [UIColor clearColor];
}
- (void) btnClick:(id)sender{
    [self letDebugViewHidden:YES];
}

- (void) handleSwipeFromRight:(UIGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:recognizer.view];
    if (point.y < 20) {
        [self letDebugViewHidden:NO];
    }
}

- (void) handleSwipeFromLeft:(UIGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:recognizer.view];
    if (point.y < 20) {
        [self letDebugViewHidden:YES];
    }
}

- (void)letDebugViewHidden:(BOOL)letHidden
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.debugView];
    if (letHidden) {
        [UIView animateWithDuration:0.3 animations:^{
            self.debugView.frame = CGRectMake(K_DebugView_UI_Screen_W, 80, self.debugView.frame.size.width, K_DebugView_UI_Screen_H - 80 * 2);
        }];
        [self.actionTableView reloadData];
    }else
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.debugView.frame = CGRectMake(K_DebugView_UI_Screen_W - self.debugView.frame.size.width, 80, self.debugView.frame.size.width, K_DebugView_UI_Screen_H - 80 * 2);
        }];
    }
}

- (UIView *)debugView
{
    if (_debugView == nil) {
        _debugView = [[UIView alloc] initWithFrame:CGRectMake(K_DebugView_UI_Screen_W, 80, 60, K_DebugView_UI_Screen_H - 80 * 2)];
        _debugView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    }
    return _debugView;
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.actions.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"DebugActionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundView = [[UIView alloc] init];
        cell.textLabel.numberOfLines = 2;
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = [self.actions objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GADebugActionView *actionView = nil;
    
    switch (indexPath.row) {
        case 0:{
            // 服务器
            actionView = [[GADebugServerView alloc] initWithFrame:CGRectZero];
        }
            break;
        case 1:{
            // UI线
            actionView = [[GADebugUILineView alloc] initWithFrame:CGRectZero];
        }
            break;
        case 2:{
            // Crash
            actionView = [[GADebugCrashView alloc] initWithFrame:CGRectZero];
        }
            break;
        case 3:{
            // 网络请求
            actionView = [[GADebugNetworkView alloc] initWithFrame:CGRectZero];
        }
            break;
        case 4:{
            // 内存
            actionView = [[GADebugPerformanceView alloc] initWithFrame:CGRectZero];
        }
            break;
        case 5:{
            // UserDefault
            actionView = [[GADebugUserDefaultView alloc] initWithFrame:CGRectZero];
        }
            break;
        case 6:{
            // 丢帧测试
            actionView = [[GALostFramesView alloc] initWithFrame:CGRectZero];
        }
            break;
        case 7:{
            // 内存泄露
            actionView = [[GADebugAdsView alloc] initWithFrame:CGRectZero];
        }
            break;
        case 8:{
            [self requestPuGongYing];
        }
            break;
        default:
            break;
    }
    
    if (actionView == nil) {
        actionView = [[GADebugActionView alloc] initWithFrame:CGRectZero];
    }
    if (indexPath.row == 8) {
        return; // 更新
    }
    [actionView showOverWindow];
}
#pragma mark - 蒲公英
- (void)requestPuGongYing
{
    // 1.设置请求路径
    NSURL *URL=[NSURL URLWithString:@"http://www.pgyer.com/apiv1/app/getAppKeyByShortcut"];
    //   2.创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    //设置请求体 划分为3个App，
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];    //获取项目名称
    if ([appName hasPrefix:@"SnailS"]) {
        // 蜗牛检测
        appName = @"wUsv";
    }else if([appName hasPrefix:@"SnailT"]) {
        // 蜗牛货车
        appName = @"Gsai";
    }else if([appName hasPrefix:@"OM"]) {
        // 商用二手车  欧曼  ShanQi
        appName = @"OMan";
    }else if([appName hasPrefix:@"ShanQi"]) {
        // 商用二手车  陕汽
        appName = @"ShanQi";
    }
    NSString *param = [NSString stringWithFormat:@"shortcut=%@&_api_key=%@",appName,@"e901990998041ccc27ee706cab2fccdb"];
    request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
    //异步链接 - ios9之前版本
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data.length > 0) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([dic[@"code"] integerValue] == 0) {
                self.puGongYingdic = dic;
                NSString *tipStr = [NSString stringWithFormat:@"%@测试版本创建时间:%@     测试版本号:%@      包大小:%.2fM",dic[@"data"][@"appName"],dic[@"data"][@"appCreated"],dic[@"data"][@"appBuildVersion"],[dic[@"data"][@"appFileSize"] doubleValue]/ (1024*1024)];
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:tipStr preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
                    //点击后触发的事件
                }];
                UIAlertAction *updataAction = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                    //点击后触发的事件
                    [self alertViewUpdata];
                }];
                [alertController addAction:cancelAction];
                [alertController addAction:updataAction];
                [[self current_Controller] presentViewController:alertController animated:YES completion:^{
                    
                }];
                //                UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:tipStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
                //                [alterView show];
            }else
                [self errorTips:@"服务方服务器出错"];
        }else
            [self errorTips:@"网络错误，请检查网络"];
    }];
}
#pragma mark - 获取根控制器
- (UIViewController*)top_Controller{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    //  Getting topMost ViewController
    while ([topController presentedViewController])topController = [topController presentedViewController];
    //  Returning topMost ViewController
    return topController;
}
- (UIViewController*)current_Controller;{
    UIViewController *currentViewController = [self top_Controller];
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    return currentViewController;
}
- (void)errorTips:(NSString *)tipsStr
{
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:tipsStr delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alterView show];
}
#pragma mark - 更新
- (void)alertViewUpdata
{
    //    if (buttonIndex == 1) {
    NSString *str = [NSString stringWithFormat:@"http://www.pgyer.com/apiv1/app/install?_api_key=e901990998041ccc27ee706cab2fccdb&aKey=%@&password=ga1234",self.puGongYingdic[@"data"][@"appKey"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    //    }
}

- (void)ABNotifierCreash
{
    // 检测错误报告
    if (ABNOTIFIERX_SWITCH) {
        //ABNotifier的一些配置参数
        NSString * macAddress = [GADeviceUtil macaddress];
        ABNotifier * sharedNotifier = [ABNotifier shared];
        sharedNotifier.macAddress = macAddress;
        sharedNotifier.channelID = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];
        sharedNotifier.appType = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
        sharedNotifier.debugSwitch = YES;
        [ABNotifier startNotifierWithAPIKey:@"com.guangan.student.iphone" projectID:@"9219" environmentName:ABNotifierAutomaticEnvironment useSSL:NO delegate:self];
        [ABNotifier setEnvironmentValue:@"ga_student" forKey:@"软件分类"];
    }
    
}
/*
 
 Asks the delegate to return the root view controller for the app. This is used
 to walk the view hierarchy and determine what view is on screen at the time of
 a crash.
 
 If you used the iOS 4 method `setRootViewController:` in UIWindow you do not
 need to implement this method.
 
 */
- (UIViewController *)rootViewControllerForNotice
{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}
@end

#endif

