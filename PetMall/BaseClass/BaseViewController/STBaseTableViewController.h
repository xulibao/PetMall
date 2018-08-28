//
//  STBaseTableViewController.h
//  SnailAuction
//
//  Created by imeng on 2018/2/7.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "STBaseNonSystemNavViewController.h"

@interface STBaseTableViewController : STBaseNonSystemNavViewController

- (instancetype)initWithStyle:(UITableViewStyle)style NS_DESIGNATED_INITIALIZER;
/**
 *  初始化时调用的方法，会在两个 NS_DESIGNATED_INITIALIZER 方法中被调用，所以子类如果需要同时支持两个 NS_DESIGNATED_INITIALIZER 方法，则建议把初始化时要做的事情放到这个方法里。否则仅需重写要支持的那个 NS_DESIGNATED_INITIALIZER 方法即可。
 */
- (void)didInitializedWithStyle:(UITableViewStyle)style NS_REQUIRES_SUPER;

/// 获取当前的 `UITableViewStyle`
@property(nonatomic, assign, readonly) UITableViewStyle style;

/// 获取当前的 tableView
@property(nonatomic, strong, readonly) UITableView *tableView;

/**
 *  列表使用自定义的contentInset，不使用系统默认计算的，默认为QMUICommonTableViewControllerInitialContentInsetNotSet。<br/>
 *  @warning 当更改了这个值后，在 iOS 11 及以后里，会把 self.tableView.contentInsetAdjustmentBehavior 改为 UIScrollViewContentInsetAdjustmentNever，而在 iOS 11 以前，会把 self.automaticallyAdjustsScrollViewInsets 改为 NO。
 */
@property(nonatomic, assign) UIEdgeInsets tableViewInitialContentInset;

/**
 *  是否需要让scrollIndicatorInsets与tableView.contentInsets区分开来，如果不设置，则与tableView.contentInset保持一致。
 *
 *  只有当更改了tableViewInitialContentInset后，这个属性才会生效。
 */
@property(nonatomic, assign) UIEdgeInsets tableViewInitialScrollIndicatorInsets;

@end

@interface STBaseTableViewController (SubclassingHooks)

/**
 *  初始化tableView，在initSubViews的时候被自动调用。
 *
 *  一般情况下，有关tableView的设置属性的代码都应该写在这里。
 */
- (void)initTableView;

/**
 *  布局 tableView 的方法独立抽取出来，方便子类在需要自定义 tableView.frame 时能重写并且屏蔽掉 super 的代码。如果不独立一个方法而是放在 viewDidLayoutSubviews 里，子类就很难屏蔽 super 里对 tableView.frame 的修改。
 *  默认的实现是撑满 self.view，如果要自定义，可以写在这里而不调用 super，或者干脆重写这个方法但留空
 */
- (void)layoutTableView;

@end
