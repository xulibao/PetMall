//
//  GA_Log_Anything.h
//  GA_Log_AnythingDemo
//
//  Created by DeveloperGA on 15/10/24.
//  Copyright © 2015年 DeveloperGA. All rights reserved.
//


//  用法   GA_Log_Any(i);  其中的i可以是任意类型。不用@"",不用""

#import <objc/runtime.h>
#ifndef GA_Log_Anything_h
#define GA_Log_Anything_h

#import <UIKit/UIKit.h>

#if TARGET_OS_IPHONE

    #define GAEdgeInsets    UIEdgeInsets
    #define GAOffset        UIOffset
    #define valueWithGAOffset   valueWithUIOffset
    #define valueWithGAEdgeInsets   valueWithUIEdgeInsets

#elif TARGET_OS_MAC

    #define GAEdgeInsets    NSEdgeInsets
    #define GAOffset        NSOffset
    #define valueWithGAOffset   valueWithNSOffset
    #define valueWithGAEdgeInsets   valueWithNSEdgeInsets

#endif

#define GABox(var) __GA_box(@encode(__typeof__((var))), (var))
#define GABoxToString(var)  [GABox(var) description]

#ifdef DEBUG
    #define GAPrintf(fmt, ...)  printf("📍%s + 第%d行📍 %s\n", __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:fmt, ##__VA_ARGS__]UTF8String])
    #define GA_Log_Any(var)     GAPrintf(@"%s = %@", #var, GABox(var))
    #define GAPrintAnything(x)   printf("📍%s + 第%d行📍 %s\n", __PRETTY_FUNCTION__, __LINE__, #x)
#else
    #define GAPrintf(fmt, ...)
    #define GA_Log_Any(any)
    #define GAPrintAnything(x)
#endif

static inline id __GA_box(const char * type, ...)
{
    va_list variable_param_list;
    va_start(variable_param_list, type);
    id object = nil;
    if (strcmp(type, @encode(id)) == 0) {
        id param = va_arg(variable_param_list, id);
        if([param isKindOfClass:[NSObject class]] && !([param isKindOfClass:[UIViewController class]]) && !([param isKindOfClass:[NSDictionary class]]) && !([param isKindOfClass:[NSArray class]]) && !([param isKindOfClass:[NSMutableArray class]]))
        {
            NSMutableDictionary *props = [NSMutableDictionary dictionary];
            unsigned int outCount, i;
            objc_property_t *properties = class_copyPropertyList([param class], &outCount);
            for (i = 0; i<outCount; i++)
            {
                objc_property_t property = properties[i];
                const char* char_f =property_getName(property);
                NSString *propertyName = [NSString stringWithUTF8String:char_f];
                id propertyValue = [param valueForKey:(NSString *)propertyName];
                if (propertyValue) [props setObject:propertyValue forKey:propertyName];
            }
            free(properties);
            object = props;
        }else
        object = param;
    }
    else if (strcmp(type, @encode(CGPoint)) == 0) {
        CGPoint param = (CGPoint)va_arg(variable_param_list, CGPoint);
        object = [NSValue valueWithCGPoint:param];
    }
    else if (strcmp(type, @encode(CGSize)) == 0) {
        CGSize param = (CGSize)va_arg(variable_param_list, CGSize);
        object = [NSValue valueWithCGSize:param];
    }
    else if (strcmp(type, @encode(CGVector)) == 0) {
        CGVector param = (CGVector)va_arg(variable_param_list, CGVector);
        object = [NSValue valueWithCGVector:param];
    }
    else if (strcmp(type, @encode(CGRect)) == 0) {
        CGRect param = (CGRect)va_arg(variable_param_list, CGRect);
        object = [NSValue valueWithCGRect:param];
    }
    else if (strcmp(type, @encode(NSRange)) == 0) {
        NSRange param = (NSRange)va_arg(variable_param_list, NSRange);
        object = [NSValue valueWithRange:param];
    }
    else if (strcmp(type, @encode(CFRange)) == 0) {
        CFRange param = (CFRange)va_arg(variable_param_list, CFRange);
        object = [NSValue value:&param withObjCType:type];
    }
    else if (strcmp(type, @encode(CGAffineTransform)) == 0) {
        CGAffineTransform param = (CGAffineTransform)va_arg(variable_param_list, CGAffineTransform);
        object = [NSValue valueWithCGAffineTransform:param];
    }
    else if (strcmp(type, @encode(CATransform3D)) == 0) {
        CATransform3D param = (CATransform3D)va_arg(variable_param_list, CATransform3D);
        object = [NSValue valueWithCATransform3D:param];
    }
    else if (strcmp(type, @encode(SEL)) == 0) {
        SEL param = (SEL)va_arg(variable_param_list, SEL);
        object = NSStringFromSelector(param);
    }
    else if (strcmp(type, @encode(Class)) == 0) {
        Class param = (Class)va_arg(variable_param_list, Class);
        object = NSStringFromClass(param);
    }
    else if (strcmp(type, @encode(GAOffset)) == 0) {
        GAOffset param = (GAOffset)va_arg(variable_param_list, GAOffset);
        object = [NSValue valueWithGAOffset:param];
    }
    else if (strcmp(type, @encode(GAEdgeInsets)) == 0) {
        GAEdgeInsets param = (GAEdgeInsets)va_arg(variable_param_list, GAEdgeInsets);
        object = [NSValue valueWithGAEdgeInsets:param];
    }
    else if (strcmp(type, @encode(short)) == 0) {
        short param = (short)va_arg(variable_param_list, int);
        object = @(param);
    }
    else if (strcmp(type, @encode(int)) == 0) {
        int param = (int)va_arg(variable_param_list, int);
        object = @(param);
    }
    else if (strcmp(type, @encode(long)) == 0) {
        long param = (long)va_arg(variable_param_list, long);
        object = @(param);
    }
    else if (strcmp(type, @encode(long long)) == 0) {
        long long param = (long long)va_arg(variable_param_list, long long);
        object = @(param);
    }
    else if (strcmp(type, @encode(float)) == 0) {
        float param = (float)va_arg(variable_param_list, double);
        object = @(param);
    }
    else if (strcmp(type, @encode(double)) == 0) {
        double param = (double)va_arg(variable_param_list, double);
        object = @(param);
    }
    else if (strcmp(type, @encode(BOOL)) == 0) {
        BOOL param = (BOOL)va_arg(variable_param_list, int);
        object = param ? @"YES" : @"NO";
    }
    else if (strcmp(type, @encode(bool)) == 0) {
        bool param = (bool)va_arg(variable_param_list, int);
        object = param ? @"true" : @"false";
    }
    else if (strcmp(type, @encode(char)) == 0) {
        char param = (char)va_arg(variable_param_list, int);
        object = [NSString stringWithFormat:@"%c", param];
    }
    else if (strcmp(type, @encode(unsigned short)) == 0) {
        unsigned short param = (unsigned short)va_arg(variable_param_list, unsigned int);
        object = @(param);
    }
    else if (strcmp(type, @encode(unsigned int)) == 0) {
        unsigned int param = (unsigned int)va_arg(variable_param_list, unsigned int);
        object = @(param);
    }
    else if (strcmp(type, @encode(unsigned long)) == 0) {
        unsigned long param = (unsigned long)va_arg(variable_param_list, unsigned long);
        object = @(param);
    }
    else if (strcmp(type, @encode(unsigned long long)) == 0) {
        unsigned long long param = (unsigned long long)va_arg(variable_param_list, unsigned long long);
        object = @(param);
    }
    else if (strcmp(type, @encode(unsigned char)) == 0) {
        unsigned char param = (unsigned char)va_arg(variable_param_list, unsigned int);
        object = [NSString stringWithFormat:@"%c", param];
    }
    else {
        void * param = (void *)va_arg(variable_param_list, void *);
        object = [NSString stringWithFormat:@"%p", param];
    }
    
    va_end(variable_param_list);
    
    return object;
}

#endif /* GA_Log_Anything_h */
