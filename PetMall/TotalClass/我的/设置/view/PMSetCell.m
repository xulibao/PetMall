//
//  PMMyCommentCell.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMSetCell.h"
#import "PMSetItem.h"

@interface PMSetCell()
@property(nonatomic, strong) UILabel *userTitleLabel;

@end

@implementation PMSetCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initViews];
    }
    return self;
}

#pragma mark - STCommonTableViewItemConfigProtocol

- (void)tableView:(UITableView *)tableView configViewWithData:(PMSetItem *)data AtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView configViewWithData:data AtIndexPath:indexPath];

    self.userTitleLabel.text = data.title;
   
    
}
- (void)initViews{
    
   
    UILabel *userTitleLabel = [[UILabel alloc] init];
    self.userTitleLabel = userTitleLabel;
    userTitleLabel.font = [UIFont systemFontOfSize:15];
    userTitleLabel.textColor = [UIColor colorWithHexStr:@"#333333"];
    [self.contentView addSubview:userTitleLabel];

    [userTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(14);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.contentView);
    }];
    
    UIView * lineView = [UIView new];
    lineView.backgroundColor = kColorFAFAFA;
    [self.contentView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(10);
        make.left.right.bottom.mas_equalTo(self.contentView);
    }];
    

}


@end
