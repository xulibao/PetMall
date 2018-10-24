//
//  SARequest.m
//  SnailTruck
//
//  Created by imeng on 12/15/16.
//  Copyright © 2016 GhGh. All rights reserved.
//

#import "SARequest.h"
//#import "FMDBManager+SARequestErrorTracking.h"

#import "STNetworkAgent.h"

#import "SARequest+Private.h"

NSString *const STResponseValidationErrorDomain = @"com.woniuhuoche.request.response.validation";

@interface SARequest (RequestAccessory)

- (void)toggleAccessoriesWillStartCallBack;
- (void)toggleAccessoriesWillStopCallBack;
- (void)toggleAccessoriesDidStopCallBack;

@end

@interface SARequest ()

@property (nonatomic, strong, readwrite) id res;
@property(nonatomic, assign) BOOL needsUpdateRes;
@property(nonatomic, strong) NSHashTable *private_requestAccessories;

@end

@implementation SARequest {
    NSString *_resKeyPath;
    Class _resClass;
    Class _resArrayClass;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.responseValidDelegate = self;
//        [self addAccessory:[FMDBManager sharedFMDBManager]]; //DebugTrack
    }
    return self;
}
#pragma - YTKRequest Override


- (void)addAccessory:(id<YTKRequestAccessory>)accessory {
    if (!self.private_requestAccessories) {
        self.private_requestAccessories = [NSHashTable weakObjectsHashTable];
    }
    [self.private_requestAccessories addObject:accessory];
}

- (NSArray<id<YTKRequestAccessory>> *)requestAccessories {
    return [self.private_requestAccessories allObjects];
}

#pragma mark - Request Action

///  Append self to request queue and start the request.
- (__kindof SARequest *)start {
    [self toggleAccessoriesWillStartCallBack];
    [[STNetworkAgent sharedAgent] addRequest:self];
    return self;
}

///  Remove self from request queue and cancel the request.
- (__kindof SARequest *)stop {
    [self toggleAccessoriesWillStopCallBack];
    self.delegate = nil;
    [[STNetworkAgent sharedAgent] cancelRequest:self];
    [self toggleAccessoriesDidStopCallBack];
    return self;
}

- (__kindof NSObject *)responseEntity {
    return self.res;
}

- (GARequestMethod)requestMethod {
    return _p_method;
}

- (NSString *)requestUrl {
    return _p_requestUrl;
}

- (__kindof id)requestArgument {
    if (self.p_parameters) {
        return [self.p_parameters mj_keyValues];
    }
    return [super requestArgument];
}

- (NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary {
    NSMutableDictionary *header = [NSMutableDictionary dictionary];
    NSDictionary *superHeader = [super requestHeaderFieldValueDictionary];
    if (superHeader) {
        [header addEntriesFromDictionary:superHeader];
    }
    NSDictionary *configHeader = [STNetworking defaultRequestHeaderFieldValueDictionary];
    if (configHeader) {
        [header addEntriesFromDictionary:configHeader];
    }
    return header;
}

- (void)requestCompletePreprocessor {
    [super requestCompletePreprocessor];
    [self prepareForres];
}

- (void)setCompletionBlockWithSuccess:(SARequestCompletionBlock)success
                              failure:(SARequestCompletionBlock)failure {
    [super setCompletionBlockWithSuccess:success failure:failure];
}

///  Convenience method to start the request with block callbacks.

- (__kindof SARequest *)startWithCompletionBlockWithSuccess:(SARequestCompletionBlock)success
                                                    failure:(SARequestCompletionBlock)failure {
    return [super startWithCompletionBlockWithSuccess:^(__kindof GABaseRequest * _Nonnull request) {
        success ? success(self) : nil;
    } failure:^(__kindof GABaseRequest * _Nonnull request) {
        failure ? failure(self) : nil;
    }];
}

- (__kindof SARequest *)setResKeyPath:(NSString *)keyPath {
    _resKeyPath = [keyPath copy];
    [self setNeedsUpdateRes];
    return self;
}

- (__kindof SARequest *)setResClass:(Class)resClass {
    _resClass = resClass;
    [self setNeedsUpdateRes];
    return self;
}

- (__kindof SARequest *)setResArrayClass:(Class)resArrayClass {
    _resArrayClass = resArrayClass;
    [self setNeedsUpdateRes];
    return self;
}

- (__kindof SARequest *)setResValid:(id<STResponseValidDelegate>)resValid {
    self.responseValidDelegate = resValid;
    return self;
}

- (void)setNeedsUpdateRes {
    self.needsUpdateRes = YES;
}

- (NSString *)resKeyPath {
    return _resKeyPath;
}

- (Class)resClass {
    if (_resArrayClass) {
        return nil;
    }
    if (_resClass) {
        return _resClass;
    }
    return nil;
}

- (Class)resArrayClass {
    return _resArrayClass;
}

- (id)res {
    if (!_res) {
        [self setNeedsUpdateRes];
        [self prepareForres];
    }
    return _res;
}

- (void)prepareForres {
    id res = nil;
    id keyPathRes = nil;
    
    if ([self resKeyPath]) {
        keyPathRes = [self.responseJSONObject valueForKeyPath:[self resKeyPath]];
        keyPathRes = keyPathRes ? keyPathRes : self.responseJSONObject;
    }
    
    if (self.resArrayClass) {
        if ([keyPathRes isKindOfClass:[NSArray class]]) {
            res = [self.resArrayClass mj_objectArrayWithKeyValuesArray:keyPathRes];
        }
    } else if (self.resClass) {
        res = [self.resClass mj_objectWithKeyValues:keyPathRes];
    } else if (keyPathRes){
        res = keyPathRes;
    } else {
        res = self.responseJSONObject;
    }
    
    if (self.resArrayClass) {
        if ([res isKindOfClass:[NSArray class]]) {
            NSArray *resArr = res;
            if (![resArr.firstObject isKindOfClass:self.resArrayClass]) {
                res = nil;
            }
        } else {
            res = nil;
        }
    } else if (self.resClass) {
        if (![res isKindOfClass:self.resClass]) {
            res = nil;
        }
    }
    
    _res = res;
    self.needsUpdateRes = NO;
}

#pragma mark - MJKeyValue

+ (NSArray *)mj_ignoredPropertyNames {
    static NSArray *blacklist;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *tempList = [NSMutableArray array];
        [SARequest mj_enumerateProperties:^(MJProperty *property, BOOL *stop) {
            [tempList addObject:property.name];
        }];
        blacklist = [NSArray arrayWithArray:tempList];
    });
    
    return blacklist;
}

@end

@implementation SARequest (ResponseValid)

- (BOOL)validateWithRequest:(SARequest *)request error:(NSError * __autoreleasing *)error {
    STAPIResponse *response = [STAPIResponse mj_objectWithKeyValues:request.responseJSONObject];
    if (response.status == 200) {
        return YES;
    }
    if (error) {
        *error = [NSError errorWithDomain:STResponseValidationErrorDomain code:response.status userInfo:response.msg ? @{NSLocalizedDescriptionKey:response.msg} : nil];
        return NO;
    }
    return YES;
}

@end
