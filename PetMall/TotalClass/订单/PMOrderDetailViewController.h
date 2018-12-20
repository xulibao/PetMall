//
//  PMOrderDetailViewController.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "SAInfoListViewController.h"

@interface PMOrderDetailViewController : SAInfoListViewController
@property(nonatomic, copy) NSString *status;
@property(nonatomic, copy) NSString *user_id;
@property(nonatomic, copy) NSString *order_no;
@property(nonatomic, copy) NSString *pay_price;
@end
