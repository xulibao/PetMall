//
//  PMHomeSubModel.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/10/25.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import "PMHomeSubModel.h"

@implementation PMHomeSubBroadCastModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"broadCastId":@"id"};
}

- (NSString *)img{
    if (![_img hasPrefix:[STNetworking host]]) {
        _img = [NSString stringWithFormat:@"%@%@",[STNetworking host],_img];
    }
    return _img;
}
@end

@implementation PMHomeSubNavigationModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"navigationId":@"id"};
}

- (NSString *)img{
    if (![_img hasPrefix:[STNetworking host]]) {
        _img = [NSString stringWithFormat:@"%@%@",[STNetworking host],_img];
    }
    return _img;
}
@end

@implementation PMHomeSubModel
+(NSDictionary *)mj_objectClassInArray
{
    return @{ @"Broadcast" : @"PMHomeSubBroadCastModel",
              @"navigation" : @"PMHomeSubNavigationModel",
              @"classification" : @"PMHomeSubNavigationModel",
              };
}
@end
