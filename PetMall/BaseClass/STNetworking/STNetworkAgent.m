//
//  STNetworkAgent.m
//  SnailAuction
//
//  Created by imeng on 2018/2/7.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "STNetworkAgent.h"
#import "SARequest.h"

@interface YTKNetworkAgent ()

- (BOOL)validateResult:(SARequest *)request error:(NSError * _Nullable __autoreleasing *)error;

@end

@implementation STNetworkAgent

- (BOOL)validateResult:(SARequest *)request error:(NSError * _Nullable __autoreleasing *)error {
    BOOL result = [super validateResult:request error:error];
    if (result && [request isKindOfClass:[SARequest class]]) {
        id<STResponseValidDelegate> valid = request.responseValidDelegate;
        if (valid && [valid respondsToSelector:@selector(validateWithRequest:error:)]) {
            result =  [valid validateWithRequest:request error:error];
        }
    }
    return result;
}

@end
