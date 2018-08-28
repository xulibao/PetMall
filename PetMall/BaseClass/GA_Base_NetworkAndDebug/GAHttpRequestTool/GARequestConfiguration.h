//
//  GARequestHostConfiguration.h
//
//  GA_Base_NetworkAndDebug
//
//  Created by imeng on 12/13/16.
//  Copyright © 2016 GhGh. All rights reserved.
//

#import <YTKNetwork.h>

extern NSString *GAURLHOSTNAMEKEY; //host 的名字
extern NSString *GAURLHOSTENABLEDKEY; //host 是否开启
extern NSString *GAIMAGEURLHOSTKEY; //imageHost url

@interface GARequestConfiguration : NSObject

#pragma mark - PublicMethod

/**
 默认的Host（ addServiceHosts时 GAURLHOSTENABLEDKEY 开启的URL）

 @return 字符串Host URL
 */
+ (NSString *)defaultHost;

/**
 添加host
 
 @param serviceHosts 字典中一级key 为host eg：http://baidu.com 子集中为 GAURLHOSTNAMEKEY GAURLHOSTENABLEDKEY GAIMAGEURLHOSTKEY
 */
+ (void)addServiceHosts:(NSDictionary<NSString*, NSDictionary<NSString*,NSString*>*> *)serviceHosts;

#pragma mark - Override Method See YTKNetworkConfig

+ (NSString *)host;
+ (void)setHost:(NSString *)host;

///  URL filters. See also `YTKUrlFilterProtocol`
+ (NSArray<id<YTKUrlFilterProtocol>> *)urlFilters;
///  Cache path filters. See also `YTKCacheDirPathFilterProtocol`.
+ (NSArray<id<YTKCacheDirPathFilterProtocol>> *)cacheDirPathFilters;

///  Security policy will be used by AFNetworking. See also `AFSecurityPolicy`.
+ (AFSecurityPolicy *)securityPolicy;
+ (void)setSecurityPolicy:(AFSecurityPolicy *)securityPolicy;

///  Whether to log debug info. Default is NO;
+ (BOOL)debugLogEnabled;
+ (void)setDebugLogEnabled:(BOOL)enable;

///  SessionConfiguration will be used to initialize AFHTTPSessionManager. Default is nil.
+ (NSURLSessionConfiguration *)sessionConfiguration;
+ (void)setSessionConfiguration:(NSURLSessionConfiguration *)sessionConfiguration;

///  Add a new URL filter.
- (void)addUrlFilter:(id<YTKUrlFilterProtocol>)filter;
///  Remove all URL filters.
- (void)clearUrlFilter;
///  Add a new cache path filter
- (void)addCacheDirPathFilter:(id<YTKCacheDirPathFilterProtocol>)filter;
///  Clear all cache path filters.
- (void)clearCacheDirPathFilter;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end
