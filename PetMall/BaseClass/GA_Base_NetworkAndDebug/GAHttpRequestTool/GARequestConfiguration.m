//
//  GARequestHostConfiguration.m
//  GA_Base_NetworkAndDebug
//
//  Created by imeng on 12/13/16.
//  Copyright © 2016 GhGh. All rights reserved.
//

#import "GARequestConfiguration.h"
#import "GADebugServer.h"
#import <YTKNetwork.h>

NSString *GAURLHOSTNAMEKEY = @"GAURLHostNameKey";
NSString *GAURLHOSTENABLEDKEY = @"GAURLHostEabledKey";
NSString *GAIMAGEURLHOSTKEY = @"GAImageURLHostKey";

static NSString *StaticHost;

@implementation GARequestConfiguration

#pragma mark - PriveMethod

+ (NSMutableDictionary<NSString*, NSDictionary<NSString*,NSString*>*> *)serviceHosts {
    static NSMutableDictionary *StaticServiceHosts = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        StaticServiceHosts = [NSMutableDictionary dictionary];
    });
    return StaticServiceHosts;
}

#pragma mark - PublicMethod

+ (NSString *)defaultHost {
    return StaticHost;
}

+ (void)addServiceHosts:(NSDictionary<NSString*, NSDictionary<NSString*,NSString*>*> *)serviceHosts {
    [[self serviceHosts] addEntriesFromDictionary:serviceHosts];
    
    [serviceHosts enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSDictionary<NSString *,NSString *> * _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *host = key;
        NSString *hostName = obj[GAURLHOSTNAMEKEY];
        BOOL enable = [obj[GAURLHOSTENABLEDKEY] boolValue];
        
        if (enable) {
            [self setHost:host];
            NSAssert([host hasPrefix:@"http://"] || [host hasPrefix:@"https://"], @"host必须为http或https");
            NSAssert(!StaticHost, @"只能有一个Host为开启状态");
            StaticHost = host;
        }
        
        [[GADebugServer sharedInstance] addServerName:hostName url:host enable:enable];
    }];
    
    NSAssert(StaticHost, @"请打开一个Host为开启状态");
}

#pragma mark - Override Method See YTKNetworkConfig

+ (NSString *)host {
    return [YTKNetworkConfig sharedConfig].baseUrl;
}

+ (void)setHost:(NSString *)host {
    [YTKNetworkConfig sharedConfig].baseUrl = host;
}

+ (NSArray<id<YTKUrlFilterProtocol>> *)urlFilters {
    return [YTKNetworkConfig sharedConfig].urlFilters;
}

+ (NSArray<id<YTKCacheDirPathFilterProtocol>> *)cacheDirPathFilters {
    return [YTKNetworkConfig sharedConfig].cacheDirPathFilters;
}

+ (AFSecurityPolicy *)securityPolicy {
    return [YTKNetworkConfig sharedConfig].securityPolicy;
}

+ (void)setSecurityPolicy:(AFSecurityPolicy *)securityPolicy {
    [YTKNetworkConfig sharedConfig].securityPolicy = securityPolicy;
}

+ (BOOL)debugLogEnabled {
    return [YTKNetworkConfig sharedConfig].debugLogEnabled;
}

+ (void)setDebugLogEnabled:(BOOL)enable {
    [YTKNetworkConfig sharedConfig].debugLogEnabled = enable;
}

///  SessionConfiguration will be used to initialize AFHTTPSessionManager. Default is nil.
+ (NSURLSessionConfiguration *)sessionConfiguration {
    return [YTKNetworkConfig sharedConfig].sessionConfiguration;
}

+ (void)setSessionConfiguration:(NSURLSessionConfiguration *)sessionConfiguration {
    [YTKNetworkConfig sharedConfig].sessionConfiguration = sessionConfiguration;
}

- (void)addUrlFilter:(id<YTKUrlFilterProtocol>)filter {
    [[YTKNetworkConfig sharedConfig] addUrlFilter:filter];
}

///  Remove all URL filters.
- (void)clearUrlFilter {
    [[YTKNetworkConfig sharedConfig] clearUrlFilter];
}
///  Add a new cache path filter
- (void)addCacheDirPathFilter:(id<YTKCacheDirPathFilterProtocol>)filter {
    [[YTKNetworkConfig sharedConfig] addCacheDirPathFilter:filter];
}

///  Clear all cache path filters.
- (void)clearCacheDirPathFilter {
    [[YTKNetworkConfig sharedConfig] clearCacheDirPathFilter];
}

@end
