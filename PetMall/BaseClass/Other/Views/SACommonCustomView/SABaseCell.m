//
//  SABaseCell.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/7.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SABaseCell.h"

@implementation SABaseCell

+ (instancetype)cellWith:(UITableView *)tableView WithIdentifier:(NSString *)identifier{
    id cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initViews];
    }
    return self;
}

- (void)initViews{
    
}

@end
