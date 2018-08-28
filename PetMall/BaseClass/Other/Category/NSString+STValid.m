//
//  NSString+STValid.m
//  SnailTruck
//
//  Created by imeng on 4/11/17.
//  Copyright © 2017 GhGh. All rights reserved.
//

#import "NSString+STValid.h"

NSString *const STNumberRegex = @"^\\d+$";
NSString *const STPhoneNumberRegex = @"^1\\d{10}$";
NSString *const STPriceRegex = @"^[1-9]\\d*$|^\\d+[.]\\d{1,2}$";
NSString *const STChineseIDCardRegex = @"(^\\d{18}$)|(^\\d{15}$)|(^\\d{17}(\\d|X|x)$)";

@implementation NSString (STValid)

- (NSString *)removingSapceString {
    return [self removeingSpecialString:@" "];
}

- (NSString *)removeingSpecialString:(NSString *)specialString {
    if (specialString) {
        return [self stringByReplacingOccurrencesOfString:specialString withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, self.length)];
    }
    return self;
}

- (BOOL)isValidWithRegex:(NSString *)regex {
    if (!regex || regex.length == 0) {
        return YES;
    }
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [numberPre evaluateWithObject:self];
}

#pragma mark - 算法相关
//精确的身份证号码有效性检测
- (BOOL)accurateVerifyIDCardNumber {
    return (IDCARD_IS_VALID == [STHelpTools isIdCardNumberValid:self]);
}

/** 银行卡号有效性问题Luhn算法
 */
- (BOOL)bankCardluhmVerify {
    NSString *string = self;
    NSString *formattedString = [string formattedStringForProcessing];
    if (formattedString == nil || formattedString.length < 9) {
        return NO;
    }
    
    NSMutableString *reversedString = [NSMutableString stringWithCapacity:[formattedString length]];
    
    [formattedString enumerateSubstringsInRange:NSMakeRange(0, [formattedString length]) options:(NSStringEnumerationReverse |NSStringEnumerationByComposedCharacterSequences) usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [reversedString appendString:substring];
    }];
    
    NSUInteger oddSum = 0, evenSum = 0;
    
    for (NSUInteger i = 0; i < [reversedString length]; i++) {
        NSInteger digit = [[NSString stringWithFormat:@"%C", [reversedString characterAtIndex:i]] integerValue];
        
        if (i % 2 == 0) {
            evenSum += digit;
        }
        else {
            oddSum += digit / 5 + (2 * digit) % 10;
        }
    }
    return (oddSum + evenSum) % 10 == 0;
}

#pragma mark - Helper

- (NSString *) formattedStringForProcessing {
    NSCharacterSet *illegalCharacters = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray *components = [self componentsSeparatedByCharactersInSet:illegalCharacters];
    return [components componentsJoinedByString:@""];
}
@end

