//
//  STBaseTableViewController.m
//  SnailAuction
//
//  Created by imeng on 2018/2/7.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "STBaseTableViewController.h"
#import "UIScrollView+SAScrollView.h"
#import "UITableView+SATableView.h"

#import "SATableViewHeaderFooterView.h"

const UIEdgeInsets SABaseTableViewControllerInitialContentInsetNotSet = {-1, -1, -1, -1};
NSString *const SATableViewControllerSectionHeaderIdentifier = @"SASectionHeaderView";
NSString *const SATableViewControllerSectionFooterIdentifier = @"SASectionFooterView";

@interface STBaseTableViewController ()

@property(nonatomic, strong, readwrite) UITableView *tableView;
@property(nonatomic, assign) BOOL hasSetInitialContentInset;

@end

@implementation STBaseTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithNibName:nil bundle:nil]) {
        [self didInitializedWithStyle:style];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [self initWithStyle:UITableViewStylePlain];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self didInitializedWithStyle:UITableViewStylePlain];
    }
    return self;
}

- (void)didInitializedWithStyle:(UITableViewStyle)style {
    _style = style;
    self.tableViewInitialContentInset = SABaseTableViewControllerInitialContentInsetNotSet;
    self.tableViewInitialScrollIndicatorInsets = SABaseTableViewControllerInitialContentInsetNotSet;
}

- (void)didInitialized {
    [super didInitialized];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *backgroundColor = nil;
    if (self.style == UITableViewStylePlain) {
//        backgroundColor = TableViewBackgroundColor;
    } else {
//        backgroundColor =
    }
    if (backgroundColor) {
        self.view.backgroundColor = backgroundColor;
    }
}

- (void)initSubviews {
    [super initSubviews];
    [self initTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView sa_clearsSelection];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self layoutTableView];
    
    if ([self shouldAdjustTableViewContentInsetsInitially] && !self.hasSetInitialContentInset) {
        self.tableView.contentInset = self.tableViewInitialContentInset;
        if ([self shouldAdjustTableViewScrollIndicatorInsetsInitially]) {
            self.tableView.scrollIndicatorInsets = self.tableViewInitialScrollIndicatorInsets;
        } else {
            // 默认和tableView.contentInset一致
            self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
        }
        [self.tableView sa_scrollToTop];
        self.hasSetInitialContentInset = YES;
    }
    [self layoutEmptyView];
}

- (BOOL)shouldHiddenSystemNavgation {
    return NO;
}

- (void)showEmptyView {
    if (!self.emptyView) {
        self.emptyView = [[STEmptyView alloc] initWithFrame:self.view.bounds];
        self.emptyView.userInteractionEnabled = YES;
        YYImage *image = [YYImage imageNamed:@"common_loading_icon"];
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
    
    [self.tableView insertSubview:self.emptyView atIndex:0];
}

#pragma mark - 工具方法

- (UITableView *)tableView {
    if (!_tableView) {
        [self view];
    }
    return _tableView;
}

- (BOOL)shouldAdjustTableViewContentInsetsInitially {
    BOOL shouldAdjust = !UIEdgeInsetsEqualToEdgeInsets(self.tableViewInitialContentInset, SABaseTableViewControllerInitialContentInsetNotSet);
    return shouldAdjust;
}

- (BOOL)shouldAdjustTableViewScrollIndicatorInsetsInitially {
    BOOL shouldAdjust = !UIEdgeInsetsEqualToEdgeInsets(self.tableViewInitialScrollIndicatorInsets, SABaseTableViewControllerInitialContentInsetNotSet);
    return shouldAdjust;
}

@end

@implementation STBaseTableViewController (SubclassingHooks)

- (void)initTableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.style];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.sectionHeaderHeight = CGFLOAT_MIN;
        _tableView.sectionFooterHeight = CGFLOAT_MIN;
        [self.view addSubview:self.tableView];
        
        if (@available(iOS 11, *)) {
            if ([self shouldAdjustTableViewContentInsetsInitially]) {
                self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        }
    }
}

- (void)layoutTableView {
    BOOL shouldChangeTableViewFrame = !CGRectEqualToRect(self.view.bounds, self.tableView.frame);
    if (shouldChangeTableViewFrame) {
        self.tableView.frame = self.view.bounds;
    }
}

@end
