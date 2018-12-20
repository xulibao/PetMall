//
//  PMMyAddressCell.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMyAddressCell.h"
#import "PMMyAddressItem.h"
@interface PMMyAddressCell()
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *phoneLabel;
@property(nonatomic, strong) UILabel *addressLabel;
@property(nonatomic, strong) UILabel *defaultLabel;
@property(nonatomic, strong) UIButton *editBtn;
@property(nonatomic, strong) PMMyAddressItem *item;
@end

@implementation PMMyAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initViews];
    }
    return self;
}

#pragma mark - STCommonTableViewItemConfigProtocol

- (void)tableView:(UITableView *)tableView configViewWithData:(PMMyAddressItem *)data AtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView configViewWithData:data AtIndexPath:indexPath];
    self.item = data;
    self.nameLabel.text = data.user_name;
    self.phoneLabel.text = data.user_phone;
    self.addressLabel.text = [NSString stringWithFormat:@"收货地址：%@%@",data.user_address,data.user_add] ;
    self.defaultLabel.hidden = !data.zt;
    

}
- (void)initViews{
    self.contentView.backgroundColor = [UIColor colorWithHexStr:@"#ffffff"];

    [self sp_addBottomLineWithLeftMargin:0 rightMargin:0];
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    nameLabel.font = [UIFont boldSystemFontOfSize:15];
    nameLabel.textColor = [UIColor colorWithHexStr:@"#333333"];
    [self.contentView addSubview:nameLabel];
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    self.phoneLabel = phoneLabel;
    phoneLabel.font = [UIFont systemFontOfSize:15];
    phoneLabel.textColor = [UIColor colorWithHexStr:@"#333333"];
    [self.contentView addSubview:phoneLabel];

    UILabel *addressLabel = [[UILabel alloc] init];
    self.addressLabel = addressLabel;
    addressLabel.font = [UIFont systemFontOfSize:12];
    addressLabel.numberOfLines = 0;
    addressLabel.textColor = [UIColor colorWithHexStr:@"#333333"];
    [self.contentView addSubview:addressLabel];
    
    UILabel *defaultLabel = [[UILabel alloc] init];
    self.defaultLabel = defaultLabel;
    defaultLabel.text = @"默认";
    defaultLabel.layer.cornerRadius = 7.5;
    defaultLabel.clipsToBounds = YES;
    defaultLabel.backgroundColor = kColorFF3945;
    defaultLabel.font = [UIFont systemFontOfSize:10];
    defaultLabel.textColor = [UIColor whiteColor];
    defaultLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:defaultLabel];
    
    UIButton * editBtn = [[UIButton alloc] init];
    [editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.editBtn = editBtn;
    [self.contentView addSubview:editBtn];
    [editBtn setImage:IMAGE(@"mine_address_edit") forState:UIControlStateNormal];
    

    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(phoneLabel.mas_left).mas_offset(-10);
    }];
    
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(150);
        make.centerY.mas_equalTo(nameLabel);
    }];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(nameLabel);
        make.right.mas_equalTo(editBtn.mas_left).mas_offset(-40);
    }];
    
    [defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(phoneLabel.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(nameLabel);
        make.size.mas_equalTo(CGSizeMake(40, 15));

    }];
    
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(-12);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.top.mas_equalTo(28.5);
        make.bottom.mas_equalTo(-28.5);
    }];
    
}

- (void)editBtnClick{
    if ([self.cellDelegate respondsToSelector:@selector(PMMyAddressCellEdit:)]) {
        [self.cellDelegate PMMyAddressCellEdit:self.item];
    }
}

@end
