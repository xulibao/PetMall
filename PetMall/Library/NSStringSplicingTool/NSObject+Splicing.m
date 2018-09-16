//
//  NSObject+XLB_Sum.m
//  Blcok
//
//  Created by 徐礼宝 on 2018/5/21.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "NSObject+Splicing.h"
@implementation NSObject (Splicing)

-(NSString *)mas_makeSplicing:(void(^)(SPStringSplicingMaker *maker))make{
    SPStringSplicingMaker *maker = [[SPStringSplicingMaker alloc] init];
    maker.result = @"";
    make(maker);
    return maker.result;
}
@end
