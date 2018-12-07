//
//  STBaseViewController.m
//  SnailTruck
//
//  Created by 曼 on 15/10/23.
//  Copyright (c) 2015年 GM. All rights reserved.
//

#import "STBaseViewController.h"
#import "GAToastTipsView.h"
#import <YYKit.h>

@interface STBaseViewController ()

@end

@implementation STBaseViewController {
    NSString *p_title;
}

#pragma mark - 生命周期

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self didInitialized];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self didInitialized];
    }
    return self;
}

- (void)didInitialized {
    if (self.shouldHiddenSystemNavgation) {
        self.ga_prefersNavigationBarHidden = self.shouldHiddenSystemNavgation;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = kColorFAFAFA;
    [self initSubviews];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationItems];
//    [self setNavigationItemsIsInEditMode:NO animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)dealloc {
    // 取消当前页面所有网络请求
//    [self cancelAllRequest];
}

- (void)setTitle:(NSString *)title {
    p_title = [title copy];
    self.navigationItem.title = title;
}

- (NSString *)title {
    return p_title;
}

- (UINavigationItem *)navigationItem {
//    if (self.tabBarController) {
//        return self.tabBarController.navigationItem;
//    } else {
        return [super navigationItem];
//    }
}

- (UIBarButtonItem *)setupNavBackBarButtonWithAction:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    // 禁止事件向同一视图内的其它子视图传递
    button.exclusiveTouch = YES;
    button.frame = CGRectMake(0, 0, 40, 40);
    button.backgroundColor = [UIColor clearColor];
//    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [button setImage:[UIImage imageNamed:@"nav_Back_normal"] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:@"nav_Back_highlight"] forState:UIControlStateHighlighted];
    if (action) {
        [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//    backItem.
    self.navigationItem.leftBarButtonItem = backItem;
    return backItem;
}

- (UIBarButtonItem *)setupNavRightCSBarButtonWithAction:(SEL)action {
    SEL selector = action ? action : @selector(defaultCSAction:);
    
    UIImage *image = [[UIImage imageNamed:@"customer_service_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *csBarButton = [[UIBarButtonItem alloc] initWithImage:image
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:selector];
    self.navigationItem.rightBarButtonItem = csBarButton;
    return csBarButton;
}

- (void)popViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dismissViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)pushViewController:(UIViewController *)viewController {
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)defaultCSAction:(id)sender {
    MakePhoneTelprompt(kPhoneNumber);
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"客服" message:@"暂未实现" preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
//                                                        style:UIAlertActionStyleDefault
//                                                      handler:NULL]];
//    [self presentViewController:alertController animated:self completion:nil];
}

@end

@implementation STBaseViewController (SubclassingHooks)

- (void)initSubviews {
    // 子类重写
}

- (void)setNavigationItems {
    // 子类重写
}

//- (void)setNavigationItemsIsInEditMode:(BOOL)isInEditMode animated:(BOOL)animated {
//    // 子类重写
//}

@end

@implementation STBaseViewController (Toast)

#pragma mark - 提示框
- (void)showErrow:(NSString *)messsage
{
    [GAToastTipsView showWithContent:messsage state:GAToastTipsStateError gravity:ToastGravityMake(GAToastHorizontalGravityBottom, GAToastVerticalGravityCenter) inView:self.view.window];
}
- (void)showSuccess:(NSString *)messsage
{
    [GAToastTipsView showWithContent:messsage state:GAToastTipsStateSucess gravity:ToastGravityMake(GAToastHorizontalGravityBottom, GAToastVerticalGravityCenter) inView:self.view];
}
- (void)showWaring:(NSString *)messsage
{
    [GAToastTipsView showWithContent:messsage state:GAToastTipsStateWarning gravity:ToastGravityMake(GAToastHorizontalGravityBottom, GAToastVerticalGravityCenter) inView:self.view.window];
}

@end

#import "STEmptyView.h"

@implementation STBaseViewController (Empty)

#pragma mark - 空列表视图 STEmptyView

- (void)showEmptyView {
    if (!self.emptyView) {
        self.emptyView = [[STEmptyView alloc] initWithFrame:self.view.bounds];
        YYImage *image = [YYImage imageNamed:@"common_nodata"];
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
        imageView.size = CGSizeMake(image.size.width /2 , image.size.height /2);
        self.emptyView.loadingView = (id)imageView;
        self.emptyView.userInteractionEnabled = YES;
        self.emptyView.imageViewInsets = UIEdgeInsetsMake(0, 0, 20, 0);
        self.emptyView.actionButtonInsets = UIEdgeInsetsMake(20, 0, 0, 0);
        self.emptyView.loadingViewInsets = UIEdgeInsetsMake(20, 0, 0, 0);
        self.emptyView.textLabelFont = UIFontMake(17);
        self.emptyView.textLabelTextColor = kColor999999;
        self.emptyView.actionButton.ghostColor = kColor999999;
        self.emptyView.actionButton.contentEdgeInsets = UIEdgeInsetsMake(6, 30, 6, 30);
        self.emptyView.backgroundColor = [UIColor clearColor];
        [self.emptyView setActionButtonTitleColor:kColor999999];
    }
    CALayer *layer = self.emptyView.contentView.layer;
    layer.cornerRadius = 0;
    layer.shadowColor = nil;
    layer.shadowOffset = CGSizeZero;
    layer.shadowOpacity = 0;
    layer.shadowRadius = 0;

    [self.view insertSubview:self.emptyView atIndex:0];
}

- (void)hideEmptyView {
    [self.emptyView removeFromSuperview];
}

- (BOOL)isEmptyViewShowing {
    return self.emptyView && self.emptyView.superview;
}

- (void)showEmptyViewWithLoading {
    [self showEmptyView];
    [self.emptyView setImage:nil];
    [self.emptyView setLoadingViewHidden:NO];
    [self.emptyView setTextLabelText:@"努力加载中..."];
    [self.emptyView setDetailTextLabelText:nil];
    [self.emptyView setActionButtonTitle:nil];
    CGFloat inset = (self.view.width-self.view.width*150.0/375.0)/2;
    self.emptyView.contentViewInsets = UIEdgeInsetsMake(0, inset, 0, inset);
    self.emptyView.textLabelInsets = UIEdgeInsetsMake(0, 0, 20, 0);
    self.emptyView.contentView.backgroundColor = kColorBackground;
    CALayer *layer = self.emptyView.contentView.layer;
    layer.cornerRadius = 20;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(0, 1);
    layer.shadowOpacity = .14f;
    layer.shadowRadius = 3.f;

    [self.emptyView bringToFront];
}

- (void)showEmptyViewWithText:(NSString *)text
                   detailText:(NSString *)detailText
                  buttonTitle:(NSString *)buttonTitle
                 buttonAction:(SEL)action {
    [self showEmptyViewWithLoading:NO image:nil text:text detailText:detailText buttonTitle:buttonTitle buttonAction:action];
}

- (void)showEmptyViewWithImage:(UIImage *)image
                          text:(NSString *)text
                    detailText:(NSString *)detailText
                   buttonTitle:(NSString *)buttonTitle
                  buttonAction:(SEL)action {
    [self showEmptyViewWithLoading:NO image:image text:text detailText:detailText buttonTitle:buttonTitle buttonAction:action];
}

- (void)showEmptyViewWithLoading:(BOOL)showLoading
                           image:(UIImage *)image
                            text:(NSString *)text
                      detailText:(NSString *)detailText
                     buttonTitle:(NSString *)buttonTitle
                    buttonAction:(SEL)action {
    [self showEmptyView];
    [self.emptyView setLoadingViewHidden:!showLoading];
    [self.emptyView setImage:image];
    [self.emptyView setTextLabelText:text];
    [self.emptyView setDetailTextLabelText:detailText];
    [self.emptyView setActionButtonTitle:buttonTitle];
    [self.emptyView.actionButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [self.emptyView.actionButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)showEmptyRetryViewWithButtonAction:(SEL)action {
    [self showEmptyViewWithImage:[UIImage imageNamed:@"request_error_icon"]
                            text:@"出错了!"
                      detailText:nil
                     buttonTitle:@"刷新"
                    buttonAction:action];
    self.emptyView.contentView.backgroundColor = [UIColor clearColor];
//    [self.emptyView bringToFront];
}


- (BOOL)layoutEmptyView {
    if (self.emptyView) {
        // 由于为self.emptyView设置frame时会调用到self.view，为了避免导致viewDidLoad提前触发，这里需要判断一下self.view是否已经被初始化
        BOOL viewDidLoad = self.emptyView.superview || [self isViewLoaded];
        if (viewDidLoad) {
            CGSize newEmptyViewSize = self.emptyView.superview.bounds.size;
            CGSize oldEmptyViewSize = self.emptyView.frame.size;
            if (!CGSizeEqualToSize(newEmptyViewSize, oldEmptyViewSize)) {
                self.emptyView.frame = CGRectMake(CGRectGetMinX(self.emptyView.frame), CGRectGetMinY(self.emptyView.frame), newEmptyViewSize.width, newEmptyViewSize.height);
            }
            return YES;
        }
    }
    return NO;
}

@end
