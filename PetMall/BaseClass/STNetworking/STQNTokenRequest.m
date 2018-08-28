//
//  STQNTokenRequest.m
//  SnailTruck
//
//  Created by imeng on 3/3/17.
//  Copyright © 2017 GhGh. All rights reserved.
//

#import "STQNTokenRequest.h"

@implementation STQNTokenResponseEntity

@end

@implementation STQNTokenRequest

- (NSString *)requestUrl {
    return API_auction_token;
}
- (GARequestMethod)requestMethod {
    return GARequestMethodPOST;
}

@end
