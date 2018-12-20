//
//  SAInfoListViewController.m
//  SnailAuction
//
//  Created by imeng on 2018/2/8.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SAInfoListViewController.h"
#import "SALotInfoItem.h"

#import "UITableView+FDTemplateLayoutCell.h"

@interface SAInfoListViewController ()

@property(nonatomic, assign) BOOL didAddObserver;

@end

@implementation SAInfoListViewController

- (void)dealloc
{
    if (_didAddObserver) {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:SALotInfoListUpdateNotification
                                                      object:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView flashScrollIndicators];
    if ([self shouldAutoRefreshingWhenServiceNotification]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleUpdateLotInfo)
                                                     name:SALotInfoListUpdateNotification
                                                   object:nil];
        _didAddObserver = YES;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)handleUpdateLotInfo {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self updateLotInfo];
    });
}

#pragma mark - Override

- (void)didInitialized {
    [super didInitialized];
    self.shouldAutoReloadTable = YES;
}

- (void)initTableView {
    [super initTableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    
    _viewModel.tableView = self.tableView;
    // Set the callback（Once you enter the refresh status，then call the action of target，that is call [self loadNewData]）
    if (self.shouldInitRefreshingHeader) {
        self.tableView.mj_header = [SARefreshHeader headerWithRefreshingTarget:self
                                                              refreshingAction:@selector(refreshingAction)];
    }
}

- (void)addItems:(NSArray<id<STCommonTableRowItem>> *)items {
    [self insertItems:items atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (self.shouldAutoReloadTable) {
        [self reload];
    }
}

- (void)removeAllObjects {
    [self.viewModel removeAllObjects];
    if (self.shouldAutoReloadTable) {
        [self reload];
    }
}

- (void)setItems:(NSArray<id<STCommonTableRowItem>> *)items {
    [self.viewModel removeAllObjects];
    [self insertItems:items atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

- (void)insertItems:(NSArray<id<STCommonTableRowItem>> *)items
        atIndexPath:(NSIndexPath *)indexPath {
    if (items) {
        [self.viewModel insertRows:items atIndexPath:indexPath];
        
        NSMutableArray *needPriceUpdateDelegates = [NSMutableArray arrayWithCapacity:items.count];
        [items enumerateObjectsUsingBlock:^(id<STCommonTableRowItem>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (self.shouldAutoRemoveExpiredItem) {
                if ([obj respondsToSelector:@selector(addDelegate:)]) {
                    [obj addDelegate:self];
                }
            }
            if ([obj respondsToSelector:@selector(shouldDisplayCountDown)]) {
                id<SACommonListInfoItem> infoItem = (id)obj;
                if (infoItem.shouldDisplayCountDown) {
                    [needPriceUpdateDelegates addObject:obj];
                }
            }
        }];
        if (needPriceUpdateDelegates.count > 0) {
//            [[SAApplication sharedApplication] addPriceUpdateDelegates:(id)items];
        }
    }
    
    if (self.shouldAutoReloadTable) {
        [self reload];
    }
}

- (void)reload {
    if (self.isViewLoaded) {
        dispatch_main_async_safe(^{
            [self.tableView reloadData];
            [self showTableEmptyView];
        })
    }
}

- (void)beginRefreshing {
    [self.tableView.mj_header beginRefreshing];
}

- (void)endRefreshing {
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - Getter

- (STCommonTableViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[STCommonTableViewModel alloc] initWithTableView:self.tableView];
        _viewModel.tableViewDelegate = self;
    }
    return _viewModel;
}

#pragma mark - STCommonTableViewItemUpdateDelegate

- (void)objectDidUpdate:(id)object {}

- (void)objectDidExpired:(id<STCommonTableRowItem>)object {
    BOOL shouldRemove = self.shouldAutoRemoveExpiredItem;
    if (self.shouldAutoConvertLotItemStatus && [object conformsToProtocol:@protocol(SACommonListInfoItem)]) {
        //自动转换拍品状态 从即将开始到进行中
        id<SACommonListInfoItem> lotItem = (id)object;
        if ([lotItem respondsToSelector:@selector(status)]) {
            SAAuctionStatus status = lotItem.status;
            if (SAAuctionStatusNotBegin == status && SAAuctionStatusInProgress != status && 0 != status) {
                if ([lotItem respondsToSelector:@selector(setStatus:)]) {
                    [lotItem setStatus:SAAuctionStatusInProgress];
                    shouldRemove = NO;
                }
            }
        }
    }
    
    if (shouldRemove) {
        //自动删除过期项目
        if ([object respondsToSelector:@selector(indexPath)]) {
            if ([object respondsToSelector:@selector(removeDelegate:)]) {
                [object removeDelegate:self];
            }
            
            [self.viewModel removeObjectAtIndexPath:object.indexPath];
        }
    }
    [self reload];

}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id item = [self.viewModel objectAtIndexPath:indexPath];
    [self didSelectCellWithItem:item];
    if ([self.delegate respondsToSelector:@selector(infoListViewController:didSelectCellWithItem:)]) {
        [self.delegate infoListViewController:self didSelectCellWithItem:item];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    id item = [self.viewModel objectAtIndexPath:indexPath];
    return [self shouldSelectCellWithItem:item];
}

@end

@implementation SAInfoListViewController (SubclassingHooks)

- (void)didSelectCellWithItem:(id<STCommonTableRowItem>)item {
    id vc = nil;
    if ([item respondsToSelector:@selector(createDetailViewController)]) {
        vc = [item createDetailViewController];
    }
    if (vc) {
        [self pushViewController:vc];
    }
}

- (BOOL)shouldSelectCellWithItem:(id<STCommonTableRowItem>)item {
    return YES;
}

- (BOOL)shouldAutoReloadTable {
    return _shouldAutoReloadTable;
}

- (BOOL)shouldInitRefreshingHeader {
    return YES;
}

- (BOOL)shouldAutoRefreshingWhenServiceNotification {
    return NO;
}

- (BOOL)shouldAutoRemoveExpiredItem {
    return NO;
}

- (BOOL)shouldAutoConvertLotItemStatus {
    return YES;
}

- (void)refreshingAction {
    
}

- (void)updateLotInfo {
    [self refreshingAction];
}

- (void)showTableEmptyView {
    if (0 == [self.viewModel numberOfRowsInSection:0]) {
        NSString *tableEmptyText = [self tableEmptyText];
        [self showEmptyViewWithImage:[UIImage imageNamed:@"common_nodata"]
                                text:tableEmptyText
                          detailText:nil
                         buttonTitle:nil
                        buttonAction:NULL];
    } else {
        [self hideEmptyView];
    }
}

- (void)requestWillStart:(id)request {
    if (!self.tableView.mj_header.isRefreshing) {
        [super requestWillStart:request];
    }
}

- (void)requestDidStop:(__kindof SARequest *)request {
    if (self.tableView.mj_header.isRefreshing) {
        [self endRefreshing];
    }
    if (request.error) {
        [self removeAllObjects];
    }
    [super requestDidStop:request];
}

- (NSString *)tableEmptyText {
    return @"暂无数据～";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [self.viewModel cellIdentifierAtIndexPath:indexPath];
    return [tableView fd_heightForCellWithIdentifier:identifier configuration:^(id cell) {
        id object = [self.viewModel objectAtIndexPath:indexPath];
        if ([cell respondsToSelector:@selector(tableView:configViewWithData:AtIndexPath:)]) {
            [cell tableView:tableView configViewWithData:object AtIndexPath:indexPath];
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView heightForRowAtIndexPath:indexPath];
}

@end
