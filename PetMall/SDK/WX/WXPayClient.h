//
//  WXPayClient.h
//  SnailTruck
//
//  Created by GhGh on 16/1/11.
//  Copyright © 2016年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
typedef void (^WXPaySucessed)();
typedef void (^WXPayField)(NSString *fieldStr);
@interface WXPayClient : NSObject<WXApiDelegate>
+ (instancetype)shareInstance;
// 唤醒支付
- (void)payByWeiXinDict:(NSDictionary *)weiDict;
@property (nonatomic, copy)WXPaySucessed wxPaySucessedCallBack;
@property (nonatomic, copy)WXPayField wxPayAilFieldBlock;
@end
