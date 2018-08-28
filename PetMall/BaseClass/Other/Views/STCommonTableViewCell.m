//
//  STCommonTableViewCell.m
//  SnailAuction
//
//  Created by imeng on 2018/2/8.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "STCommonTableViewCell.h"

@implementation STCommonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

- (void)dealloc {
    self.parentTableView = nil;
    self.indexPath = nil;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.indexPath = nil;
}

// 解决 iOS 8 以后的 cell 中 separatorInset 受 layoutMargins 影响的问题
- (UIEdgeInsets)layoutMargins {
    return UIEdgeInsetsZero;
}

#pragma mark - STCommonTableViewItemConfigProtocol

- (void)tableView:(UITableView *)tableView configViewWithData:(id<STCommonTableRowItem>)data AtIndexPath:(NSIndexPath *)indexPath {
    self.parentTableView = tableView;
    self.indexPath = indexPath;
}

- (void)setCellDelegate:(id)cellDelegate {
    if ([cellDelegate conformsToProtocol:@protocol(STCommonTableViewCellDelegate)]) {
        _cellDelegate = (id<STCommonTableViewCellDelegate>)cellDelegate;
    }
}

@end
