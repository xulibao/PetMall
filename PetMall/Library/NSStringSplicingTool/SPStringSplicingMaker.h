//
//  XLBSumMaker.h
//  Blcok
//
//  Created by 徐礼宝 on 2018/5/21.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SPStringSplicingMaker : NSObject
@property(nonatomic, copy)  NSString *result;

-(SPStringSplicingMaker *(^)(id str))add;

@end
