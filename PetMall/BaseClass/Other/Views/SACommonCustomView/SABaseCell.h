//
//  SABaseCell.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/7.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SABaseCell : UITableViewCell

+ (instancetype)cellWith:(UITableView *)tableView WithIdentifier:(NSString *)identifier;

- (void)initViews;
@end
