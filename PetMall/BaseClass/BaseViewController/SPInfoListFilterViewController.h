//
//  SPInfoListFilterViewController.h
//  SnailAuction
//
//  Created by imeng on 2018/2/12.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SAInfoListViewController.h"
#import "SADropDownMenu.h"

@interface SPInfoListFilterModel : NSObject
@property(nonatomic, assign) NSInteger index;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *imageNomalStr;
@property(nonatomic, copy) NSString *imageSelectStr;
@property(nonatomic, strong) NSMutableArray *dataList;
@property(nonatomic, assign) BOOL isShuaiXuan;
@property(nonatomic, copy) void (^tapClick)();

@property(nonatomic, copy) void (^cellDidSelect)(SADropDownIndexPath *indexPath);
@end

@interface SPInfoListFilterViewController : SAInfoListViewController<SADropDownMenuDataSource,SADropDownMenuDelegate,UISearchBarDelegate>
@property (nonatomic,strong) NSMutableArray * dataList;
@property(nonatomic, strong) SADropDownMenu *filterView;

@property(nonatomic, copy) NSDictionary *filterParameters;
@end

@interface SPInfoListFilterViewController (SubclassingHooks)

- (void)initFilterView;
- (void)layoutFilterView;

- (void)initTopView;

- (void)updateFilterWithParameters:(NSDictionary *)parameters;

@end
