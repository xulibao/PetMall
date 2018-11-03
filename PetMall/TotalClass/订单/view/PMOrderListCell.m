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
    if (firstItem.order_no) {
        text0 = [@"订单编号：" stringByAppendingString:firstItem.order_no];
    }
    
    self.topView.attStr_label0 = [text0 attributedStingWithAttributes:nil];
   self.topView.attStr_label1 = [data.statusText attributedStingWithAttributes:nil];
    float totalPrice = 0.f;
    for (int i = 0; i < data.order_list.count; i++) {
        PMOrderListItem *item = data.order_list[i];
        totalPrice +=[item.pay_price floatValue];
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
    }
    
    _bottomView.tags = data.tagsText;
    _bottomView.tagBtnClick = ^(NSInteger tag) {
        if ([self.cellDelegate respondsToSelector:@selector(PMOrderListCellClick)]) {
            [self.cellDelegate PMOrderListCellClick];
        }
    };
    _bottomView.label0.text = [NSString stringWithFormat:@"共%lu件商品 合计：¥%@",(unsigned long)data.order_list.count,@(totalPrice)];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(-10);
        make.top.mas_equalTo(self.bgView.mas_bottom);
        make.height.mas_equalTo(40);
    }];
//    [_bottomView setNeedsLayout];
    
  
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
