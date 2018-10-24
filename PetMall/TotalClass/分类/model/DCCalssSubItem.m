//
//  DCCalssSubItem.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCCalssSubItem.h"

@implementation DCCalssSubItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"cate_id":@"id"};
}

- (NSString *)img{
    if (![_img hasPrefix:[STNetworking host]]) {
        _img = [NSString stringWithFormat:@"%@%@",[STNetworking host],_img];
    }
    return _img;
}
@end
