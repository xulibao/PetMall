//
//  NSObject+MemoryLeak.h
//  MLeaksFinder
//
//  Created by zeposhe on 12/12/15.
//  Copyright © 2015 zeposhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (swizzleSEL)

+ (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL;

@end
