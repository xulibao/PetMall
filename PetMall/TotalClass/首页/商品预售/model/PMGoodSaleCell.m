//
//  PMGoodsCell.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/10/26.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import "PMGoodSaleCell.h"

#import <UIImageView+WebCache.h>

@interface PMGoodSaleCell ()
/* 图片 */
@property (strong , nonatomic)UIImageView *goodsImageView;

@property(nonatomic, strong) UILabel * imageBottomLabel;
@property(nonatomic, strong) UILabel * imageTimeBottomLabel;

/* 标题 */
@property (strong , nonatomic)UILabel *goodsLabel;
/* 价格 */
@property (strong , nonatomic)UILabel *priceLabel;

/* 原价 */
@property (strong , nonatomic)UILabel *originLabel;

/* 参团人数 */
@property (strong , nonatomic)UILabel *peopleCountLabel;

/* 相同 */
@property (strong , nonatomic)UIButton *rightButton;

@end
@implementation PMGoodSaleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initViews];
    }
    return self;
}

#pragma mark - STCommonTableViewItemConfigProtocol

- (void)tableView:(UITableView *)tableView configViewWithData:(PMGoodSaleItem *)data AtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView configViewWithData:data AtIndexPath:indexPath];
    self.item = data;
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:data.goods_logo]];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",data.selling_price];
    _peopleCountLabel.text = [NSString stringWithFormat:@"%@条评价",data.package_pl];
    _originLabel.text = [NSString stringWithFormat:@"%@%%好评",data.package_ok];
    _goodsLabel.text = data.goods_title;
    if ([[self class] compareDate:[[self class] getCurrentTimes] withDate:data.active_time_b] == 1) {
        self.rightButton.enabled = NO;
        self.imageBottomLabel.hidden = NO;
        self.imageTimeBottomLabel.hidden = NO;
        self.imageTimeBottomLabel.text = data.btime;
    }else{
        self.rightButton.enabled = YES;
    }
    
    
}
+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}
- (void)initViews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    _goodsImageView = [[UIImageView alloc] init];
    _goodsImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_goodsImageView];
    
    UILabel * imageBottomLabel = [UILabel new];
    self.imageBottomLabel= imageBottomLabel;
    self.imageBottomLabel.hidden = YES;
    imageBottomLabel.text = @"预售";
    imageBottomLabel.backgroundColor = [UIColor colorWithHexStr:@"#FF3945" alpha:0.68];
    imageBottomLabel.textAlignment = NSTextAlignmentCenter;
    imageBottomLabel.font = [UIFont systemFontOfSize:11];
    imageBottomLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:imageBottomLabel];
    
    UILabel * imageTimeBottomLabel = [UILabel new];
    self.imageTimeBottomLabel= imageTimeBottomLabel;
    self.imageTimeBottomLabel.hidden = YES;
    imageTimeBottomLabel.backgroundColor = [UIColor colorWithHexStr:@"#FF3945"];
    imageTimeBottomLabel.textAlignment = NSTextAlignmentCenter;
    imageTimeBottomLabel.font = [UIFont systemFontOfSize:11];
    imageTimeBottomLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:imageTimeBottomLabel];
    
    
    _goodsLabel = [[UILabel alloc] init];
    _goodsLabel.font = [UIFont systemFontOfSize:16];
    _goodsLabel.numberOfLines = 2;
    _goodsLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_goodsLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor colorWithHexStr:@"#FF3945"];
    _priceLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_priceLabel];
    
    _originLabel = [[UILabel alloc] init];
    _originLabel.textColor = kColor999999;
    _originLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_originLabel];
    
    _peopleCountLabel = [[UILabel alloc] init];
    _peopleCountLabel.textColor = kColor999999;
    _peopleCountLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_peopleCountLabel];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setImage:IMAGE(@"cart_add") forState:UIControlStateNormal];
    [_rightButton setImage:IMAGE(@"cart_add_disable") forState:UIControlStateDisabled];
    [_rightButton addTarget:self action:@selector(addCartClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_rightButton];
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexStr:@"#FAFAFA"];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(5);
        make.left.right.top.mas_equalTo(self.contentView);
    }];
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self.contentView);
        make.top.mas_equalTo(lineView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(120 , 120));
    }];
    
    [imageBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.mas_equalTo(self.contentView);
        make.height.mas_equalTo(17);
        make.right.mas_equalTo(_goodsLabel.mas_left);
    }];
    
    [imageTimeBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(17);
        make.width.mas_equalTo(140);
    }];
    
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodsImageView.mas_right).mas_offset(15);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(20);
    }];
    
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodsLabel); make.top.mas_equalTo(_goodsLabel.mas_bottom).mas_offset(15);
    }];
    
    [_originLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_priceLabel.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(_priceLabel);
    }];
    
    [_peopleCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_priceLabel); make.top.mas_equalTo(_priceLabel.mas_bottom).mas_offset(5);
    }];
    
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self.contentView)setOffset:-15];
        make.top.mas_equalTo(self.priceLabel).mas_offset(4);
//        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    
}

- (void)addCartClick{
    if ([self.cellDelegate respondsToSelector:@selector(cellDidAddCart:)]) {
        [self.cellDelegate cellDidAddCart:self.item];
    }
    
}

+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate
{
    NSInteger aa;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result == NSOrderedSame){
        //        相等  aa=0
        aa = 0;
    }else if (result == NSOrderedAscending){
        //bDate比aDate大
        aa = 1;
    }else{
        //bDate比aDate小
        aa= -1;
    }
    return aa;
}


@end
