//
//  GAURLSessionConfiguration.m
//  GA_Base_NetworkAndDebug
//
//  Created by GhGh on 2017/6/9.
//  Copyright © 2017年 GhGh. All rights reserved.
//

#import "GAURLSessionConfiguration.h"
#import <objc/runtime.h>
#import "GAURLProtocol.h"
@implementation GAURLSessionConfiguration
+ (id)defaultConfiguration {
    
    static GAURLSessionConfiguration *staticConfiguration;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticConfiguration=[[GAURLSessionConfiguration alloc] init];
    });
    return staticConfiguration;
    
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.isSwizzle=NO;
    }
    return self;
}

#if DEBUG

- (void)load {
    
    self.isSwizzle=YES;
    Class cls = NSClassFromString(@"__NSCFURLSessionConfiguration") ?: NSClassFromString(@"NSURLSessionConfiguration");
    [self swizzleSelector:@selector(protocolClasses) fromClass:cls toClass:[self class]];
    
}

- (void)unload {
    
    self.isSwizzle=NO;
    Class cls = NSClassFromString(@"__NSCFURLSessionConfiguration") ?: NSClassFromString(@"NSURLSessionConfiguration");
    [self swizzleSelector:@selector(protocolClasses) fromClass:cls toClass:[self class]];
    
}

- (void)swizzleSelector:(SEL)selector fromClass:(Class)original toClass:(Class)stub {
    
    Method originalMethod = class_getInstanceMethod(original, selector);
    Method stubMethod = class_getInstanceMethod(stub, selector);
    if (!originalMethod || !stubMethod) {
        [NSException raise:NSInternalInconsistencyException format:@"Couldn't load NEURLSessionConfiguration."];
    }
    method_exchangeImplementations(originalMethod, stubMethod);
}

- (NSArray *)protocolClasses {
    
    return @[[GAURLProtocol class]];
    //如果还有其他的监控protocol，也可以在这里加进去
}

#endif

@end
