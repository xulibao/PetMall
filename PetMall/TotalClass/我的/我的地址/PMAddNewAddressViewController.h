//
//  PMAddNewAddressViewController.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "STBaseViewController.h"
#import "PMMyAddressItem.h"
typedef void(^AddressBlock)(PMMyAddressItem *model);

@interface PMAddNewAddressViewController : STBaseViewController
/** 如果为编辑地址则需传入model **/
@property (nonatomic, strong) PMMyAddressItem         * model;

/** 保存收货地址信息后的地址信息回调 **/
@property (nonatomic, copy) AddressBlock                   addressBlock;
@end
