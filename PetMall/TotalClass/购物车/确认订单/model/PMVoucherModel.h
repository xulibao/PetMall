//
//  PMVoucherModel.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/11.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMVoucherModel : NSObject
@property(nonatomic, assign) BOOL isEnable;
@property(nonatomic, copy) NSString *price;
@property(nonatomic, assign) BOOL isSelect;
@end
