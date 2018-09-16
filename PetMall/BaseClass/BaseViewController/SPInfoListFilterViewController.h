//
//  SPInfoListFilterViewController.h
//  SnailAuction
//
//  Created by imeng on 2018/2/12.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SAInfoListViewController.h"
#import "STMenuRecordView.h"
#import "SADropDownMenu.h"

@interface SPInfoListFilterModel : NSObject
@property(nonatomic, assign) NSInteger index;

@end

@interface SPInfoListFilterViewController : SAInfoListViewController
@property (nonatomic,strong) NSMutableArray * dataList;
@property(nonatomic, strong) SADropDownMenu *filterView;
@property(nonatomic, strong) STMenuRecordView *recordView;

@property(nonatomic, copy) NSDictionary *filterParameters;
@end

@interface SPInfoListFilterViewController (SubclassingHooks)

- (void)initFilterView;
- (void)layoutFilterView;

- (void)initRecordView;

- (void)updateFilterWithParameters:(NSDictionary *)parameters;

@end
