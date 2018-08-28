//
//  STBaseViewController.h
//  SnailTruck
//
//  Created by 曼 on 15/10/23.
//  Copyright (c) 2015年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SARequest.h"
#import "STEmptyView.h"

@interface STBaseViewController : UIViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 *  初始化时调用的方法，会在两个 NS_DESIGNATED_INITIALIZER 方法中被调用，所以子类如果需要同时支持两个 NS_DESIGNATED_INITIALIZER 方法，则建议把初始化时要做的事情放到这个方法里。否则仅需重写要支持的那个 NS_DESIGNATED_INITIALIZER 方法即可。
 */
- (void)didInitialized NS_REQUIRES_SUPER;

@property(nonatomic, assign) BOOL shouldHiddenSystemNavgation;//是否隐藏 Navgation

/**
 *  空列表控件，支持显示提示文字、loading、操作按钮
 */
@property(nonatomic, strong) STEmptyView *emptyView;
@property(nonatomic, assign) NSInteger requestLoadCount;


- (UIBarButtonItem *)setupNavBackBarButtonWithAction:(SEL)action;
- (UIBarButtonItem *)setupNavRightCSBarButtonWithAction:(SEL)action;//客服按钮

- (void)popViewController:(id)sender;
- (void)dismissViewController:(id)sender;

- (void)pushViewController:(UIViewController *)viewController;

- (void)defaultCSAction:(id)sender;//默认的客服实现

@property(nonatomic, strong) SARequest *retryRequest;

@end

@interface STBaseViewController (SubclassingHooks)

/**
 *  负责初始化和设置controller里面的view，也就是self.view的subView。目的在于分类代码，所以与view初始化的相关代码都写在这里。
 *
 *  @warning initSubviews只负责subviews的init，不负责布局。布局相关的代码应该写在 <b>viewDidLayoutSubviews</b>
 */
- (void)initSubviews NS_REQUIRES_SUPER;

/**
 *  负责设置和更新navigationItem，包括title、leftBarButtonItem、rightBarButtonItem。viewDidLoad里面会自动调用，允许手动调用更新。目的在于分类代码，所有与navigationItem相关的代码都写在这里。在需要修改navigationItem的时候都只调用这个接口。
 */
- (void)setNavigationItems NS_REQUIRES_SUPER;

@end

@interface STBaseViewController (Loading)

///**
// *  加载框的显示与隐藏函数
// *
// *  @param title 加载框标题
// */
//- (void)showLoadingViewWithTitle:(NSString *)title;
//- (void)hideLoadingView;

@end

@interface STBaseViewController (Toast)

- (void)showErrow:(NSString *)messsage;
- (void)showSuccess:(NSString *)messsage;
- (void)showWaring:(NSString *)messsage;

@end

@interface STBaseViewController (Empty)

/// 当前self.emptyView是否显示
@property(nonatomic, assign, readonly, getter = isEmptyViewShowing) BOOL emptyViewShowing;
/**
 *  显示emptyView
 *  emptyView 的以下系列接口可以按需进行重写
 *
 *  @see QMUIEmptyView
 */
- (void)showEmptyView;

/**
 *  显示loading的emptyView
 */
- (void)showEmptyViewWithLoading;

/**
 *  显示带text、detailText、button的emptyView
 */
- (void)showEmptyViewWithText:(NSString *)text
                   detailText:(NSString *)detailText
                  buttonTitle:(NSString *)buttonTitle
                 buttonAction:(SEL)action;

/**
 *  显示带image、text、detailText、button的emptyView
 */
- (void)showEmptyViewWithImage:(UIImage *)image
                          text:(NSString *)text
                    detailText:(NSString *)detailText
                   buttonTitle:(NSString *)buttonTitle
                  buttonAction:(SEL)action;

/**
 *  显示带loading、image、text、detailText、button的emptyView
 */
- (void)showEmptyViewWithLoading:(BOOL)showLoading
                           image:(UIImage *)image
                            text:(NSString *)text
                      detailText:(NSString *)detailText
                     buttonTitle:(NSString *)buttonTitle
                    buttonAction:(SEL)action;

/**
 显示重试emptyView
 */
- (void)showEmptyRetryViewWithButtonAction:(SEL)action;

/**
 *  隐藏emptyView
 */
- (void)hideEmptyView;

/**
 *  布局emptyView，如果emptyView没有被初始化或者没被添加到界面上，则直接忽略掉。
 *
 *  如果有特殊的情况，子类可以重写，实现自己的样式
 *
 *  @return YES表示成功进行一次布局，NO表示本次调用并没有进行布局操作（例如emptyView还没被初始化）
 */
- (BOOL)layoutEmptyView;

@end

@interface STBaseViewController (Request) <YTKRequestAccessory>

+ (Class)requestClass;//SARequest subClass

- (__kindof SARequest *)requestGET:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(__kindof SARequest *request, id responseObject))success
                           failure:(void (^)(__kindof SARequest *request, id responseObject, NSError *error))failure;

- (__kindof SARequest *)requestPOST:(NSString *)URLString
                         parameters:(id)parameters
                            success:(void (^)(__kindof SARequest *request, id responseObject))success
                            failure:(void (^)(__kindof SARequest *request, id responseObject, NSError *error))failure;

- (__kindof SARequest *)requestMethod:(GARequestMethod)method
                            URLString:(NSString *)URLString
                           parameters:(id)parameters
                              success:(void (^)(__kindof SARequest *request, id responseObject))success
                              failure:(void (^)(__kindof SARequest *request, id responseObject, NSError *error))failure;

- (__kindof SARequest *)requestMethod:(GARequestMethod)method
                            URLString:(NSString *)URLString
                           parameters:(id)parameters
                           resKeyPath:(NSString *)resKeyPath
                             resClass:(Class)resClass
                                retry:(BOOL)retry
                              success:(void (^)(__kindof SARequest *request, id responseObject))success
                              failure:(void (^)(__kindof SARequest *request, id responseObject, NSError *error))failure;

- (__kindof SARequest *)requestMethod:(GARequestMethod)method
                            URLString:(NSString *)URLString
                           parameters:(id)parameters
                           resKeyPath:(NSString *)resKeyPath
                        resArrayClass:(Class)resArrayClass
                                retry:(BOOL)retry
                              success:(void (^)(__kindof SARequest *request, id responseObject))success
                              failure:(void (^)(__kindof SARequest *request, id responseObject, NSError *error))failure;

//调用后不会发起请求 需要使用start发起请求
- (__kindof SARequest *)requestMethod:(GARequestMethod)method
                            URLString:(NSString *)URLString
                           parameters:(id)parameters
                           resKeyPath:(NSString *)resKeyPath
                             resClass:(Class)resClass
                        resArrayClass:(Class)resArrayClass
                                retry:(BOOL)retry
                            accessory:(id<YTKRequestAccessory>)accessory
                              success:(void (^)(__kindof SARequest *request, id responseObject))success
                              failure:(void (^)(__kindof SARequest *request, id responseObject, NSError *error))failure;

- (void)handleRetryAction;

@end
