//
//  SAInfoListFilterViewController.h
//  SnailAuction
//
//  Created by imeng on 2018/2/12.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SAInfoListViewController.h"
#import "STMenuRecordView.h"
#import "SADropDownMenu.h"
@interface SAInfoListFilterViewController : SAInfoListViewController

@property(nonatomic, strong) SADropDownMenu *filterView;
@property(nonatomic, strong) STMenuRecordView *recordView;

@property(nonatomic, copy) NSDictionary *filterParameters;

@end

@interface SAInfoListFilterViewController (SubclassingHooks)

- (void)initFilterView;
- (void)layoutFilterView;

- (void)initRecordView;

- (void)updateFilterWithParameters:(NSDictionary *)parameters;

@end
