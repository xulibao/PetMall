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
@property(nonatomic, copy) NSString *price; //1非购物车购买2购物车购买
@property(nonatomic, copy) NSString *flag; //1非购物车购买2购物车购买

@end
