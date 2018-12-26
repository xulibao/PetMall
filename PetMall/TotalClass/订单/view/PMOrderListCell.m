//
//  SAOrderListCell.m
//  SnailAuction
//
//  Created by imeng on 26/02/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "PMOrderListCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SATruckInfoBaseBottomView.h"
#import "SATruckInfoBaseTopView.h"
#import "NSAttributedString+STAttributedString.h"
#import "PMOrderGoodView.h"
@interface PMOrderListCell ()
@property(nonatomic, strong) SATruckInfoBaseTopView *topView;
@property(nonatomic, strong) SATruckInfoBaseBottomView *bottomView;

@property(nonatomic, strong) PMOrderGoodView *bgView;


@end

@implementation PMOrderListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initViews];
    }
    return self;
}

#pragma mark - STCommonTableViewItemConfigProtocol

- (void)tableView:(UITableView *)tableView configViewWithData:(PMOrderItem *)data AtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView configViewWithData:data AtIndexPath:indexPath];
    NSString *text0;
    PMOrderListItem * firstItem = [data.order_list firstObject];
    self.item = data;
    if (firstItem.order_no) {
        text0 = [@"订单编号：" stringByAppendingString:firstItem.order_no];
    }
    
    self.topView.attStr_label0 = [text0 attributedStingWithAttributes:nil];
    self.topView.attStr_label1 = [data.statusText attributedStingWithAttributes:@{NSForegroundColorAttributeName:kColorFF5554}];
    float totalPrice = 0.f;
    for (int i = 0; i < data.order_list.count; i++) {
        PMOrderListItem *item = data.order_list[i];
        totalPrice += ([item.pay_price floatValue] * [item.goods_shul intValue]);
        PMOrderGoodView * goodView = [[PMOrderGoodView alloc] init];
        if (i == data.order_list.count - 1) {
            self.bgView = goodView;
        }
        goodView.data  = item;
        [self.contentView addSubview:goodView];
        [goodView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topView.mas_bottom).mas_offset(100 * i);
            make.left.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(95);
        }];
        UIButton * goodsBtn = [[UIButton alloc] init];
        goodsBtn.hidden = YES;
        [goodsBtn setTitle:@"退款" forState:UIControlStateNormal];
        [goodsBtn setTitleColor:[UIColor colorWithHexStr:@"#999999"] forState:UIControlStateNormal];
        goodsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        goodsBtn.layer.cornerRadius = 10;
        goodsBtn.layer.borderColor = [UIColor colorWithHexStr:@"#999999"].CGColor;
        goodsBtn.layer.borderWidth = 1;
        goodsBtn.layer.masksToBounds = YES;
        [goodsBtn addTarget:self action:@selector(goodsBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [goodView addSubview:goodsBtn];
        [goodsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(goodView).mas_offset(-5);
            make.right.mas_equalTo(goodView).mas_offset(-5);
            make.size.mas_equalTo(CGSizeMake(50, 20));
        }];
        _bottomView.tags = data.tagsText;

        switch ([self.item.status integerValue]) {
            case 1:{
                @weakify(self)
                _bottomView.tagBtnClick = ^(NSInteger tag) {
                    @strongify(self)
                    if (tag == 0) { //取消订单
                        if ([self.cellDelegate respondsToSelector:@selector(PMOrderListCellClickCancle:)]) {
                            [self.cellDelegate PMOrderListCellClickCancle:self];
                        }
                    }else{ //付款
                        if ([self.cellDelegate respondsToSelector:@selector(PMOrderListCellClickPay:)]) {
                            [self.cellDelegate PMOrderListCellClickPay:self];
                        }
                    }
                    
                };
            }
                break;
            case 2:{
                @weakify(self)
                _bottomView.tagBtnClick = ^(NSInteger tag) {
                    @strongify(self)
                    if (tag == 0) { //取消订单
                        if ([self.cellDelegate respondsToSelector:@selector(PMOrderListCellClickCancle:)]) {
                            [self.cellDelegate PMOrderListCellClickCancle:self];
                        }
                    }
                    
                };
            }
                break;
            case 4:{
                @weakify(self)
                _bottomView.tagBtnClick = ^(NSInteger tag) {
                    @strongify(self)
                    if (tag == 0) { //确认收货
                        if ([self.cellDelegate respondsToSelector:@selector(PMOrderListCellClickConfirm:)]) {
                            [self.cellDelegate PMOrderListCellClickConfirm:self];
                        }
                    }else{ //评论
                        if ([self.cellDelegate respondsToSelector:@selector(PMOrderListCellClickComment:)]) {
                            [self.cellDelegate PMOrderListCellClickComment:self];
                        }
                    }
                    
                };
            }
                break;
                
            default:
                break;
        }
        
        
    }
    
    
    _bottomView.label0.text = [NSString stringWithFormat:@"共%lu件商品 合计:¥%.2f(含运费¥%.2f)",(unsigned long)data.order_list.count,totalPrice,[data.freight_price floatValue]];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(-10);
        make.top.mas_equalTo(self.bgView.mas_bottom);
        make.height.mas_equalTo(40);
    }];
//    [_bottomView setNeedsLayout];
}

- (void)goodsBtnClick{
    if ([self.cellDelegate respondsToSelector:@selector(PMOrderListCellClickRefund:)]) {
        [self.cellDelegate PMOrderListCellClickRefund:self];
    }
}

- (void)initViews{
    self.contentView.backgroundColor = [UIColor colorWithHexStr:@"#f2f2f2"];
    _topView = [[SATruckInfoBaseTopView alloc] init];
    _topView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_topView];
    
    _bottomView = [[SATruckInfoBaseBottomView alloc] init];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bottomView];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(40);
    }];
    
 

    

    
}



@end
