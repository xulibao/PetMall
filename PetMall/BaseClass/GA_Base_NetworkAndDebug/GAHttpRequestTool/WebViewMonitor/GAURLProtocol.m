//
//  GAURLProtocol.m
//  GA_Base_NetworkAndDebug
//
//  Created by GhGh on 2017/6/9.
//  Copyright © 2017年 GhGh. All rights reserved.
//

#import "GAURLProtocol.h"
#import "GAURLSessionConfiguration.h"
#import "GADebugNetworkModel.h"
#import "GADebugManager.h"
#ifdef DEBUG

static NSString * const URLProtocolHandledKey = @"URLProtocolHandledKey";
@interface GAURLProtocol ()<NSURLConnectionDelegate>
@property (nonatomic, strong) NSURLConnection *connection;

@end
@implementation GAURLProtocol
#pragma mark - init
- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

+ (void)load {
    
}

+ (void)start {
    GAURLSessionConfiguration *sessionConfiguration = [GAURLSessionConfiguration defaultConfiguration];
    [NSURLProtocol registerClass:[GAURLProtocol class]];
    if (![sessionConfiguration isSwizzle]) {
        [sessionConfiguration load];
    }
}

+ (void)end {
    GAURLSessionConfiguration *sessionConfiguration = [GAURLSessionConfiguration defaultConfiguration];
    [NSURLProtocol unregisterClass:[GAURLProtocol class]];
    if ([sessionConfiguration isSwizzle]) {
        [sessionConfiguration unload];
    }
}


/**
 需要控制的请求
 
 @param request 此次请求
 @return 是否需要监控
 */
+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    //只处理http和https请求
    NSString *scheme = [[request URL] scheme];
    if (([scheme caseInsensitiveCompare:@"http"] == NSOrderedSame ||
         [scheme caseInsensitiveCompare:@"https"] == NSOrderedSame))
    {
        //看看是否已经处理过了，防止无限循环
        if ([NSURLProtocol propertyForKey:URLProtocolHandledKey inRequest:request]) {
            return NO;
        }
        return YES;
    }
    return NO;
}
/**
 设置我们自己的自定义请求
 可以在这里统一加上头之类的
 
 @param request 应用的此次请求
 @return 我们自定义的请求
 */
+ (NSURLRequest *) canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

//Compares two requests for equivalence with regard to caching.
+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b
{
    return [super requestIsCacheEquivalent:a toRequest:b];
}

//Starts protocol-specific loading of a request.
- (void)startLoading
{
    NSMutableURLRequest *mutableReqeust = [[self request] mutableCopy];
    //打标签，防止无限循环
    [NSURLProtocol setProperty:@YES forKey:URLProtocolHandledKey inRequest:mutableReqeust];
    self.connection = [NSURLConnection connectionWithRequest:mutableReqeust delegate:self];
}


//tops protocol-specific loading of a request.
- (void)stopLoading
{
    [self.connection cancel];
}

#pragma mark - NSURLConnectionDelegate
/// 网络请求返回数据
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}
// 数据接收
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if(connection.currentRequest.allHTTPHeaderFields || connection.currentRequest.allHTTPHeaderFields.count){
        NSDictionary *dict = connection.currentRequest.allHTTPHeaderFields;
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (string) {
            if ([dict[@"Referer"] rangeOfString:@"html"].length > 2 || [connection.currentRequest.URL.path rangeOfString:@"html"].length > 2) {
                NSString *dataStr = [self responseJSONFromData:data];
                if (dataStr) { // h5页面中的数据请求接口
                    [self saveNetWorkWithConnection:connection receiveData:data];
                }else if([string hasPrefix:@"jQuery"] && [string rangeOfString:@"resCode"].length){//jQuery 请求
                    NSLog(@"------jQuery 请求，%@------",[connection.currentRequest.URL absoluteString]);
                    if ([connection.currentRequest.URL.path hasSuffix:@"js"]) {
                        return;
                    }
                    [self saveNetWorkWithConnection:connection receiveData:data];
                    
                }else if([string rangeOfString:@"<head>"].length > 2){//纯html
                    
                    NSLog(@"-------纯html:%@-------",[connection.currentRequest.URL absoluteString]);
                    if ([connection.currentRequest.URL.path hasSuffix:@"html"]) {
                        [self saveNetWorkWithConnection:connection receiveData:data];
                    }
                }
            }
        }
    }
    [self.client URLProtocol:self didLoadData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    [self.client URLProtocol:self didFailWithError:error];
}

- (void)saveNetWorkWithConnection:(NSURLConnection *)connection receiveData:(NSData *)data{
    GADebugNetwork *debugNetwork = [GADebugManager networkInstance];
    GADebugNetworkModel *requestInfo = [debugNetwork beginRequest];
    requestInfo.method = connection.currentRequest.HTTPMethod;
    // 请求头 处理
    NSString *requestUrl = [connection.currentRequest.URL absoluteString];
    requestInfo.path = [[requestUrl componentsSeparatedByString:@"?"] firstObject];
    requestInfo.type = @"css/html";
    requestInfo.header = connection.currentRequest.URL.path;
    if ([connection.currentRequest.HTTPMethod isEqualToString:@"GET"]) {
        if ([requestUrl componentsSeparatedByString:@"?"].count > 1) {
            requestInfo.body = [self responseJSONFromString:[self URLDecodedString:[[requestUrl componentsSeparatedByString:@"?"] lastObject]]];
        }
        else
        {
            requestInfo.body = @"无";
        }
    }
    else
    {
        requestInfo.body = [self responseJSONFromString:[self URLDecodedString:[[NSString alloc]initWithData:connection.currentRequest.HTTPBody encoding:NSUTF8StringEncoding]]];
    }
    NSString *dataStr = [self responseJSONFromData:data];
    if (dataStr.length > 0) {
        requestInfo.data = dataStr;
    }
    else
    {
        requestInfo.data = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    if (data) {
        requestInfo.size = @(data.length);
    }
    requestInfo.statuscode = @(200);
    [debugNetwork endRequest:requestInfo];
}


//转换json
-(id)responseJSONFromData:(NSData *)data {
    if(data == nil) return nil;
    NSError *error = nil;
    id returnValue = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if(error) {
        //        NSLog(@"JSON Parsing Error: %@", error);
        return nil;
    }
    if (!returnValue || returnValue == [NSNull null]) {
        return nil;
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:returnValue options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

- (id)responseJSONFromString:(NSString *)String
{
    if(String == nil) return nil;
    NSArray *array = [String componentsSeparatedByString:@"&"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (NSString *str in array) {
        NSArray *array = [str componentsSeparatedByString:@"="];
        [dic setValue:[array lastObject] forKey:[array firstObject]];
    }
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

-(NSString *)URLDecodedString:(NSString *)encodedStr
{
    NSString *encodedString = encodedStr;
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

@end
#endif
