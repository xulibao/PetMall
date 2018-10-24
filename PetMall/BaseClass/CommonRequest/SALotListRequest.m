//
//  SALotListRequest.m
//  SnailAuction
//
//  Created by imeng on 05/03/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "SALotListRequest.h"

@implementation SALotListResponseEntity

#pragma mark - MJKeyValue

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"lotList":@"SALotInfoItem"};
}

@end

@implementation SALotListRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        _source = SALotListSourceOther;
        _type = SAAuctionStatusAll;
    }
    return self;
}

- (NSString *)resKeyPath {
    return @"data";
}

- (Class)resClass {
    return [SALotListResponseEntity class];
}

//- (NSString *)requestUrl {
//    return API_auction_lotList;
//}

@end

@implementation SALotListDirectRequest

- (id)requestArgument {
    return _directParameters;
}

@end
