//
//  PMMyCommentCell.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMessageCell.h"
#import "PMMessageItem.h"

@interface PMMessageCell()
@property(nonatomic, strong) UILabel *userTitleLabel;
@property(nonatomic, strong) UILabel *commentLabel;
@property(nonatomic, strong) UILabel *commentTimeLabel;
@property(nonatomic, strong) UIImageView *userImageView;

@end

@implementation PMMessageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initViews];
    }
    return self;
}

#pragma mark - STCommonTableViewItemConfigProtocol

- (void)tableView:(UITableView *)tableView configViewWithData:(PMMessageItem *)data AtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView configViewWithData:data AtIndexPath:indexPath];
    
    self.userImageView.image = IMAGE(data.image_url);
    self.userTitleLabel.text = data.goods_title;
    self.commentLabel.text = data.nature;
    self.commentTimeLabel.text = @"08:58";
    
//    self.cartPriceLabel.text = [NSString stringWithFormat:@"¥%@",data.price];
//    self.cartCountLabel.text = [NSString stringWithFormat:@"x%@",data.people_count];;
//
    
}
- (void)initViews{
    [self.contentView sp_addBottomLineWithLeftMargin:15 rightMargin:0];
    self.contentView.backgroundColor = [UIColor whiteColor];
    UIImageView * userImageView = [[UIImageView alloc] init];
    userImageView.layer.cornerRadius = 15;
    userImageView.clipsToBounds = YES;
    userImageView.contentMode = UIViewContentModeScaleAspectFit;

    self.userImageView = userImageView;
    [self.contentView addSubview:userImageView];
    
    UILabel *userTitleLabel = [[UILabel alloc] init];
    userTitleLabel.text = @"系统通知";
    userTitleLabel.numberOfLines = 0;
    self.userTitleLabel = userTitleLabel;
    userTitleLabel.font = [UIFont systemFontOfSize:14];
    userTitleLabel.textColor = [UIColor colorWithHexStr:@"#333333"];
    [self.contentView addSubview:userTitleLabel];
    
    
    UILabel *commentLabel = [[UILabel alloc] init];
    commentLabel.numberOfLines = 0;
    self.commentLabel = commentLabel;
    commentLabel.font = [UIFont systemFontOfSize:12];
    commentLabel.textColor = [UIColor colorWithHexStr:@"#999999"];
    [self.contentView addSubview:commentLabel];
    
    UILabel *commentTimeLabel = [[UILabel alloc] init];
    commentTimeLabel.text = @"2018-06-28";
    self.commentTimeLabel = commentTimeLabel;
    commentTimeLabel.font = [UIFont systemFontOfSize:12];
    commentTimeLabel.textColor = [UIColor colorWithHexStr:@"#999999"];
    commentTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:commentTimeLabel];
    
    
  
    [userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.bottom.mas_equalTo(-10);

    }];
    [userTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(userImageView);
        make.left.mas_equalTo(userImageView.mas_right).mas_offset(14);
    }];
    [commentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(userImageView);
    }];
    [commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(userTitleLabel);
        make.bottom.mas_equalTo(userImageView);
    }];
  
   
}


@end
