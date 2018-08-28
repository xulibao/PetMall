//
//  STWebViewController.m
//  SnailTruck
//
//  Created by GhGh on 2017/5/24.
//  Copyright © 2017年 GhGh. All rights reserved.
//

#import "STWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIButton+YYWebImage.h>
#import "STWebViewEntity.h"
#import "SAApplication.h"
#import "SAUserInfoEntity.h"
#import "UIViewController+STWebViewController.h"

//#import "STNewsDetailViewController.h"

@protocol OMBannerWebViewJSExport <STWebViewControllerJSCall>

@end
@interface STWebViewController ()<UIWebViewDelegate, OMBannerWebViewJSExport>
@property (nonatomic, strong) UIButton *closeButton;
//@property (nonatomic, strong) ShareMainView *shareView;
@property (nonatomic, strong)JSContext *jscontext;
@property (nonatomic, strong) STH5ViewConfig *viewConfig;
@end

@implementation STWebViewController

- (void)dealloc
{
    self.jscontext[@"CallAppFunction"] = nil;
    self.jscontext = nil;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.navgationBar layoutIfNeeded];
    
}
- (BOOL)shouldHiddenSystemNavgation {
    return YES;
}

- (BOOL)shouldInitSTNavgationBar {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:self.webTitle];
    [self createRightBtn];
//    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.webView = [[UIWebView alloc] init];
    self.webView.frame = self.view.bounds;
    [self.view addSubview:self.webView];
    // 不可以全屏拖动
    self.ga_interactivePopDisabled = YES;
//    self.navigationController.jz_fullScreenInteractivePopGestureEnabled = NO;
    self.webView.delegate = self;
//    STLOADING(self.view)
    
    _closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [_closeButton setTitleColor:kNavigationBlackColor forState:UIControlStateNormal];
    _closeButton.hidden = YES;
    _closeButton.frame = CGRectMake(CGRectGetMaxX(self. navgationBar.leftBarButton.frame), CGRectGetMinY(self.navgationBar.leftBarButton.frame), 44, 44);
    CGFloat btnMaxX = CGRectGetMaxX(_closeButton.frame) + 2;
//    self.titleLabel.width = (UI_SCREEN_WIDTH - 2*btnMaxX);
//    self.titleLabel.centerX = self.navigationBarView.centerX;
    [_closeButton addTarget:self action:@selector(closePage) forControlEvents:UIControlEventTouchUpInside];
    
//    self.jumpUrl = [NSURL URLWithString:@"http://192.168.1.197/activity/activity.html"];
//    self.jumpUrl = [[NSBundle mainBundle] URLForResource:@"testConfig" withExtension:@"html"];
    [self reloadWebView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navgationBar addSubview:_closeButton];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.closeButton removeFromSuperview];
}

- (void)createRightBtn
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.navgationBar.rightBarButton = rightBtn;
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [rightBtn addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navgationBar addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.width.height.mas_equalTo(30);
        make.centerY.mas_equalTo(self.navgationBar);
    }];
    rightBtn.hidden = YES;
}

- (void)updateViewConfig:(STH5ViewConfig *)viewConfig {
    if (!viewConfig) return;
    self.viewConfig = viewConfig;
    NSString *navigationBarTitleText = viewConfig.navigationBarTitleText;
    NSString *rightButtonTitleText = viewConfig.rightButtonTitleText;
    NSString *rightButtoniconURL = viewConfig.rightButtonIconURL;
    
    //标题
    if (navigationBarTitleText.length > 0) {
        [self.navgationBar setTitle:navigationBarTitleText];
    }else {
        NSString *titleStr = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        if (titleStr.length > 0) {
            [self.navgationBar setTitle:titleStr];
        }
    }

    if (!self.isNotShowRightBtn){
    //右侧按钮
    [self.navgationBar.rightBarButton setTitle:rightButtonTitleText forState:UIControlStateNormal];
    [self.navgationBar.rightBarButton setTitleColor:kColorTextBlack forState:UIControlStateNormal];
    
    if ([rightButtoniconURL length] > 0) {
        [self.navgationBar.rightBarButton  yy_setImageWithURL:[NSURL URLWithString:rightButtoniconURL] forState:UIControlStateNormal placeholder:nil];
    } else {
        [self.navgationBar.rightBarButton setImage:nil forState:UIControlStateNormal];
    }
    //按钮是否显示
    self.navgationBar.rightBarButton.hidden = !viewConfig.hasRightButton;
    [self.navgationBar.rightBarButton layoutIfNeeded];
    }
}

#pragma mark - TargetAction

//右侧按钮点击
- (void)rightButtonClick:(UIButton *)btn {
    if (!self.viewConfig.rightButtonAction) return;
    [self.view endEditing:YES];
    NSString *func = self.viewConfig.rightButtonAction;
    [self evaluateScriptMethod:func];
}

- (void)injectWebView:(UIWebView *)webView {
    self.jscontext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jscontext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    @weakify(self);
    self.jscontext[@"CallAppFunction"] = weak_self;
}

#pragma mark - Action

- (void)reloadWebView {
    [self loadWebViewWithUrl:[self webViewParametersUrl]];
}

- (void)loadWebViewWithUrl:(NSURL *)url{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    if (request != nil) {
        [self.webView loadRequest:request];
    }else {
        [self showErrow:@"加载出错"];
    }
}
#pragma mark - 返回按钮

- (void)backPrePage {
    if (![self.webView.request.URL.absoluteString isEqualToString:[self webViewParametersUrl].absoluteString] && [self.webView canGoBack]) {
        [self.webView goBack];
    } else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)closePage {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    [self injectWebView:webView];
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    STHIDDEN(self.view)
}

// 加载标题
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self injectWebView:webView];
    STH5ViewConfig *viewConfig = [STH5ViewConfig mj_objectWithKeyValues:[[self.jscontext evaluateScript:@"AppViewConfigure()"] toObject]];
    [self updateViewConfig:viewConfig];
    
    // 判断是不是第一页
    self.closeButton.hidden = !webView.canGoBack;// [webView.request.URL.absoluteString hasPrefix:self.jumpUrl.absoluteString];
    
//    STHIDDEN(self.viewContent)
}

#pragma mark - OMBannerWebViewJSExport

//登录
- (void)loginFromH5 {
    @weakify(self);
    [self loginFromH5WithCallBack:^{
                [weak_self reloadWebView];
            }];
}

- (NSURL *)webViewParametersUrl {
    NSString *uid = [SAApplication userID];
    if ([uid isKindOfClass:[NSNumber class]]) {
        uid = [(NSNumber *)uid stringValue];
    }
    NSString *modifyURL = _jumpUrl.absoluteString;
    if (!self.isNotContainUserId) {
        NSRange range = [modifyURL rangeOfString:@"userId"];
        NSRange range2 = [modifyURL rangeOfString:@"platform"];
        if (range.length > 1 && range.length < 10) {
            if (range2.length < 1) {
                modifyURL = [modifyURL stringByAppendingString:@"&platform=1"];
            }
            return [NSURL URLWithString:modifyURL];
        }
        
        modifyURL = [modifyURL stringByAppendingString:@"?platform=1"]; //platform=1 来源 1 iOS 2 android
        if (uid && uid.length > 0) {
            modifyURL = [modifyURL stringByAppendingString:[NSString stringWithFormat:@"&userId=%@&mobile=%@",uid, [SAApplication sharedApplication].userInfo.contactMobile]];
        } else {
            modifyURL = [modifyURL stringByAppendingString:[NSString stringWithFormat:@"&userId="]];
        }
    }
    return [NSURL URLWithString:modifyURL];
}

- (void)evaluateScriptMethod:(NSString *)method {
    [self evaluateScriptMethod:method parameter:nil];
}

- (void)evaluateScriptMethod:(NSString *)method parameter:(id)parameter {
    if (!method) {
        NSAssert(0, @"method is required");
        return;
    }
    NSString *evaluateScript = [NSString stringWithFormat:@"%@(%@)", method, parameter?parameter:@""];
    NSString *modifyEvaluateScript = [NSString stringWithFormat:@"setTimeout(function(){%@;}, 1);",evaluateScript];
    [self.jscontext evaluateScript:modifyEvaluateScript];
}

//点击某张图片
- (void)onClickImage:(NSString *)data
{
    dispatch_async(dispatch_get_main_queue(), ^{
//        STNewsDetailViewController *newsDetailVC = [[STNewsDetailViewController alloc]init];
//        newsDetailVC.imageUrl = data;
//        [self.navigationController pushViewController:newsDetailVC animated:YES];
    });
}
@end

