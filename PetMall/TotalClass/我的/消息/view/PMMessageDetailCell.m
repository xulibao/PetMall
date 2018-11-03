//
//  PMMyCommentCell.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMessageDetailCell.h"
#import "PMMessageDetailItem.h"

@interface PMMessageDetailCell()
@property(nonatomic, strong) UILabel *timeLabel;
@property(nonatomic, strong) UILabel *statusLabel;
@property(nonatomic, strong) UILabel *messageContentLabel;

@end

@implementation PMMessageDetailCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initViews];
    }
    return self;
}

#pragma mark - STCommonTableViewItemConfigProtocol

- (void)tableView:(UITableView *)tableView configViewWithData:(PMMessageDetailItem *)data AtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView configViewWithData:data AtIndexPath:indexPath];
    self.timeLabel.text = data.time;
    self.statusLabel.text = data.name;
    self.messageContentLabel.text = data.content;
}
- (void)initViews{
//    [self.contentView sp_addBottomLineWithLeftMargin:15 rightMargin:0];
    self.contentView.backgroundColor = [UIColor whiteColor];
    UILabel * timeLabel = [UILabel new];
    self.timeLabel = timeLabel;
    timeLabel.text = @"8月28日 09:26";
    timeLabel.textColor = kColor999999;
    timeLabel.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:timeLabel];
    
    
    UIView * bgView =[UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    
    UILabel * statusLabel = [UILabel new];
    self.statusLabel = statusLabel;
    statusLabel.font = [UIFont systemFontOfSize:15];
    statusLabel.text = @"交易完成";
    [bgView addSubview:statusLabel];
    
    UILabel * messageContentLabel = [UILabel new];
    self.messageContentLabel = messageContentLabel;
    messageContentLabel.numberOfLines = 0;
    messageContentLabel.textColor = kColor999999;
    messageContentLabel.font = [UIFont systemFontOfSize:12];
    messageContentLabel.text = @"您的订单【GO狗粮 抗敏美毛系列全 犬配方 25磅】已完成";
    [bgView addSubview:messageContentLabel];
    
    UIButton * commentBtn = [UIButton new];
    commentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [commentBtn setTitle:@"点击去评论>" forState:UIControlStateNormal];
    [commentBtn setTitleColor:kColorFF3945 forState:UIControlStateNormal];
    [bgView addSubview:commentBtn];
    
    
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(17);
        
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeLabel.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(105);
        make.bottom.mas_equalTo(-10);

    }];
    
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18);
        make.top.mas_equalTo(12);
    }];
    
    [messageContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(statusLabel);
        make.right.mas_equalTo(-18);
        make.top.mas_equalTo(statusLabel.mas_bottom).mas_offset(15);
    }];
    
    [commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18);
        make.top.mas_equalTo(messageContentLabel.mas_bottom).mas_offset(10);
    }];
}


@end
