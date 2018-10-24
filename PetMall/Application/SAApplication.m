//
//  SAApplication.m
//  SnailAuction
//
//  Created by imeng on 02/03/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "SAApplication.h"

#import "STNetworking.h"

#import "STNavigationController.h"
#import "STTabBarController.h"

#import "GAToastTipsView.h"

#import "SAAlertController.h"

#import "SAUserInfoEntity.h"
//#import "STAppUpdateAlert.h"
#import <BaiduMapAPI_Base/BMKMapManager.h>

#ifdef DEBUG
//#define DEBUGVIDEOCHATCALL
#endif

NSNotificationName const SACommonInfoCountDownNotificationName = @"SACommonInfoCountDownNotificationName";
NSNotificationName const SALotInfoListUpdateNotification = @"SALotInfoListUpdateNotification";

static NSString *const kUserInfoUserDefaultsKEY = @"sa_userInfoKEY";

static NSString *kUserID = nil;

static dispatch_queue_t conversationsSerialQueue = NULL;
static dispatch_queue_t conversationsJoinSerialQueue = NULL;

@interface SAApplication ()
@property(nonatomic, copy) NSString *updateUrl;
@property(nonatomic, strong) dispatch_source_t timer;
@property(nonatomic, strong) SAAlertController *alertController;
@property(nonatomic, strong)   BMKMapManager *mapManager;

@end

@implementation SAApplication

+ (SAApplication *)sharedApplication {
    static SAApplication *app = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        app = [[SAApplication alloc] init];
    });
    return app;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUser];
        // 初始化网络配置.
        [STNetworking initNetworking];
        // 初始化window
        [self initWindow];
        [self initRootViewController];
        [self initCountDownTimer];
        
        NSString *mapKey = @"v9Bt1S4HMVMyf7uABt6zGLw3wdwRcIHO";
        _mapManager = [[BMKMapManager alloc]init];
        
        // 如果要关注网络及授权验证事件，请设定generalDelegate参数
        BOOL ret = [_mapManager start:mapKey generalDelegate:nil];
        if (ret) {
            NSLog(@"百度引擎设置成功！");
        }

        
//        [self checkVersion];
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            conversationsSerialQueue = dispatch_queue_create("sa.conversations.serialQueue", DISPATCH_QUEUE_SERIAL);
            conversationsJoinSerialQueue = dispatch_queue_create("sa.conversationsJoin.serialQueue", DISPATCH_QUEUE_SERIAL);
        });
        
#ifdef DEBUGVIDEOCHATCALL
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            SAAVIMVideoViewerNotificationMessage *message = [[SAAVIMVideoViewerNotificationMessage alloc] init];
            message.notification = [[SAVideoViewerNotificationEntity alloc] init];
            message.notification.roomNo = @"1";
            [self handleVideoCallApplicationWithMessage:message];
        });
#endif
    }
    return self;
}

#pragma mark - init

- (void)initWindow {
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
#ifdef DEVELOPER_TEST_VIEWCONTROLLER
    UIViewController *vc = [[NSClassFromString(DEVELOPER_TEST_VIEWCONTROLLER) alloc] init];
    _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
#else
    _window.rootViewController = self.mainTabBarController;
#endif
}
//
//- (void)checkVersion{
//    SAVersionCheck *request = [[SAVersionCheck alloc] init];
//    request.mobileType = @"1";
//    [request startWithCompletionBlockWithSuccess:^(__kindof SARequest *request) {
//        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//        if (![request.responseObject[@"repBody"][@"version"] isEqualToString:app_Version]) {
//            STAppUpdateAlert *alert = [[STAppUpdateAlert alloc] init];
//            alert.text = request.responseObject[@"repBody"][@"description"];
//            alert.version = request.responseObject[@"repBody"][@"version"];
//            self.updateUrl = request.responseObject[@"repBody"][@"url"];
//            [alert.button0 addTarget:self action:@selector(alertViewUpdata) forControlEvents:UIControlEventTouchUpInside];
//            [alert.closeButton addTarget:self action:@selector(closeCountter) forControlEvents:UIControlEventTouchUpInside];
//            [alert show];
//        }
//
//
//    } failure:NULL];
//}

#pragma mark - 更新
- (void)alertViewUpdata{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.updateUrl]];
}

- (void)closeCountter{
    
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

- (void)initRootViewController {
//    [self.navigationController setViewControllers:@[self.mainTabBarController]
//                                         animated:NO];
//    if (self.userInfo) {
//        [self signIn];
//    } else {
        _window.rootViewController = self.mainTabBarController;
//    }
}

- (void)initUser {
    NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults]
                              objectForKey:kUserInfoUserDefaultsKEY];
    _userInfo = [SAUserInfoEntity mj_objectWithKeyValues:userInfo];
    kUserID = _userInfo.userId;
}

- (void)initCountDownTimer {
    //间隔60秒
    uint64_t interval = 1 * NSEC_PER_SEC;
    //创建一个专门执行timer回调的GCD队列
    dispatch_queue_t queue = dispatch_queue_create("SACommonInfoCountDownQueue", 0);
    //创建Timer
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //使用dispatch_source_set_timer函数设置timer参数
    dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);
    //设置回调
    dispatch_source_set_event_handler(_timer, ^(){
        [[NSNotificationCenter defaultCenter]
         postNotificationName:SACommonInfoCountDownNotificationName
         object:nil];
    });
    //dispatch_source默认是Suspended状态，通过dispatch_resume函数开始它
    dispatch_resume(_timer);
}

#pragma mark - Method

- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification)
                                                 name:SACommonInfoCountDownNotificationName
                                               object:nil];
}

- (void)removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:SACommonInfoCountDownNotificationName
                                                  object:nil];
}




#pragma mark - Getter

//- (UINavigationController *)navigationController {
//    if (_navigationController) return _navigationController;
//    _navigationController = [[STNavigationController alloc] init];
//    return _navigationController;
//}

- (UITabBarController *)mainTabBarController {
    if (_mainTabBarController) return _mainTabBarController;
    _mainTabBarController = [[STTabBarController alloc] init];
    return _mainTabBarController;
}

- (UIViewController *)signInController {
//    if (_signInController) return _signInController;
    _signInController = [[PMLoginViewController alloc] init];
    @weakify(self);
    [(PMLoginViewController*)_signInController
     setCallBack:^(PMLoginViewController *viewController) {
         [weak_self signInWithCallBack:^(BOOL succeeded, NSError *error) {
//             !viewController.nextStep ?: viewController.nextStep();
         }];;
    }];
    return _signInController;
}

- (SAUserInfoEntity *)userInfo {
    if (_userInfo) {return _userInfo;}
    [self initUser];
    return _userInfo;
}

@end

@implementation SAApplication (User)

+ (BOOL)isSign {
    BOOL isSign = kUserID ? YES : NO;
    return isSign;
}

- (void)signIn {
    [self signInWithCallBack:NULL];
    
}

- (void)signInWithCallBack:(void (^)(BOOL succeeded, NSError *error))callBack {
    [STNetworkingBusiness sharedSTNetworkingBusiness].defaultRequestHeaderCacheDictM = nil;
    _mainTabBarController = nil;
    _window.rootViewController = self.mainTabBarController;
//    [self.navigationController setViewControllers:@[self.mainTabBarController]
//                                         animated:NO];
    !callBack ?: callBack(YES,nil);
}

- (void)signOut {
    _window.rootViewController = self.signInController;
//        [self.navigationController setViewControllers:@[self.signInController]
//                                            animated:NO];

    self.userInfo = nil;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:kUserInfoUserDefaultsKEY];
    [userDefault synchronize];
}

+ (NSString *)userID {
    return kUserID;
}

- (void)storeUserInfo:(SAUserInfoEntity *)userInfo {
    /**
    contactMobile    联系电话（商户）    string
    convId    房间号    string
    userId    用户id    number
     **/
    self.userInfo = userInfo;
    NSDictionary * userInfoDic = [userInfo mj_keyValues];
    if (userInfoDic) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:userInfoDic forKey:kUserInfoUserDefaultsKEY];
        [userDefault synchronize];
//        [self initUser];
    }
}

@end


