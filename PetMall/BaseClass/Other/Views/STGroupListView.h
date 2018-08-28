//
//  STGroupListView.h
//  SnailAuction
//
//  Created by imeng on 26/02/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STGroupSectionView.h"
#import "STCommonTableViewModel.h"

@interface STGroupListView : UIView

@property(nonatomic, strong) STCommonTableViewModel *viewModel;
@property(nonatomic, strong) STGroupSectionView *section;
@property(nonatomic, strong) UITableView *tableView;

- (instancetype)initWithMaxHeight:(CGFloat)maxHeight;

@property(nonatomic, copy) NSString *sectionTitle;
@property(nonatomic, copy) NSAttributedString *sectionDesc;

- (void)addItems:(NSArray<id<STCommonTableRowItem>> *)items;
- (void)removeAllObjects;

- (void)setItems:(NSArray<id<STCommonTableRowItem>> *)items;

@end
