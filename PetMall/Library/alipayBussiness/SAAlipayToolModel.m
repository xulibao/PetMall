//
//  SAAlipayToolModel.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/3/8.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SAAlipayToolModel.h"
#import "AlipaySdkConfig.h"
@implementation SAAlipayToolModel
- (NSString *)orderNo{
    if ([_orderNo isKindOfClass:[NSNumber class]]) {
        NSNumber *tempTradeNO = (NSNumber *)_orderNo;
        _orderNo = tempTradeNO.stringValue;
    }
    return _orderNo;
}
- (BOOL)MD5IsRight{
    //    盐：woniu365
    //    价格+订单号+盐  组合成字符串之后MD5
    NSString *orignStr = [NSString stringWithFormat:@"%@%@%@",self.price,_orderNo,SALT_key];
    NSString *MD5Str16 = [NSString MD5ForLower16Bate:orignStr];
    NSString *MD5Str32 = [NSString MD5ForLower32Bate:orignStr];
    BOOL isRight = [MD5Str16 isEqualToString:_secretStr] || [MD5Str32 isEqualToString:_secretStr];
    return isRight;
}
@end
