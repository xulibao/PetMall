//
//  SAInfoListViewController.h
//  SnailAuction
//
//  Created by imeng on 2018/2/8.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "STBaseTableViewController.h"
#import "STCommonTableViewModel.h"
#import "STCommonTableViewBaseItem.h"
#import "SACommonInfoCell.h"
#import "SARefreshHeader.h"

@class SAInfoListViewController;
@protocol SAInfoListDelegate <NSObject>

- (void)infoListViewController:(__kindof SAInfoListViewController *)viewController
         didSelectCellWithItem:(id<STCommonTableRowItem>)item;

@end

@interface SAInfoListViewController : STBaseTableViewController<
UITableViewDelegate,
STCommonTableViewItemUpdateDelegate
>

@property(nonatomic, strong) STCommonTableViewModel *viewModel;
@property(nonatomic, weak) id<SAInfoListDelegate> delegate;
@property(nonatomic, assign) BOOL shouldAutoReloadTable;//Default is Yes, Override shouldAutoReloadTable
@property(nonatomic, assign) NSInteger page;
- (void)addItems:(NSArray<id<STCommonTableRowItem>> *)items;
- (void)removeAllObjects;

- (void)setItems:(NSArray<id<STCommonTableRowItem>> *)items; //removeAllObjects addItems

- (void)insertItems:(NSArray<id<STCommonTableRowItem>> *)items
        atIndexPath:(NSIndexPath *)indexPath;

- (void)beginRefreshing;
- (void)endRefreshing;
- (void)reload;
@end

@interface SAInfoListViewController (SubclassingHooks)

- (void)didSelectCellWithItem:(id<STCommonTableRowItem>)item;
- (BOOL)shouldSelectCellWithItem:(id<STCommonTableRowItem>)item;
- (BOOL)shouldAutoReloadTable;//default is YES
- (BOOL)shouldInitRefreshingHeader;//default is YES
- (BOOL)shouldAutoRefreshingWhenServiceNotification;//default is NO 是否根据服务端刷新通知更新
- (BOOL)shouldAutoRemoveExpiredItem;//default is NO 自动删除过期项目

- (BOOL)shouldAutoConvertLotItemStatus;//default is YES 自动转换拍品状态 从即将开始到进行中

- (void)refreshingAction;
- (void)showTableEmptyView;

- (void)updateLotInfo;//default call refreshingAction 服务端刷新通知更新调用

- (NSString *)tableEmptyText;

@end
