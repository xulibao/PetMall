//
//  SAMenuRecordModel.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/3/14.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SAMenuRecordModel.h"

@implementation SAMenuRecordModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"name":@"tmName",@"serveID":@"tmId"};
}

- (NSString *)name{
    if (!_name) {
        if (self.tbName) {
            _name = self.tbName;
        }
    }
    return _name;
}

- (NSString *)serveID{
    if (!_serveID) {
        if (self.tbId) {
            _serveID = self.tbId;
        }
    }
    return _serveID;
}
@end
