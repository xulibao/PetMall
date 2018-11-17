//
//  PMConfirmOrderViewController.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/10.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "STBaseViewController.h"

@interface PMConfirmOrderViewController : STBaseViewController

@property(nonatomic, copy) NSString *order_id;
@property(nonatomic, copy) NSString *goods_id; //非购物车购买传商品id
@property(nonatomic, copy) NSString *list_id; //非购物车购买传价格id
@property(nonatomic, copy) NSString *price; //zongjia

@end
