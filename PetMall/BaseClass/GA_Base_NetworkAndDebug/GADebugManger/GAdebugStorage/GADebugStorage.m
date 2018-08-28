//
//  GADebugStorage.m
//  GA_Base_FrameWork
//
//  Created by 王光辉 on 15/11/7.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "GADebugStorage.h"

@implementation GADebugStorage

+ (GADebugStorage *)sharedInstance {
    static GADebugStorage *debugStorage = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        debugStorage = [[GADebugStorage alloc] init];
        debugStorage.enabled = YES; // 模快启动 debug
    });
    return debugStorage;
}

- (NSArray *)userDefaults {
    //    if (!self.enabled) {
    //        return nil;
    //    }
#pragma mark - 默认开启
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionaryWithDictionary:
                                     [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];
    [dataDict removeObjectForKey:@"AppleITunesStoreItemKinds"];
    [dataDict removeObjectForKey:@"AppleKeyboards"];
    [dataDict removeObjectForKey:@"AppleKeyboardsExpanded"];
    [dataDict removeObjectForKey:@"AppleLanguages"];
    [dataDict removeObjectForKey:@"AppleLocale"];
    [dataDict removeObjectForKey:@"NSInterfaceStyle"];
    [dataDict removeObjectForKey:@"NSLanguages"];
    [dataDict removeObjectForKey:@"UIDisableLegacyTextView"];
    
    NSArray *keys = [dataDict allKeys];
    NSMutableArray *keyArray = [NSMutableArray array];
    for (NSString *key in keys) {
        if ([key rangeOfString:@"WebKit"].length) {
            continue;
        }
        [keyArray addObject:key];
    }
    NSArray *newKeys = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 localizedCaseInsensitiveCompare:obj2];
    }];
    
    NSMutableArray *userDefaults = [NSMutableArray array];
    for (NSString *key in newKeys) {
        GADebugUserDefaultModel *userDefault = [[GADebugUserDefaultModel alloc] init];
        userDefault.key = key;
        userDefault.value = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:key]];
        [userDefaults addObject:userDefault];
    }
    return userDefaults;
}

- (NSArray *) keychains{
    //    if (!self.enabled) {
    //        return nil;
    //    }
#pragma mark - 默认开启
    NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge id)(kSecClassGenericPassword),
                           (__bridge id)kSecClass,
                           (__bridge id)kSecMatchLimitAll,
                           (__bridge id)kSecMatchLimit,
                           (__bridge id)kCFBooleanTrue,
                           (__bridge id)kSecReturnAttributes,
                           (__bridge id)kCFBooleanTrue,
                           (__bridge id)kSecReturnData,nil];
    CFTypeRef result = NULL;
    SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
    
    NSArray *keychainArray = (__bridge NSArray *)result;
    NSMutableArray *tkeychainArray = [NSMutableArray array];
    for (NSDictionary *dict in keychainArray) {
        if ([dict objectForKey:@"acct"] && ![[dict objectForKey:@"acct"] isEqualToString:@""]) {
            [tkeychainArray addObject:[dict objectForKey:@"acct"]];
        }else if([dict objectForKey:@"gena"] && ![[dict objectForKey:@"gena"] isEqualToString:@""]){
            [tkeychainArray addObject:[dict objectForKey:@"gena"]];
        }
    }
    // 去重
    NSMutableArray *newKeys = [tkeychainArray valueForKeyPath:@"@distinctUnionOfObjects.self"];
    
    // 构造返回keychains
    NSMutableArray *keychains = [NSMutableArray array];
    for (NSString *key in newKeys) {
        NSString *value = [self readValueForKey:key andDomain:nil];
        if (value && key) {
            GADebugKeychainModel *keychain = [[GADebugKeychainModel alloc] init];
            keychain.key = key;
            keychain.value = value;
            [keychains addObject:keychain];
        }
    }
    return keychains;
}

- (NSString *)appIdentifier {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    static NSString *identifier = nil;
    if (nil == identifier) {
        identifier = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    }
    return identifier;
#else	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    return @"";
#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
}

- (NSString *)readValueForKey:(NSString *)key andDomain:(NSString *)domain {
    if (nil == key)
        return nil;
    
    if (nil == domain){
        domain = @"default.";
    }
    
    domain = [domain stringByAppendingString:[self appIdentifier]];
    
    NSArray *keys = [[NSArray alloc] initWithObjects:
                     (__bridge NSString *)kSecClass,
                     (__bridge id)kSecAttrAccount,
                     (__bridge id)kSecAttrService, nil];
    
    NSArray *objects = [[NSArray alloc] initWithObjects:
                        (__bridge NSString *)kSecClassGenericPassword,
                        key,
                        domain, nil];
    
    NSMutableDictionary *query = [[NSMutableDictionary alloc] initWithObjects:objects
                                                                      forKeys:keys];
    NSMutableDictionary *attributeQuery = [query mutableCopy];
    [attributeQuery setObject:(__bridge id)kCFBooleanTrue
                       forKey:(__bridge id)kSecReturnAttributes];
    
    CFTypeRef attributeResult = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)attributeQuery, &attributeResult);
    if (noErr != status)
        return nil;
    
    NSMutableDictionary *passwordQuery = [query mutableCopy];
    [passwordQuery setObject:(__bridge id)kCFBooleanTrue
                      forKey:(__bridge id)kSecReturnData];
    
    CFTypeRef resultData = NULL;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)passwordQuery, &resultData);
    
    if (noErr != status)
        return nil;
    
    if (nil == resultData)
        return nil;
    
    NSString *password = [[NSString alloc] initWithData:(__bridge NSData *)resultData
                                               encoding:NSUTF8StringEncoding];
    return password;
}

@end
