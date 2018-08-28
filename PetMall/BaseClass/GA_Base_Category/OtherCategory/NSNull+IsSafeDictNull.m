//
//  NSNull+IsSafeDictNull.m
//  GA_Base_FrameWork
//
//  Created by GhGh on 16/9/21.
//  Copyright © 2016年 GhGh. All rights reserved.
//

#import "NSNull+IsSafeDictNull.h"

@implementation NSNull (IsSafeDictNull)
- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([self respondsToSelector:[invocation selector]]) {
        [invocation invokeWithTarget:self];
    }
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *sig = [[NSNull class] instanceMethodSignatureForSelector:selector];
    if(sig == nil) {
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
    }
    return sig;
}

@end
