//
//  STRequest.m
//  SnailTruck
//
//  Created by imeng on 2017/12/15.
//  Copyright © 2017年 GhGh. All rights reserved.
//

#import "STRequest.h"
#import "STNetworking.h"
#import "STAPIResponse.h"

@implementation STRequest

- (NSString *)baseUrl{
    return [STNetworking stHost];
}

@end
