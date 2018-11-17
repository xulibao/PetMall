//
//  SAWXPayRequest.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/3/12.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SAWXPayRequest.h"

@implementation SAWXPayRequest

#pragma mark - STResponseValidDelegate

- (BOOL)validateWithRequest:(SARequest *)request error:(NSError * __autoreleasing *)error {
    return YES;
}

- (GARequestMethod)requestMethod{
    return GARequestMethodPOST;
}
- (NSString *)requestUrl {
    return API_wechat_pay;
}


@end
