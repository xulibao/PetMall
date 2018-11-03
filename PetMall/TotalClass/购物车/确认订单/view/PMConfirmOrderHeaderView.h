//
//  PMConfirmOrderHeaderView.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/10.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMMyAddressItem.h"
@interface PMConfirmOrderHeaderView : UIView

@property(nonatomic, strong) PMMyAddressItem *item;
@property(nonatomic, copy) void (^clickHeader)();
@end
