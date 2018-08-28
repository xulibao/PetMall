//
//  GADeviceUtil.m
//  GA_Base_FrameWork
//
//  Created by GhGh on 15/11/2.
//  Copyright © 2015年 GhGh. All rights reserved.
//
#define KIOSVersion_7   ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define KSTRINGHASVALUE(str)		(str && [str isKindOfClass:[NSString class]] && [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0)
// Keychain
#define KEYCHAIN_GUID                           @"GUID"         // 替代UDID
#define USERDEFAULT_KEYCHAIN_GUID               @"GA_GUID"   // 存入userdefault
#define KEYCHAIN_ACCOUNT                        @"Account"      // 用户名
#define KEYCHAIN_PASSWORD                       @"Password"     // 密码
#import "GADeviceUtil.h"
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import "KeychainItemWrapper.h"
static NSString *keychain_guid = nil;

@implementation GADeviceUtil

+ (NSString *)macaddress {
    if (KIOSVersion_7) {
        NSString *guid = [self GetGUIDString];
        return guid; 
    }else{
        int                 mib[6];
        size_t              len;
        char                *buf;
        unsigned char       *ptr;
        struct if_msghdr    *ifm;
        struct sockaddr_dl  *sdl;
        
        mib[0] = CTL_NET;
        mib[1] = AF_ROUTE;
        mib[2] = 0;
        mib[3] = AF_LINK;
        mib[4] = NET_RT_IFLIST;
        
        if ((mib[5] = if_nametoindex("en0")) == 0) {
            printf("Error: if_nametoindex error\n");
            return NULL;
        }
        
        if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
            printf("Error: sysctl, take 1\n");
            return NULL;
        }
        
        if ((buf = malloc(len)) == NULL) {
            printf("Could not allocate memory. error!\n");
            return NULL;
        }
        
        if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
            printf("Error: sysctl, take 2");
            free(buf);
            return NULL;
        }
        
        ifm = (struct if_msghdr *)buf;
        sdl = (struct sockaddr_dl *)(ifm + 1);
        ptr = (unsigned char *)LLADDR(sdl);
        NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                               *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
        free(buf);
        
        if (!KSTRINGHASVALUE(outstring))
        {
            outstring = [self GetGUIDString];
        }
        
        return outstring;
        
    }
}

+ (NSString *)device
{
    static NSString *modelString = nil;
    if (modelString) {
        return modelString;
    }
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    char *modelKey = "hw.machine";
#else
    char *modelKey = "hw.model";
#endif
    size_t size;
    sysctlbyname(modelKey, NULL, &size, NULL, 0);
    char *model = malloc(size);
    sysctlbyname(modelKey, model, &size, NULL, 0);
    modelString = [[NSString stringWithUTF8String:model] copy];
    free(model);
    return modelString;
}

+ (NSString *)GetGUIDString
{
    if (KSTRINGHASVALUE(keychain_guid)) {
        return keychain_guid;
    }
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:KEYCHAIN_GUID accessGroup:nil];
    
    //从keychain里取出GUID
    keychain_guid = [[wrapper objectForKey:(id)CFBridgingRelease(kSecValueData)] copy];
    if (KSTRINGHASVALUE(keychain_guid)) {
        return keychain_guid;
    }else{
        // 从文件读取
        keychain_guid = [[[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULT_KEYCHAIN_GUID] copy];
        if (KSTRINGHASVALUE(keychain_guid)) {
            return keychain_guid;
        }else{
            keychain_guid = [[self GUIDString] copy];
            [wrapper setObject:keychain_guid forKey:(__bridge id)kSecValueData];
            
            wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:KEYCHAIN_GUID accessGroup:nil];
            keychain_guid = [[wrapper objectForKey:(__bridge id)kSecValueData] copy];
            if (KSTRINGHASVALUE(keychain_guid)) {
                return keychain_guid;
            }else{
                keychain_guid = [[self GUIDString] copy];
                [[NSUserDefaults standardUserDefaults] setObject:keychain_guid forKey:USERDEFAULT_KEYCHAIN_GUID];
                return keychain_guid;
            }
        }
    }
}

+ (NSString*)GUIDString {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}

+ (void)showAvailableMemory {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    
    if(kernReturn != KERN_SUCCESS) return;
    
    double availableNum = ((vm_page_size * vmStats.free_count) / 1024.0) / 1024.0;
    NSLog(@"<<%.f M can be used>>",availableNum);
}

@end
