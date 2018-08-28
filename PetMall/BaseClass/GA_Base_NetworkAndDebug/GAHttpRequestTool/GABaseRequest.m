//
//  GABaseRequest.m
//  GA_Base_FrameWork
//
//  Created by GhGh on 15/11/17.
//  Copyright © 2015年 GhGh. All rights reserved.
//
#import "GABaseRequest.h"
#import "GADebugManager.h" // debug 管理

#import <CommonCrypto/CommonCrypto.h>

static inline char itoh(int i) {
    if (i > 9) return 'A' + (i - 10);
    return '0' + i;
}

NSString * NSDataToHex(NSData *data) {
    NSUInteger i, len;
    unsigned char *buf, *bytes;
    
    len = data.length;
    bytes = (unsigned char*)data.bytes;
    buf = malloc(len*2);
    
    for (i=0; i<len; i++) {
        buf[i*2] = itoh((bytes[i] >> 4) & 0xF);
        buf[i*2+1] = itoh(bytes[i] & 0xF);
    }
    
    return [[NSString alloc] initWithBytesNoCopy:buf
                                          length:len*2
                                        encoding:NSASCIIStringEncoding
                                    freeWhenDone:YES];
}


@interface GABaseRequest()

@property (nonatomic, strong) GADebugNetworkModel *debugInfo;

@property (nonatomic, strong) NSMutableDictionary *requestArgument;
@property (nonatomic, assign) GARequestMethod requestMethod;
@property (nonatomic, strong) NSString *requestUrl;

@end

@implementation GABaseRequest

+ (NSString *)encryptUseDES2:(NSString *)plainText key:(NSString *)key{
    NSString *ciphertext = nil;
    const char *textBytes = [plainText UTF8String];
    size_t dataLength = [plainText length];
    //==================
    
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (dataLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    
    //    NSString *testString = key;
    //    NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
    //    Byte *iv = (Byte *)[testData bytes];
    const void *iv = (const void *) [@"12345678" UTF8String];//偏移量
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          textBytes, dataLength,
                                          (void *)bufferPtr, bufferPtrSize,
                                          &movedBytes);
    if (cryptStatus == kCCSuccess) {
        NSData * cryptData =[NSData dataWithBytes:(const void *)bufferPtr
                                           length:(NSUInteger)movedBytes];
        //        ciphertext = [DESBase64 stringByEncodingData:myData];
        ciphertext = NSDataToHex(cryptData);
    }
    //    ciphertext=[ciphertext uppercaseString];//字符变大写
    
    return ciphertext ;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
#ifdef DEBUG
        [self addAccessory:self]; //DebugTrack
#endif
    }
    return self;
}

- (NSString *)description {
    NSString *description = [super description];
    if (self.responseString) {
        description = [description stringByAppendingFormat:@"\n<Response: \n%@\n>", self.responseString];
    }
    return description;
}

- (void)setCompletionBlockWithSuccess:(GARequestCompletionBlock)success
                              failure:(GARequestCompletionBlock)failure {
    [super setCompletionBlockWithSuccess:success failure:failure];
}

- (__kindof GABaseRequest *)start {
    [super start];
    return self;
}

- (__kindof GABaseRequest *)stop {
    [super stop];
    return self;
}

- (__kindof GABaseRequest *)startWithCompletionBlockWithSuccess:(nullable GARequestCompletionBlock)success
                                                        failure:(nullable GARequestCompletionBlock)failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    return [self start];
}

///  Request serializer type.
- (GARequestSerializerType)requestSerializerType {
    return GARequestSerializerTypeHTTP;
}

///  Response serializer type. See also `responseObject`.
- (GAResponseSerializerType)responseSerializerType {
    return GAResponseSerializerTypeJSON;
}

- (NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary {
    NSString *apiAuthValue = [self apiAuthValue];
    if (apiAuthValue) {
        return [NSDictionary dictionaryWithObject:apiAuthValue forKey:@"api_auth"];
    } else {
        return nil;
    }
}

- (NSString *)apiAuthValue   {
    NSString *keyString = @"bjAY2008";
    long long date = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *plainText = @(date).stringValue;
    NSString *text = [GABaseRequest encryptUseDES2:plainText key:keyString];
    return text;
}

@end

@implementation GABaseRequest (DebugTrack)
#ifdef DEBUG
///  Inform the accessory that the request is about to start.
///
///  @param request The corresponding request.
- (void)requestWillStart:(GABaseRequest *)request {
    GADebugNetwork *debugNetwork = [GADebugManager networkInstance];
    GADebugNetworkModel *requestInfo = [debugNetwork beginRequest];
    requestInfo.type = @"text/json";
    request.debugInfo = requestInfo;
}

///  Inform the accessory that the request is about to stop. This method is called
///  before executing `requestFinished` and `successCompletionBlock`.
///
///  @param request The corresponding request.
- (void)requestWillStop:(id)request {
    
}

///  Inform the accessory that the request has already stoped. This method is called
///  after executing `requestFinished` and `successCompletionBlock`.
///
///  @param request The corresponding request.
- (void)requestDidStop:(GABaseRequest *)request {
    if (request.error.domain == YTKRequestValidationErrorDomain) {
        NSLog(@"\n👇⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️\n⚠️RequestFailureBegin\n%@\n%@\n RequestFailureEnd\n👆⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️👆", request,request.error);
    }
    
    GADebugNetworkModel *requestInfo = request.debugInfo;
    
    requestInfo.method = request.originalRequest.HTTPMethod;
    // 请求头 处理
    NSString *requestUrl = [request.originalRequest.URL absoluteString];
    requestInfo.path = [[requestUrl componentsSeparatedByString:@"?"] firstObject];
    if (request.requestUrl) {
        requestInfo.header = request.requestUrl;
    }
    // 请求体
    requestInfo.body = [self dictionaryToJson:request.requestArgument];
    requestInfo.statuscode = request.error.domain == YTKRequestValidationErrorDomain ? @(request.responseStatusCode) : @200;
    if (request.responseObject && [request.responseObject isKindOfClass:[NSDictionary class]]) {
        NSError *error = nil;
        NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:request.responseObject options:NSJSONWritingPrettyPrinted error:&error];
        NSString *responseString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        requestInfo.data = responseString;
    } else {
        requestInfo.data = request.responseString;
    }
    
    if (request.responseData) {
        requestInfo.size = @(request.responseData.length);
    }
    requestInfo.type = request.response.MIMEType;
    GADebugNetwork *debugNetwork = [GADebugManager networkInstance];
    [debugNetwork endRequest:requestInfo];
}
// 请求使用
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    if (dic == nil || dic.count == 0) {
        return @"无";
    }
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
#endif

@end

@implementation GABaseRequest (Deprecated)

- (NSDictionary *)resultDic {
    return self.responseJSONObject;
}

- (NSMutableDictionary *)parameterDic {
    if (!_requestArgument) {
        _requestArgument = [NSMutableDictionary dictionary];
    }
    return _requestArgument;
}

- (void)setParameterDic:(NSMutableDictionary *)parameterDic  {
    if (parameterDic) {
        _requestArgument = [NSMutableDictionary dictionaryWithDictionary:parameterDic];
    }
}

- (HttpMethodType)methodType {
    if (GARequestMethodPOST >=self.requestMethod) {
        return (HttpMethodType)self.requestMethod;
    }
    return HttpMethodUndefined;
}

- (void)setMethodType:(HttpMethodType)methodType {
    self.requestMethod = (GARequestMethod)methodType;
}

- (NSString *)urlAction {
    return self.requestUrl;
}

- (void)setUrlAction:(NSString *)url {
    if ([url hasPrefix:@"/"] && url.length > 1) {
        url = [url substringFromIndex:1];
    }
    self.requestUrl = url;
}

- (void)requestonSuccess:(void(^)(GABaseRequest *request))onRequestSuccessBlock
                onFailed:(void(^)(GABaseRequest *request, NSError *error))onRequestFailedBlock {
    
    [self setCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        onRequestSuccessBlock ? onRequestSuccessBlock(request) : nil;
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        onRequestFailedBlock ? onRequestFailedBlock(request, request.error) : nil;
    }];
    
    [self start];
}

- (void)cancelRequest {
    [self stop];
}

@end
