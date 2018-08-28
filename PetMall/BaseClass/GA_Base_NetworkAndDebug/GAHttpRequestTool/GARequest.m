//
//  GARequest.m
//  GA_Base_NetworkAndDebug
//
//  Created by imeng on 12/12/16.
//  Copyright © 2016 GhGh. All rights reserved.
//

#import "GARequest.h"
#import <MJExtension.h>

@interface GARequest () <MJKeyValue>

@end

@implementation GARequest

#pragma mark PublicMethod

- (NSObject *)responseEntity {
    if (!_responseEntity) {
        NSString *requestClass = NSStringFromClass(self.class);
        NSString *prefixString = [requestClass substringWithRange:NSMakeRange(0, [requestClass rangeOfString:@"Request"].location)];
        
        NSString *classString = [prefixString stringByAppendingString:@"ResponseEntity"];
        Class responseObjectClass = NSClassFromString(classString);
        NSAssert1(responseObjectClass, @"没有找到", classString);
        _responseEntity = [responseObjectClass mj_objectWithKeyValues:self.responseJSONObject];
    }
    return _responseEntity;
}

#pragma - NSObject Override

- (instancetype)init {
    NSAssert(![self isMemberOfClass:GARequest.class], @"请子类化 GARequest 后使用");
    return [super init];
}

- (NSString *)description {
    NSString *description = [super description];
    if (_responseEntity) {
        NSString *responseEntity = NSStringFromClass([self.responseEntity class]);
        description = [description stringByAppendingFormat:@"<%@: %p>", responseEntity, self.responseEntity];
    }
    return description;
}

#pragma - YTKRequest Override

- (__kindof id)requestArgument {
    return [self mj_keyValues];
}

#pragma mark - MJKeyValue

+ (NSArray *)mj_ignoredPropertyNames {
    static NSArray *blacklist;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *tempList = [NSMutableArray array];
        [GARequest mj_enumerateProperties:^(MJProperty *property, BOOL *stop) {
            [tempList addObject:property.name];
        }];
        blacklist = [NSArray arrayWithArray:tempList];
    });
    
    return blacklist;
}

@end
