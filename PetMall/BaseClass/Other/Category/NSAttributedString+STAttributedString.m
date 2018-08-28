//
//  NSAttributedString+STAttributedString.m
//  SnailTruck
//
//  Created by imeng on 2017/11/23.
//  Copyright © 2017年 GhGh. All rights reserved.
//

#import "NSAttributedString+STAttributedString.h"

NSDictionary<NSAttributedStringKey,id> * const SADefaultHighlightedAttributes(CGFloat fontSize) {
    return @{NSFontAttributeName:UIFontMake(fontSize),
             NSForegroundColorAttributeName:kColorFF5554};
}

NSDictionary<NSAttributedStringKey,id> * const SADefaultNormalAttributes (CGFloat fontSize) {
    return @{NSFontAttributeName:UIFontMake(fontSize),
             NSForegroundColorAttributeName:kColorTextGay};
}

@implementation NSAttributedString (STAttributedString)

+ (NSAttributedString *)stringWithStrings:(NSArray<NSAttributedString*> *)strings {
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] init];
    for (NSAttributedString *aString in strings) {
        [attString appendAttributedString:aString];
    }
    return attString;
}

+ (NSAttributedString *)arrowTextWithText:(NSAttributedString *)text {
    if (!text) return nil;
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithAttributedString:text];
    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
    
    UIFont *font = [text attributesAtIndex:0 effectiveRange:nil][NSFontAttributeName];
    UIImage *icon = [UIImage imageNamed:@"ico_rightarrow"];
    NSTextAttachment *iconAtt = [[NSTextAttachment alloc] init];
    iconAtt.image = icon;
    iconAtt.bounds = (CGRect){0, roundf(font.capHeight - iconAtt.image.size.height)/2.f, iconAtt.image.size};//与文字中间对齐
    [attString appendAttributedString:[NSAttributedString attributedStringWithAttachment:iconAtt]];
    return attString;
}

- (NSAttributedString *)stringByInsertImage:(UIImage *)image atIndex:(NSUInteger)loc {
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithAttributedString:self];

    UIFont *font = [self attributesAtIndex:0 effectiveRange:nil][NSFontAttributeName];
    font = (font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]]);
    NSTextAttachment *iconAtt = [[NSTextAttachment alloc] init];
    iconAtt.image = image;
    iconAtt.bounds = (CGRect){0, roundf(font.capHeight - iconAtt.image.size.height)/2.f, iconAtt.image.size};//与文字中间对齐
    [attString insertAttributedString:[NSAttributedString attributedStringWithAttachment:iconAtt] atIndex:loc];
    return attString;
}

+ (NSAttributedString *)timeTextWithString:(NSString *)string
                                  fontSize:(CGFloat)fontSize
                                  needHour:(BOOL)needHour {
    NSAttributedString *text = nil;
    NSMutableArray<NSAttributedString*> *texts = [NSMutableArray array];
    NSArray<NSAttributedString*> *units = @[[@"年" attributedStingWithAttributes:SADefaultNormalAttributes(fontSize)],
                                            [@"月" attributedStingWithAttributes:SADefaultNormalAttributes(fontSize)],
                                            [@"日" attributedStingWithAttributes:SADefaultNormalAttributes(fontSize)]];
    NSRange range = [string rangeOfString:@" "];
    NSAttributedString *hourTime = nil;
    if (range.location == NSNotFound) {
        range = NSMakeRange(string.length, 0);
    } else {
        if (needHour) {
            NSString *dateText = [string substringFromIndex:range.location+range.length];
            hourTime = [dateText attributedStingWithAttributes:SADefaultHighlightedAttributes(fontSize)];
        }
    }
    
    NSString *dateText = [string substringToIndex:range.location];
    
    NSArray<NSString*> *dateTextArray = [dateText componentsSeparatedByString:@"-"];
    [dateTextArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [texts appendObject:[obj attributedStingWithAttributes:SADefaultHighlightedAttributes(fontSize)]];
        if (units.count > idx) {
            [texts appendObject:units[idx]];
        }
    }];

    if (hourTime) {
        [texts appendObject:[@" " attributedStingWithAttributes:nil]];
        [texts appendObject:hourTime];
    }
    
    text = [NSAttributedString stringWithStrings:texts];
    return text;
}

+ (NSAttributedString *)countDownTextWithSecond:(long long)seconds
                                       fontSize:(CGFloat)fontSize{
    return [self countDownTextWithSecond:seconds
                   highlightedAttributes:SADefaultHighlightedAttributes(fontSize)
                        normalAttributes:SADefaultNormalAttributes(fontSize)];
}

+ (NSAttributedString *)countDownTextWithSecond:(long long)seconds
                          highlightedAttributes:(NSDictionary<NSAttributedStringKey, id> *)highlightedAttributes
                               normalAttributes:(NSDictionary<NSAttributedStringKey, id> *)normalAttributes {
    if (seconds <= 0) {
        seconds = - seconds;
    }
    
    long long secs = seconds % 60;
    long long mins = seconds % (60 * 60) / 60;
    long long hours = seconds / (60 * 60) % 24;
    long long days = seconds / (60 * 60) / 24;
    
    NSAttributedString *text = nil;
    
    NSAttributedString *unit2Text = [@"分" attributedStingWithAttributes:normalAttributes];
    if (hours == 0 && days == 0) {
        NSString * secsStr = [NSString stringWithFormat:@"%02lld",secs];
        NSString * minsStr = [NSString stringWithFormat:@"%02lld",mins];
        text = [NSAttributedString stringWithStrings:@[[minsStr attributedStingWithAttributes:highlightedAttributes],
                                                       unit2Text,
                                                       [secsStr attributedStingWithAttributes:highlightedAttributes],
                                                       [@"秒" attributedStingWithAttributes:normalAttributes]
                                                       ]];
    } else {
        NSString * minsStr = [NSString stringWithFormat:@"%02lld",mins];
        NSString * hoursStr = [NSString stringWithFormat:@"%02lld",hours];
        NSString * daysStr = [NSString stringWithFormat:@"%002lld",days];
        
        NSAttributedString *unit0Text = [@"天" attributedStingWithAttributes:normalAttributes];
        NSAttributedString *unit1Text = [@"时" attributedStingWithAttributes:normalAttributes];
        
        NSMutableArray<NSAttributedString*> *texts = [NSMutableArray array];
        [texts appendObject:[daysStr attributedStingWithAttributes:highlightedAttributes]];
        [texts appendObject:unit0Text];
        [texts appendObject:[hoursStr attributedStingWithAttributes:highlightedAttributes]];
        [texts appendObject:unit1Text];
        [texts appendObject:[minsStr attributedStingWithAttributes:highlightedAttributes]];
        [texts appendObject:unit2Text];
        text = [NSAttributedString stringWithStrings:texts];
    }
    return text;
}


@end

@implementation  NSString (STAttributedString)

- (NSAttributedString *)attributedStingWithAttributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attributes {
    return [[NSAttributedString alloc] initWithString:self attributes:attributes];
}

@end
