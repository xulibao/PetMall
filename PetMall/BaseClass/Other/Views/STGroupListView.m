//
//  STGroupListView.m
//  SnailAuction
//
//  Created by imeng on 26/02/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "STGroupListView.h"

@implementation STGroupListView

- (instancetype)initWithMaxHeight:(CGFloat)maxHeight {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _section = [[STGroupSectionView alloc] init];
        [self addSubview:_section];
        
        [_section mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self);
        }];
        
        _tableView = [[UITableView alloc] init];
        _tableView.sectionHeaderHeight = CGFLOAT_MIN;
        _tableView.sectionFooterHeight = CGFLOAT_MIN;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.section.mas_bottom);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(maxHeight);
        }];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithMaxHeight:100 + 10*2];
}

- (void)addItems:(NSArray<id<STCommonTableRowItem>> *)items {
    [self.viewModel addRows:items inSection:0];
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointMake(0, -10) animated:NO];
}

- (void)removeAllObjects {
    [self.viewModel removeAllObjects];
    [self.tableView reloadData];
}

- (void)setItems:(NSArray<id<STCommonTableRowItem>> *)items {
    [self.viewModel removeAllObjects];
    [self.viewModel addRows:items inSection:0];
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointMake(0, -10) animated:NO];
}

- (void)setSectionTitle:(NSString *)sectionTitle {
    _sectionTitle = sectionTitle;
    [self.section setTitle:_sectionTitle];
}

- (void)setSectionDesc:(NSAttributedString *)sectionDesc {
    _sectionDesc = sectionDesc;
    [self.section setDesc:_sectionDesc];
}

- (STCommonTableViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[STCommonTableViewModel alloc] initWithTableView:self.tableView];
    }
    return _viewModel;
}

@end
