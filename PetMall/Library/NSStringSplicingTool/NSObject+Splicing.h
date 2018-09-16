//
//  NSObject+XLB_Sum.h
//  Blcok
//
//  Created by 徐礼宝 on 2018/5/21.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPStringSplicingMaker.h"
@interface NSObject (Splicing)

-(NSString *)mas_makeSplicing:(void(^)(SPStringSplicingMaker *maker))make;



@end
