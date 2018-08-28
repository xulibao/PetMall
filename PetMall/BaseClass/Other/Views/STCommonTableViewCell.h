//
//  STCommonTableViewCell.h
//  SnailAuction
//
//  Created by imeng on 2018/2/8.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCommonTableViewProtocol.h"

@interface STCommonTableViewCell : UITableViewCell <STCommonTableViewItemConfigProtocol>
/// 保存对tableView的弱引用，在布局时可能会使用到tableView的一些属性例如separatorColor等。只有使用下面两个 initForTableView: 的接口初始化时这个属性才有值，否则就只能自己初始化后赋值
@property(nonatomic, weak) UITableView *parentTableView;
@property(nonatomic, strong) NSIndexPath *indexPath;
@property(nonatomic, weak) id<STCommonTableViewCellDelegate> cellDelegate;

@end
