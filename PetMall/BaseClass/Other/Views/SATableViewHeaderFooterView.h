//
//  QMUITableViewHeaderFooterView.h
//  QMUIKit
//
//  Created by MoLice on 2017/12/7.
//  Copyright © 2017年 QMUI Team. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SATableViewHeaderFooterViewTypeUnknow,
    SATableViewHeaderFooterViewTypeHeader,
    SATableViewHeaderFooterViewTypeFooter
} SATableViewHeaderFooterViewType;

/**
 *  适用于 UITableView 的 sectionHeaderFooterView，提供的特性包括：
 *  1. 支持单个 UILabel，该 label 支持多行文字。
 *  2. 支持右边添加一个 accessoryView（注意，设置 accessoryView 之前请先保证自身大小正确）。
 *  3. 支持调整 headerFooterView 的 padding。
 *  4. 支持应用配置表的样式。
 *
 *  使用方式：
 *  基本与系统的 UITableViewHeaderFooterView 使用方式一致，额外需要做的事情有：
 *  1. 如果要支持高度自动根据内容变化，则需要重写 tableView:heightForHeaderInSection:、tableView:heightForFooterInSection:，在里面调用 headerFooterView 的 sizeThatFits:。
 *  2. 如果要应用配置表样式，则设置 parentTableView 和 type 这两个属性即可。
 */
@interface SATableViewHeaderFooterView : UITableViewHeaderFooterView

@property(nonatomic, weak) UITableView *parentTableView;
@property(nonatomic, assign) SATableViewHeaderFooterViewType type;

@property(nonatomic, strong, readonly) UILabel *titleLabel;
@property(nonatomic, strong) UIView *accessoryView;

@property(nonatomic, assign) UIEdgeInsets contentEdgeInsets;
@property(nonatomic, assign) UIEdgeInsets accessoryViewMargins;
@end
