//
//  STBaseViewController+Request.m
//  SnailAuction
//
//  Created by imeng on 2018/2/6.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "STBaseViewController.h"
#import "SARequest+Private.h"

@implementation STBaseViewController (Request)

+ (Class)requestClass {
    return [SARequest class];
}

- (__kindof SARequest *)requestGET:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(__kindof SARequest *request, id responseObject))success
                           failure:(void (^)(__kindof SARequest *request, id responseObject, NSError *error))failure {
    return [self requestMethod:GARequestMethodGET
                     URLString:URLString
                    parameters:parameters
                       success:success
                       failure:failure];
}

- (__kindof SARequest *)requestPOST:(NSString *)URLString
                         parameters:(id)parameters
                            success:(void (^)(__kindof SARequest *request, id responseObject))success
                            failure:(void (^)(__kindof SARequest *request, id responseObject, NSError *error))failure {
    return [self requestMethod:GARequestMethodPOST
                     URLString:URLString
                    parameters:parameters
                       success:success
                       failure:failure];
}

- (__kindof SARequest *)requestMethod:(GARequestMethod)method
                            URLString:(NSString *)URLString
                           parameters:(id)parameters
                              success:(void (^)(__kindof SARequest *request, id responseObject))success
                              failure:(void (^)(__kindof SARequest *request, id responseObject, NSError *error))failure {
    SARequest *request = [self requestMethod:method
                                   URLString:URLString
                                  parameters:parameters
                                  resKeyPath:nil
                                    resClass:NULL
                               resArrayClass:NULL
                                       retry:NO
                                   accessory:self
                                     success:success
                                     failure:failure];
    return [request start];
}

- (__kindof SARequest *)requestMethod:(GARequestMethod)method
                            URLString:(NSString *)URLString
                           parameters:(id)parameters
                           resKeyPath:(NSString *)resKeyPath
                             resClass:(Class)resClass
                                retry:(BOOL)retry
                              success:(void (^)(__kindof SARequest *request, id responseObject))success
                              failure:(void (^)(__kindof SARequest *request, id responseObject, NSError *error))failure {
    SARequest *request = [self requestMethod:method
                                   URLString:URLString
                                  parameters:parameters
                                  resKeyPath:resKeyPath
                                    resClass:resClass
                               resArrayClass:NULL
                                       retry:retry
                                   accessory:self
                                     success:success
                                     failure:failure];
    return [request start];
}

- (__kindof SARequest *)requestMethod:(GARequestMethod)method
                            URLString:(NSString *)URLString
                           parameters:(id)parameters
                           resKeyPath:(NSString *)resKeyPath
                        resArrayClass:(Class)resArrayClass
                                retry:(BOOL)retry
                              success:(void (^)(__kindof SARequest *request, id responseObject))success
                              failure:(void (^)(__kindof SARequest *request, id responseObject, NSError *error))failure {
    SARequest *request = [self requestMethod:method
                                   URLString:URLString
                                  parameters:parameters
                                  resKeyPath:resKeyPath
                                    resClass:NULL
                               resArrayClass:resArrayClass
                                       retry:retry
                                   accessory:self
                                     success:success
                                     failure:failure];
    return [request start];
}

- (__kindof SARequest *)requestMethod:(GARequestMethod)method
                            URLString:(NSString *)URLString
                           parameters:(id)parameters
                           resKeyPath:(NSString *)resKeyPath
                             resClass:(Class)resClass
                        resArrayClass:(Class)resArrayClass
                                retry:(BOOL)retry
                            accessory:(id<YTKRequestAccessory>)accessory
                              success:(void (^)(__kindof SARequest *request, id responseObject))success
                              failure:(void (^)(__kindof SARequest *request, id responseObject, NSError *error))failure {
    Class aClass = [self class];
    
    SARequest *request = nil;
    if ([aClass respondsToSelector:@selector(requestClass)]) {
        Class requestClass = [aClass requestClass];
        if ([requestClass isSubclassOfClass:[SARequest class]]) {
            request = [[requestClass alloc] init];
        }
    }
    
    request.p_requestUrl = URLString;
    request.p_method = method;
    request.p_parameters = parameters;
    request.resKeyPath = resKeyPath;
    request.resClass = resClass;
    request.resArrayClass = resArrayClass;

    request.shouldDisplayRetryView = retry;
    request.shouldDisplayLoadingView = YES;
    
    if (accessory) {
        [request addAccessory:accessory];
    }
    
    [request setCompletionBlockWithSuccess:^(__kindof SARequest *request) {
        success ? success(request, request.res) : nil;
    } failure:^(__kindof SARequest *request) {
        failure ? failure(request, request.res, request.error) : nil;
    }];
    
    return request;
}

- (void)handleRetryAction {
    [self.retryRequest start];
}

- (void)displayRetryWithRequest:(__kindof SARequest *)request {
    if (request.shouldDisplayRetryView) {
        Class aClass = [self class];
        
        SARequest *retryRequest = nil;
        if ([aClass respondsToSelector:@selector(requestClass)]) {
            Class requestClass = [aClass requestClass];
            if ([requestClass isSubclassOfClass:[SARequest class]]) {
                retryRequest = [[requestClass alloc] init];
            }
        }

        retryRequest.p_requestUrl = [request requestUrl];
        retryRequest.p_method = (GARequestMethod)[request requestMethod];
        retryRequest.p_parameters = [request requestArgument];
        request.resKeyPath = request.resKeyPath;
        request.resClass = request.resClass;
        request.resArrayClass = request.resArrayClass;

        retryRequest.shouldDisplayRetryView = request.shouldDisplayRetryView;
        retryRequest.shouldDisplayLoadingView = request.shouldDisplayLoadingView;
        
        [retryRequest addAccessory:self];
        
        [retryRequest setCompletionBlockWithSuccess:[request.successCompletionBlock copy]
                                            failure:[request.failureCompletionBlock copy]];
        self.retryRequest = retryRequest;
        [self showEmptyRetryViewWithButtonAction:@selector(handleRetryAction)];
    }
}

- (void)uploadLoadingViewState {
    if (self.requestLoadCount > 0 && !self.isEmptyViewShowing) {    
        self.emptyView.alpha = 1;
        [self showEmptyViewWithLoading];
    } else {
        if (self.emptyView.loadingView && !self.emptyView.loadingView.hidden) {
            [UIView animateWithDuration:0.2 animations:^{
                self.emptyView.alpha = 0;
            } completion:^(BOOL finished) {
                if (self.emptyView.loadingView && !self.emptyView.loadingView.hidden) {
                    [self hideEmptyView];
                } else {
                    self.emptyView.alpha = 1;
                }
            }];
        }
    }
}

#pragma mark - YTKRequestAccessory

- (void)requestWillStart:(__kindof SARequest *)request {
    if (request.shouldDisplayLoadingView) {
        self.requestLoadCount ++;
        [self uploadLoadingViewState];
    }
}

- (void)requestWillStop:(__kindof SARequest *)request {
    if (request.shouldDisplayLoadingView) {
        self.requestLoadCount --;
        [self uploadLoadingViewState];
    }
}

- (void)requestDidStop:(__kindof SARequest *)request {
    if (request.error) {
        [self displayRetryWithRequest:request];
        [self showWaring:request.error.localizedDescription];
    }
}

@end
