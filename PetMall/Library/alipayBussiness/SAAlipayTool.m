//
//  SAAlipayTool.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/3/8.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SAAlipayTool.h"
#import "AlipaySdkConfig.h"
//支付宝客户端头文件
#import <AlipaySDK/AlipaySDK.h>
#import "APOrderInfo.h"
#import "APRSASigner.h"
@interface SAAlipayTool()
@property (nonatomic, strong) NSMutableDictionary *lastBackDataM;
@property (nonatomic, strong) SAAlipayToolModel *moneyModel;
@end

@implementation SAAlipayTool
DEFINE_SINGLETON_FOR_CLASS(SAAlipayTool)

//通过客户端
- (void)payByAilPay:(SAAlipayToolModel *)model{
    // 自定义
    self.moneyModel = model;
//    NSString *appScheme = @"com.guangan.snailTruck.alipay";
//    NSString *orderInfo = [self getOrderInfo];  //将商品信息拼接成字符串
//    NSString *signedStr = [self doRsa:orderInfo];
//    //将签名成功字符串格式化为订单字符串,请严格按照该格式
//    NSString *orderString = nil;
//    if (signedStr != nil) {
//        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"", orderInfo, signedStr, @"RSA"];
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            // 支付结果
//            [self paySucess:resultDic];
//        }];
//    }
    
    // 重要说明
    // 这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    // 真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    // 防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = WoPaiCheAppID;
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = PartnerPrivKey;
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"                                                                       message:@"缺少appId或者私钥,请检查参数设置"
                                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           
                                                       }];
        [alert addAction:action];
//        [self presentViewController:alert animated:YES completion:^{ }];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    APOrderInfo* order = [APOrderInfo new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    order.notify_url = model.alipayCallBackUrl;
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
//    order.sign_type = @"RSA";
    // NOTE: 商品数据
    order.biz_content = [APBizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.seller_id = SellerID;
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = model.orderNo; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", [model.price doubleValue]]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"com.snailauction.www.alipay";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            // 支付结果
            [self paySucess:resultDic];
        }];
    }
}
#pragma mark - 支付结果
- (void)paySucess:(NSDictionary *)resultDic{
    NSString *resultString = resultDic[@"resultStatus"];
    if ([resultString isEqualToString:@"9000"]) {// 支付成功
        [self paySucessed];
    }else if ([resultString isEqualToString:@"6001"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:payFaild object:nil];
        if (self.ailPayAilFieldBlock) {
            self.ailPayAilFieldBlock(@"您中途取消支付,支付失败");
        }
    }else{
        if (self.ailPayAilFieldBlock) {
            [[NSNotificationCenter defaultCenter] postNotificationName:payFaild object:nil];
            self.ailPayAilFieldBlock(resultDic[@"memo"]);
        }
    }
}
#pragma mark - 支付成功
- (void)paySucessed{
    [[NSNotificationCenter defaultCenter] postNotificationName:paySuccesed object:nil];
    if (self.ailPaySucessedCallBack) {
        self.ailPaySucessedCallBack();
    }
}
//// 私有方法
//- (NSString*)getOrderInfo{
//    //拼接商品信息
//    APOrderInfo *order = [[APOrderInfo alloc] init];
//    order.app_id = PartnerID;
////    order.seller = SellerID;
////    order.productName = [STUnifiedAcceptMoneyBusiness shareInstance].moneyModel.productName;
//    order.tradeNO = self.moneyModel.tradeNO;  //订单ID（由商家自行制定）   ///需要赋值
////    order.productDescription = [STUnifiedAcceptMoneyBusiness shareInstance].moneyModel.productDescription;
//    order.amount = self.moneyModel.price;
//
//    //回调URL
//    if (self.moneyModel.alipayCallBackUrl.length > 0) {
//        order.notifyURL = self.moneyModel.alipayCallBackUrl;
//    }else{
////        order.notifyURL = [NSString stringWithFormat:@"%@%@",kALPayServerAddress,alipay_orderPayResultNotify_Page];
//    }
//
//    // 对64位优化方法
//    order.service = @"mobile.securitypay.pay";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
//    order.showUrl = @"m.alipay.com";
//    // 对64位优化方法
//    //    GALOG(@"[order description]------%@",[order description]);
//    return [order description];
//}
// 私有方法
//- (NSString *)doRsa:(NSString*)orderInfo
//{
//    id<DataSigner> signer;
//    // 私有 PartnerPrivKey
//    signer = CreateRSADataSigner(PartnerPrivKey);
//    NSString *signedString = [signer signString:orderInfo];
//    return signedString;
//}
@end
