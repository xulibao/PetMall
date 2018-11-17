//
//  WXPayClient.m
//  SnailTruck
//
//  Created by GhGh on 16/1/11.
//  Copyright © 2016年 GhGh. All rights reserved.
//

#import "WXPayClient.h"
#import "WeiXinConfiging.h"
static WXPayClient *sharedClient = nil;
@interface WXPayClient ()
@property (nonatomic, copy) NSString *orderID;//订单编号
@property (nonatomic, copy) NSString *price;//价格
@property (nonatomic, copy) NSString *orderName;//订单名称
@property (nonatomic, copy) NSString *orderDesc;//订单描述

@property (nonatomic, copy) NSString *timeStamp;
@property (nonatomic, copy) NSString *nonceStr;
@property (nonatomic, copy) NSString *traceId;
@end
@implementation WXPayClient
#pragma mark - Public

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[WXPayClient alloc] init];
    });
    return sharedClient;
}
// 解析微信返回字段
- (void)payByWeiXinDict:(NSDictionary *)weiDict
{
//    if ([weiDict[@"resCode"] integerValue] == 1) {
//       [self payField:weiDict[@"resMsg"]];
//       return;
//    }
    NSDictionary *dict = weiDict[@"data"];
    if (![dict isKindOfClass:[NSDictionary class]] || weiDict.count == 0 || dict.count == 0) {
        [self payField:@"支付参数出错,支付失败"];
        return;
    }
        //调起微信支付
    PayReq *req             = [[PayReq alloc] init];
    req.partnerId           = WXPartnerId;
    req.prepayId            = [dict objectForKey:@"prepayid"];
    req.nonceStr            = [dict objectForKey:@"noncestr"];
    req.timeStamp           = [[dict objectForKey:@"timestamp"] intValue];
    req.package             = package_Sign_WXPay;
    req.sign                = [dict objectForKey:@"sign"];
    [WXApi sendReq:req];
}
#pragma mark - 微信支付回调函数
- (void)onResp:(BaseResp *)resp
{
    switch (resp.errCode) {
        case 0:
        {
            [self paySucessed];
        }
            break;
        case -1:
        {
            [self payField:@"支付失败"];
        }
            break;
        case -2:
        {
            [self payField:@"取消支付"];
        }
            break;
            
        default:
        {
            [self payField:@"支付失败"];
        }
            break;
    }
}

#pragma mark - 支付失败
- (void)payField:(NSString *)fieldStr
{
    [[NSNotificationCenter defaultCenter] postNotificationName:payFaild object:nil];
    if (self.wxPayAilFieldBlock) {
        self.wxPayAilFieldBlock(fieldStr);
    };
}
#pragma mark - 支付成功
- (void)paySucessed
{
    [[NSNotificationCenter defaultCenter] postNotificationName:paySuccesed object:nil];
    if (self.wxPaySucessedCallBack) {
        self.wxPaySucessedCallBack();
    }
}
@end
