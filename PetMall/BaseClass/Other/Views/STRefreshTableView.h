//
//  STRefreshTableView.h
//  SnailTruck
//
//  Created by 木鱼 on 15/11/27.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,RefreshPart) {
    /** 下拉刷新 */
    RefreshPartForDropDown,
    /** 上拉刷新 */
    RefreshPartForPullUp
};
@protocol STRefreshTableViewDelegate <NSObject>

@optional
- (void)refreshTableView:(UITableView *)tableView refreshPart:(RefreshPart)refreshPart;

@end

@interface STRefreshTableView : UITableView

//@property (nonatomic, assign) SelectDataType selectType;// 添加一个属性，区分已发布，待发布，未通过状态
@property (nonatomic, assign) Class cellClass;
@property (nonatomic, weak) id <STRefreshTableViewDelegate> refreshDelegate;
@property (nonatomic, strong) NSMutableArray * rowHeightArray;

/** pageSizes: 当前页的数据条数 page:当前第几页  pages: 一共有多少页 */
- (void)refreshTableViewWithCurrentSize:(NSInteger)pageSizes CurrentPage:(NSInteger)page TotalPages:(NSInteger)pages;
/** 应该根据数据个数进行判断  haveDataCount: 已经下载多少数据条数 page:当前第几页  totalDataCount: 一共有多数据 */
//- (void)refreshTableViewWithHaveDataCount:(NSInteger)haveDataCount CurrentPage:(NSInteger)page totalDataCount:(NSInteger)totalDataCount;

/** 停止刷新 */
- (void)endRefresh;

+ (instancetype)refreshTableViewWithRefreshCellClass:(Class)cellClass refreshDelegate:(id<STRefreshTableViewDelegate>)refreshDelegate rowHeight:(CGFloat)rowHeight;



@end
