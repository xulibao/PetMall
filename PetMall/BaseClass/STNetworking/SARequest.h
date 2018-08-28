//
//  SARequest.h
//  SnailTruck
//
//  Created by imeng on 12/15/16.
//  Copyright © 2016 GhGh. All rights reserved.
//
#import "GARequest.h"
#import "STAPIResponse.h"
#import "STNetworking.h"

FOUNDATION_EXPORT NSString *const STResponseValidationErrorDomain;

@class SARequest;
typedef void(^SARequestCompletionBlock)(__kindof SARequest *request);

@protocol STResponseValidDelegate <NSObject>

- (BOOL)validateWithRequest:(__kindof SARequest *)request error:(NSError * __autoreleasing *)error;

@end

@interface SARequest : GARequest

@property(nonatomic, strong, readonly) id res;
@property(nonatomic, assign) BOOL shouldDisplayRetryView;
@property(nonatomic, assign) BOOL shouldDisplayLoadingView;

#pragma mark - Request Configuration

- (__kindof SARequest *)start;
- (__kindof SARequest *)stop;

///  Set completion callbacks
- (void)setCompletionBlockWithSuccess:(SARequestCompletionBlock)success
                              failure:(SARequestCompletionBlock)failure;

- (__kindof SARequest *)startWithCompletionBlockWithSuccess:(SARequestCompletionBlock)success
                                                    failure:(SARequestCompletionBlock)failure;

- (__kindof SARequest *)setResKeyPath:(NSString *)keyPath;
- (__kindof SARequest *)setResClass:(Class)resClass;
- (__kindof SARequest *)setResArrayClass:(Class)resArrayClass;//会将resClass置nil
- (__kindof SARequest *)setResValid:(id<STResponseValidDelegate>)resValid;

@property(nonatomic, weak) id<STResponseValidDelegate>responseValidDelegate; //default is self

- (NSString *)resKeyPath;
- (Class)resClass;//res类型
- (Class)resArrayClass;

@end

@interface SARequest (ResponseValid) <STResponseValidDelegate>

- (BOOL)validateWithRequest:(__kindof SARequest *)request error:(NSError * __autoreleasing *)error;

@end
