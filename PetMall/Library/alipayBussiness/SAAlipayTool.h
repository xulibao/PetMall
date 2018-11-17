//
//  SAAlipayTool.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/3/8.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SAAlipayToolModel.h"
typedef void (^AilPaySucessed)();
typedef void (^AilPayField)(NSString *fieldStr);

@interface SAAlipayTool : NSObject
DEFINE_SINGLETON_FOR_HEADER(SAAlipayTool)
@property (nonatomic, copy)AilPaySucessed ailPaySucessedCallBack;
@property (nonatomic, copy)AilPayField ailPayAilFieldBlock;
- (void)payByAilPay:(SAAlipayToolModel *)model;
#pragma mark - 支付结果 否
- (void)paySucess:(NSDictionary *)resultDic;

@end
