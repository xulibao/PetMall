//
//  PMBaseWebViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/11/3.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import "PMBaseWebViewController.h"
#import <WebKit/WebKit.h>

@interface PMBaseWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) WKWebView *webView;


@end

@implementation PMBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.webTitle;
    self.webView = [[WKWebView alloc] init];
    self.webView.frame = self.view.bounds;
    self.webView.height = self.view.height - 64;
    [self.view addSubview:self.webView];
    self.ga_interactivePopDisabled = YES;
    //    self.webView.delegate = self;
    //    NSString*htmlstr= [[NSString alloc] initWithContentsOfURL:self.jumpUrl encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.jumpUrl]];
    
    //    [self.webView loadHTMLString:htmlstr baseURL:self.jumpUrl];
    //
    //    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL ]];
    //    [self.webView loadRequest:request];
    
}


@end
