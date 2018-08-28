//
//  STRefreshTableView.m
//  SnailTruck
//
//  Created by 木鱼 on 15/11/27.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "STRefreshTableView.h"
#import "MJRefresh.h"

#define RowHeight (self.heightForRow > 0 ? self.heightForRow : 44)

@interface STRefreshTableView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) RefreshPart currentOperation;
@property (nonatomic, assign) NSInteger currentPage; //当前第几页
@property (nonatomic, assign) NSInteger totalPages; //总共有几页
@property (nonatomic, assign) NSInteger pageSizes; //当前页多少条

@property (nonatomic, assign) NSInteger totalSize; //已经有多少条

@property (nonatomic, assign) CGFloat heightForRow;//行高

@end

@implementation STRefreshTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        
        //上拉刷新
//        @weakify(self);
//        [STHelpTools addRefreshTableView:self block:^{
//            @strongify(self)
//            [self refreshOperation:RefreshPartForDropDown];
//        }];
//        //下拉刷新
//        [STHelpTools addFooterTableView:self block:^{
//            @strongify(self)
//            [self refreshOperation:RefreshPartForPullUp];
//        }];
        
    }
    return self;
}


+ (instancetype)refreshTableViewWithRefreshCellClass:(Class)cellClass refreshDelegate:(id<STRefreshTableViewDelegate>)refreshDelegate rowHeight:(CGFloat)rowHeight
{
    STRefreshTableView * refreshTableView = [[STRefreshTableView alloc] initWithRefreshCellClass:cellClass refreshDelegate:refreshDelegate rowHeight:rowHeight];
    
    
    return refreshTableView;
}

- (instancetype)initWithRefreshCellClass:(Class)cellClass refreshDelegate:(id<STRefreshTableViewDelegate>)refreshDelegate rowHeight:(CGFloat)rowHeight
{
    
    if (self = [super init]) {
        
        self.cellClass = cellClass;
        self.refreshDelegate = refreshDelegate;
        self.heightForRow = rowHeight;
    
        //上拉刷新
//        [STHelpTools addRefreshTableView:self block:^{
//            [self refreshOperation:RefreshPartForDropDown];
//        }];
//        //下拉刷新
//        [STHelpTools addFooterTableView:self block:^{
//            [self refreshOperation:RefreshPartForPullUp];
//        }];
        
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}


- (void)endRefresh
{
    if (self.currentOperation == RefreshPartForPullUp) {
        [self.mj_footer endRefreshing];
    }else{
        [self.mj_header endRefreshing];
    }
}

//刷新操作
- (void)refreshOperation:(RefreshPart)refreshPart
{
    self.currentOperation = refreshPart;
    
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:refreshPart:)]) {
        [self.refreshDelegate refreshTableView:self refreshPart:refreshPart];
    }
}

- (void)refreshTableViewWithCurrentSize:(NSInteger)pageSizes CurrentPage:(NSInteger)currentPage TotalPages:(NSInteger)totalpages;
{
    if (currentPage == 1) {
        self.totalSize = 0;
    }
    
    self.pageSizes = pageSizes;
    self.totalSize += pageSizes;
    self.currentPage = currentPage;
    self.totalPages = totalpages;
 

    if (self.currentOperation == RefreshPartForPullUp) {
        [self.mj_footer endRefreshing];
    }else{
        [self.mj_header endRefreshing];
    }
    if (currentPage >= totalpages) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }else{
         [self.mj_footer resetNoMoreData];
    }
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.totalSize;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * ID = NSStringFromClass (self.cellClass);
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[self.cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.rowHeightArray.count > 0) {
        
       return  [self.rowHeightArray[indexPath.row] doubleValue];
    }
    return RowHeight;
}

- (void)setRowHeightArray:(NSMutableArray *)rowHeightArray
{
    _rowHeightArray = rowHeightArray;
    [self reloadData];
}

@end
