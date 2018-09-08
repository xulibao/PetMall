//
//  PMGoodsDetailViewController.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/8.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "STBaseViewController.h"

@interface PMGoodsDetailViewController : STBaseViewController

/* 商品标题 */
@property (strong , nonatomic)NSString *goodTitle;
/* 商品价格 */
@property (strong , nonatomic)NSString *goodPrice;
/* 商品小标题 */
@property (strong , nonatomic)NSString *goodSubtitle;
/* 商品图片 */
@property (strong , nonatomic)NSString *goodImageView;

/* 商品轮播图 */
@property (copy , nonatomic)NSArray *shufflingArray;

@end
