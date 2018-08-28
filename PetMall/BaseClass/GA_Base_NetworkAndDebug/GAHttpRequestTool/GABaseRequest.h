//
//  GABaseRequest.h
//  GA_Base_FrameWork
//
//  Created by GhGh on 15/11/17.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork.h>
// 过期
#define GAExtensionDeprecated(instead) NS_DEPRECATED(1_0_0, 1_0_0, 1_0_0, 1_0_0, instead)
///  HTTP Request method.
typedef NS_ENUM(NSInteger, GARequestMethod) {
    GARequestMethodGET = YTKRequestMethodGET,
    GARequestMethodPOST = YTKRequestMethodPOST,
    GARequestMethodHEAD = YTKRequestMethodHEAD,
    GARequestMethodPUT = YTKRequestMethodPUT,
    GARequestMethodDELETE = YTKRequestMethodDELETE,
    GARequestMethodPATCH = YTKRequestMethodPATCH,
};

///  Request serializer type.
typedef NS_ENUM(NSInteger, GARequestSerializerType) {
    GARequestSerializerTypeHTTP = YTKRequestSerializerTypeHTTP,
    GARequestSerializerTypeJSON = YTKRequestSerializerTypeJSON,
};

///  Response serializer type, which determines response serialization process and
///  the type of `responseObject`.
typedef NS_ENUM(NSInteger, GAResponseSerializerType) {
    /// NSData type
    GAResponseSerializerTypeHTTP = YTKResponseSerializerTypeHTTP,
    /// JSON object type
    GAResponseSerializerTypeJSON = YTKResponseSerializerTypeJSON,
    /// NSXMLParser type
    GAResponseSerializerTypeXMLParser = YTKResponseSerializerTypeXMLParser,
};

NS_ASSUME_NONNULL_BEGIN

@class GABaseRequest;
typedef void(^GARequestCompletionBlock)(__kindof GABaseRequest *request);

@interface GABaseRequest : YTKRequest

#pragma mark - Request Configuration

///  Set completion callbacks
- (void)setCompletionBlockWithSuccess:(nullable GARequestCompletionBlock)success
                              failure:(nullable GARequestCompletionBlock)failure;

#pragma mark - Request Action
///=============================================================================
/// @name Request Action
///=============================================================================

///  Append self to request queue and start the request.
- (__kindof GABaseRequest *)start;

///  Remove self from request queue and cancel the request.
- (__kindof GABaseRequest *)stop;

///  Convenience method to start the request with block callbacks.
- (__kindof GABaseRequest *)startWithCompletionBlockWithSuccess:(nullable GARequestCompletionBlock)success
                                                        failure:(nullable GARequestCompletionBlock)failure;

#pragma mark - Subclass Override

///  HTTP request method.
- (GARequestMethod)requestMethod;

///  Request serializer type.
- (GARequestSerializerType)requestSerializerType;

///  Response serializer type. See also `responseObject`.
- (GAResponseSerializerType)responseSerializerType;

///  Additional request argument.
- (nullable id)requestArgument;

- (NSString *)apiAuthValue;

@end

@interface GABaseRequest (DebugTrack) <YTKRequestAccessory>

@end

typedef NS_ENUM(NSInteger,HttpMethodType) {
    HttpMethodUndefined = -1,
    HttpMethodGet = GARequestMethodGET,
    HttpMethodPost = GARequestMethodPOST,
};

@interface GABaseRequest (Deprecated)

- (NSDictionary *)resultDic GAExtensionDeprecated("请使用继承网络请求进行处理");

- (NSMutableDictionary *)parameterDic GAExtensionDeprecated("请使用继承网络请求进行处理");

- (void)setParameterDic:(NSMutableDictionary *)parameterDic GAExtensionDeprecated("请使用继承网络请求进行处理");

- (NSString *)urlAction;

- (void)setUrlAction:(NSString *)url GAExtensionDeprecated("请使用继承网络请求进行处理");

- (HttpMethodType)methodType;

- (void)setMethodType:(HttpMethodType)methodType GAExtensionDeprecated("请使用继承网络请求进行处理");

/**
 *  普通GET/POST请求
 *
 *  @param onRequestSuccessBlock 成功block
 *  @param onRequestFailedBlock  失败block
 */
- (void)requestonSuccess:(void(^)(GABaseRequest *request))onRequestSuccessBlock
                onFailed:(void(^)(GABaseRequest *request, NSError *error))onRequestFailedBlock GAExtensionDeprecated("请使用继承网络请求进行处理");

/**
 *  取消请求
 */
- (void)cancelRequest GAExtensionDeprecated("请使用继承网络请求进行处理");

@end
NS_ASSUME_NONNULL_END
