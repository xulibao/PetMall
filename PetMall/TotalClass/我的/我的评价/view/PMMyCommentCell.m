//
//  PMMyCommentCell.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMyCommentCell.h"
#import "PMMyCommentItem.h"
#import "DCComImagesView.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface PMMyCommentCell()
@property(nonatomic, strong) UILabel *userTitleLabel;
@property(nonatomic, strong) UILabel *commentLabel;
@property(nonatomic, strong) UILabel *commentTimeLabel;
@property(nonatomic, strong) UIImageView *userImageView;

@property(nonatomic, strong) DCComImagesView *comImagesView;

@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIImageView * cartImageView;
@property(nonatomic, strong) UILabel *cartTitleLabel;
@property(nonatomic, strong) UILabel *cartNatureLabel;
@property(nonatomic, strong) UILabel *cartPriceLabel;
@property(nonatomic, strong) UILabel *cartCountLabel;
@end

@implementation PMMyCommentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initViews];
    }
    return self;
}

#pragma mark - STCommonTableViewItemConfigProtocol

- (void)tableView:(UITableView *)tableView configViewWithData:(PMMyCommentItem *)data AtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView configViewWithData:data AtIndexPath:indexPath];
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:data.img]];
    self.userTitleLabel.text = data.user_name;
    self.commentTimeLabel.text = data.user_time;
    self.commentLabel.text = data.user_comment;
    [self.cartImageView sd_setImageWithURL:[NSURL URLWithString:data.goods_logo] placeholderImage:nil];
    self.cartTitleLabel.text = data.goods_title;
    self.cartNatureLabel.text = data.goods_spec;
    self.cartPriceLabel.text = [NSString stringWithFormat:@"¥%@",data.selling_price];
    self.cartCountLabel.text = [NSString stringWithFormat:@"x%@",data.goods_shul];
    
    NSArray *picArray = [data.user_images componentsSeparatedBySthString:@"|"];
    NSMutableArray * picUrlArray = [@[] mutableCopy];
    for (NSString * imageStr in picArray) {
        if (![imageStr hasPrefix:[STNetworking host]]) {
            [picUrlArray addObject:[NSString stringWithFormat:@"%@/%@",[STNetworking host],imageStr]];
        }
    }
    self.comImagesView.picUrlArray = picUrlArray;

    
    
}
- (void)initViews{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    UIImageView * userImageView = [[UIImageView alloc] init];
    userImageView.layer.cornerRadius = 15;
    userImageView.clipsToBounds = YES;
    userImageView.contentMode = UIViewContentModeScaleAspectFit;
//    [userImageView sd_setImageWithURL:[NSURL URLWithString:@"https://pic4.zhimg.com/383179a483ae1074efaf091c89c8a103_l.jpg"]];
    self.userImageView = userImageView;
    [self.contentView addSubview:userImageView];
    
    UILabel *userTitleLabel = [[UILabel alloc] init];
    userTitleLabel.numberOfLines = 0;
    self.userTitleLabel = userTitleLabel;
    userTitleLabel.font = [UIFont systemFontOfSize:14];
    userTitleLabel.textColor = [UIColor colorWithHexStr:@"#333333"];
    [self.contentView addSubview:userTitleLabel];
    
    
    UILabel *commentLabel = [[UILabel alloc] init];
    commentLabel.numberOfLines = 0;
    self.commentLabel = commentLabel;
    commentLabel.font = [UIFont systemFontOfSize:14];
    commentLabel.textColor = [UIColor colorWithHexStr:@"#333333"];
    [self.contentView addSubview:commentLabel];
    
    UILabel *commentTimeLabel = [[UILabel alloc] init];
    self.commentTimeLabel = commentTimeLabel;
    commentTimeLabel.font = [UIFont systemFontOfSize:12];
    commentTimeLabel.textColor = [UIColor colorWithHexStr:@"#999999"];
    commentTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:commentTimeLabel];
    
    
    _comImagesView = [DCComImagesView new];
    _comImagesView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_comImagesView];
    
    
    
//  @[@"http://gfs9.gomein.net.cn/T19BWgBvCT1RCvBVdK.jpg",
//                          @"http://gfs6.gomein.net.cn/T1yvJgBvET1RCvBVdK.jpg",
//                          @"http://gfs1.gomein.net.cn/T1Ro_vBmbv1RCvBVdK.jpg",
//                          @"http://gfs1.gomein.net.cn/T1Ro_vBmbv1RCvBVdK.jpg",
//                          @"http://gfs8.gomein.net.cn/T1g.b_BvKT1RCvBVdK.jpg"
//                          ];
    
//    _comImagesView.comSpecifications = commentsItem.comSpecifications; //规格
    
    
    [userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [userTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(userImageView);
        make.left.mas_equalTo(userImageView.mas_right).mas_offset(14);
    }];
    [commentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(userImageView);
    }];
    [commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(userImageView);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(userImageView.mas_bottom).mas_offset(10);
    }];
  
    
    [_comImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(commentLabel.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(userImageView);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(80);
    }];
    
    
    UIView * bgView = [[UIView alloc] init];
    bgView.backgroundColor = kColorEEEEEE;
    [self.contentView addSubview:bgView];
    
    
    UIImageView * cartImageView = [[UIImageView alloc] init];
    cartImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.cartImageView = cartImageView;
    [bgView addSubview:cartImageView];
    
    
    UILabel *cartTitleLabel = [[UILabel alloc] init];
    cartTitleLabel.numberOfLines = 0;
    self.cartTitleLabel = cartTitleLabel;
    cartTitleLabel.font = [UIFont systemFontOfSize:13];
    cartTitleLabel.textColor = [UIColor colorWithHexStr:@"#333333"];
    [bgView addSubview:cartTitleLabel];
    
    UILabel *cartNatureLabel = [[UILabel alloc] init];
    self.cartNatureLabel = cartNatureLabel;
    cartNatureLabel.font = [UIFont systemFontOfSize:13];
    cartNatureLabel.textColor = [UIColor colorWithHexStr:@"#999999"];
    [bgView addSubview:cartNatureLabel];
    
    UILabel *cartPriceLabel = [[UILabel alloc] init];
    self.cartPriceLabel = cartPriceLabel;
    cartPriceLabel.font = [UIFont systemFontOfSize:14];
    cartPriceLabel.textColor = [UIColor colorWithHexStr:@"#333333"];
    [bgView addSubview:cartPriceLabel];
    
    UILabel *cartCountLabel = [[UILabel alloc] init];
    self.cartCountLabel = cartCountLabel;
    cartCountLabel.font = [UIFont systemFontOfSize:12];
    cartCountLabel.textColor = [UIColor colorWithHexStr:@"#999999"];
    cartCountLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:cartCountLabel];
  
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(_comImagesView.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(95);
        make.bottom.mas_equalTo(-20);
    }];
    
    [cartImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        make.left.mas_equalTo(bgView).mas_offset(10);
        make.centerY.mas_equalTo(bgView);
        //        make.top.mas_equalTo(10);
        //        make.bottom.mas_equalTo(-10);
        
    }];
    
    [cartTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cartImageView.mas_right).mas_offset(10);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-50);
    }];
    
    [cartNatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cartTitleLabel);
        make.top.mas_equalTo(cartTitleLabel.mas_bottom).mas_offset(6);
    }];
    
    [cartPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cartNatureLabel);
        make.top.mas_equalTo(cartNatureLabel.mas_bottom).mas_offset(6);
        
    }];
    
    
    [cartCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(cartNatureLabel);
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
