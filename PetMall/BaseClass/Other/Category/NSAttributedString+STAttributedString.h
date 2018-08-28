//
//  NSAttributedString+STAttributedString.h
//  SnailTruck
//
//  Created by imeng on 2017/11/23.
//  Copyright © 2017年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wstrict-prototypes"

extern NSDictionary<NSAttributedStringKey,id> * const SADefaultHighlightedAttributes(CGFloat fontSize);
extern NSDictionary<NSAttributedStringKey,id> * const SADefaultNormalAttributes(CGFloat fontSize);

#pragma clang diagnostic pop

@interface NSAttributedString (STAttributedString)

+ (NSAttributedString *)stringWithStrings:(NSArray<NSAttributedString*> *)strings;
+ (NSAttributedString *)arrowTextWithText:(NSAttributedString *)text;
- (NSAttributedString *)stringByInsertImage:(UIImage *)image atIndex:(NSUInteger)loc;

+ (NSAttributedString *)timeTextWithString:(NSString *)string
                                  fontSize:(CGFloat)fontSize
                                  needHour:(BOOL)needHour;

+ (NSAttributedString *)countDownTextWithSecond:(long long)seconds
                                       fontSize:(CGFloat)fontSize;

+ (NSAttributedString *)countDownTextWithSecond:(long long)seconds
                          highlightedAttributes:(NSDictionary<NSAttributedStringKey, id> *)highlightedAttributes
                               normalAttributes:(NSDictionary<NSAttributedStringKey, id> *)normalAttributes;

@end

@interface NSString (STAttributedString)

- (NSAttributedString *)attributedStingWithAttributes:(NSDictionary<NSAttributedStringKey, id> *)attributes;

@end
