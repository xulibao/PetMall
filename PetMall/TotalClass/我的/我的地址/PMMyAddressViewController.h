//
//  PMMyAddressViewController.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "SAInfoListViewController.h"
#import "PMMyAddressItem.h"

@interface PMMyAddressViewController : SAInfoListViewController

@property(nonatomic, copy) void (^callBack)(PMMyAddressItem *item);

@end
