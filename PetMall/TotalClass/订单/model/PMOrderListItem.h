//
//  SAOrderListItem.h
//  SnailAuction
//
//  Created by imeng on 26/02/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "STCommonTableViewBaseItem.h"
typedef NS_ENUM(NSUInteger, PMOrderOrderType) {
    PMOrderOrderTypeAll = 0,           // 全部订单
    PMOrderOrderTypePayment = 1,           // 待付款
    PMOrderOrderTypeTransfer = 2,           // 待发货
    PMOrderOrderTypeReceive = 3,           // 待收货
    PMOrderOrderTypeComment = 4,           // 待评价
    PMOrderOrderTypeFail = 6,           // 失败

};
@interface PMOrderItem : STCommonBaseTableRowItem

@property(nonatomic, strong) NSArray *order_list;
@property(nonatomic, copy) NSString *order_no;//    订单编号    string
@property(nonatomic, copy) NSString *status;//    string
@property(nonatomic, copy) NSString *pay_price;//   钱
@property(nonatomic, copy) NSString *freight_price;//   钱
@property(nonatomic, strong) NSString *statusText;
@property(nonatomic, strong) NSArray<NSAttributedString*> *tagsText;

@end
@interface PMOrderListItem : STCommonBaseTableRowItem

@property(nonatomic, copy) NSString *order_no;//    订单编号    string
//订单状态(0.无效,1.新订单,2.待发货,3.已发货,4.已收货,5.已完成,6.已退货及退款,7已评论,8申请退款,9退款失败)
@property(nonatomic, copy) NSString *status;//    string

/** 图片URL */
@property (nonatomic, copy ) NSString *goods_logo;
/** 商品标题 */
@property (nonatomic, copy ) NSString *main_title;
/** 商品小标题 */
@property (nonatomic, copy ) NSString *goods_title;
/** 商品价格 */
@property (nonatomic, copy ) NSString *pay_price;

@property (nonatomic, copy ) NSString *market_price;
/** 属性 */
@property (nonatomic, copy ) NSString *goods_spec;
/** 数量 */
@property(nonatomic, strong) NSString *goods_shul;

@property(nonatomic, copy) NSString *freight_price;

@property(nonatomic, strong) NSString *jifen;

@property(nonatomic, assign) BOOL isSelect;

//@property(nonatomic, assign) PMCellLocationType cellLocationType;

@end
