//
//  NSString+STValid.h
//  SnailTruck
//
//  Created by imeng on 4/11/17.
//  Copyright © 2017 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const STNumberRegex;
extern NSString *const STPhoneNumberRegex;
extern NSString *const STPriceRegex;
extern NSString *const STChineseIDCardRegex;

@interface NSString (STValid)

- (NSString *)removingSapceString;

- (NSString *)removeingSpecialString:(NSString *)specialString;

- (BOOL)isValidWithRegex:(NSString *)regex;

//精确的身份证号码有效性检测
- (BOOL)accurateVerifyIDCardNumber;

/** 银行卡号有效性问题Luhn算法
 *  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
 *  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
 *  16 位卡号校验位采用 Luhm 校验方法计算：
 *  1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
 *  2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
 *  3，将加法和加上校验位能被 10 整除。
 */
- (BOOL)bankCardluhmVerify;

@end
