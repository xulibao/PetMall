//
//  SAUserInfoEntity.m
//  SnailAuction
//
//  Created by imeng on 16/03/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "SAUserInfoEntity.h"

@implementation SAUserInfoEntity

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"userId":@"id"};
}

- (void)setContactMobile:(NSString *)contactMobile{
//    _contactMobile = contactMobile;
//    [self store];
}

//- (void)store{
//    [[SAApplication sharedApplication] storeUserInfoMapper:[self mj_keyValues]];
//}
@end
