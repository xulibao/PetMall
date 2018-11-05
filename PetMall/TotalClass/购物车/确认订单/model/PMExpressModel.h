//
//  PMExpressModel.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/12.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMExpressModel : NSObject

@property(nonatomic, copy) NSString *express_title;
@property(nonatomic, copy) NSString *express_id;
@property(nonatomic, copy) NSString *express_price;

@property(nonatomic, assign) BOOL isSelect;
@end
