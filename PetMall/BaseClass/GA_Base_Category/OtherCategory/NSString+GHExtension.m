//
//  NSString+GHExtension.m
//  GA_Base_FrameWork
//
//  Created by GhGh on 15/10/29.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "NSString+GHExtension.h"
#import <CommonCrypto/CommonDigest.h>
#import "GTMBase64.h"
#import <CommonCrypto/CommonCryptor.h>

#define gkey            @"bjAY2008"
#define gIv             @"01234567"

#ifdef DEBUG
#define GH_NSString_LOG(...) safeNSStringLog(__VA_ARGS__)
#else
#define GH_NSString_LOG(...)
#endif
#define  MD5_LENGTH   32
void safeNSStringLog(NSString *fmt, ...) NS_FORMAT_FUNCTION(1, 2);
void safeNSStringLog(NSString *fmt, ...)
{
    va_list ap;
    va_start(ap, fmt);
    NSString *content = [[NSString alloc] initWithFormat:fmt arguments:ap];
    NSLog(@" ============= 框架提醒问题如下 ============ \n");
    NSLog(@"框架提醒:%@", content);
    va_end(ap);
    NSLog(@" ============= 框架提醒具体问题如下 ========== \n%@", [NSThread callStackSymbols]);
}
@implementation NSString (GHExtension)
const Byte iv[] = {1,2,3,4,5,6,7,8};

- (BOOL)isEmpty {
    if (!self) {
        return YES;
    }
    return [self length] > 0 ? NO : YES;
}

- (BOOL)isNotEmpty {
    if (!self) {
        return NO;
    }
    return [self length] > 0 ? YES : NO;
}

- (NSString *)sensitiveWord{
    static NSString *const sensitiveWord = @"发轮功,张三,李四,王五,SB,逼,傻逼,傻冒,王八,王八蛋,混蛋,你妈,你大爷,操你妈,你妈逼,先生,小姐,男士,女士,测试,小沈阳,丫蛋,男人,女人,骚,騒,搔,傻,逼,叉,瞎,屄,屁,性,骂,疯,臭,贱,溅,猪,狗,屎,粪,尿,死,肏,骗,偷,嫖,淫,呆,蠢,虐,疟,妖,腚,蛆,鳖,禽,兽,屁股,畸形,饭桶,脏话,可恶,吭叽,小怂,杂种,娘养,祖宗,畜生,姐卖,找抽,卧槽,携程,无赖,废话,废物,侮辱,精虫,龟头,残疾,晕菜,捣乱,三八,破鞋,崽子,混蛋,弱智,神经,神精,妓女,妓男,沙比,恶性,恶心,恶意,恶劣,笨蛋,他丫,她丫,它丫,丫的,给丫,删丫,山丫,扇丫,栅丫,抽丫,丑丫,手机,查询,妈的,犯人,垃圾,死鱼,智障,浑蛋,胆小,糙蛋,操蛋,肛门,是鸡,无赖,赖皮,磨几,沙比,智障,犯愣,色狼,娘们,疯子,流氓,色情,三陪,陪聊,烤鸡,下流,骗子,真贫,捣乱,磨牙,磨积,甭理,尸体,下流,机巴,鸡巴,鸡吧,机吧,找日,婆娘,娘腔,恐怖,穷鬼,捣乱,破驴,破罗,妈必,事妈,神经,脑积水,事儿妈,草泥马,杀了铅笔,1,2,3,4,5,6,7,8,9,10,J8,s.b,sb,sbbt,Sb＋Sb,sb＋bt,bt＋sb, saorao,SAORAO,Fuck,shit,0,\\*,\\/,\\.,\\(,\\),（,）,:,;,-,_,－,谢先生,谢小姐,蔡先生,蔡小姐,常先生,常小姐,陈先生,陈小姐,陈女士,崔先生,崔小姐,高先生,高小姐,高女士,郭先生,郭小姐,郭女士,黄先生,黄小姐,黄女士,刘先生,刘小姐,刘女士,李先生,李小姐,李女士,王先生,王小姐,王女士,朱先生,朱小姐,朱女士,周先生,周小姐,周女士,郑先生,郑小姐,郑女士,赵先生,赵小姐,赵女士,张先生,张小姐,张女士,章先生,章小姐,杨先生,杨小姐,杨女士,徐先生,徐小姐,徐女士,许先生,许小姐,许女士,贾先生,贾小姐,季先生,季小姐,康先生,康小姐,路先生,路小姐,马先生,马小姐,马女士,彭先生,彭小姐,秦先生,秦小姐,任先生,任小姐,孙先生,孙小姐,谭先生,谭小姐,吴先生,吴小姐,叶先生,叶小姐,应先生,应小姐,于先生,于小姐,白先生,白小姐,包先生,包小姐,毕先生,毕小姐,曹先生,曹小姐,成先生,成小姐,程先生,程小姐,戴先生,戴小姐,邓先生,邓小姐,丁先生,丁小姐,董先生,董小姐,窦先生,窦小姐,杜先生,杜小姐,段先生,段小姐,方先生,方小姐,范先生,范小姐,冯先生,冯小姐,顾先生,顾小姐,古先生,古小姐,关先生,关小姐,管先生,管小姐,韩先生,韩小姐,潘先生,潘小姐,钱先生,钱小姐,齐先生,齐小姐,沈先生,沈小姐,石先生,石小姐,史先生,史小姐,宋先生,宋小姐,苏先生,苏小姐,唐先生,唐小姐,test,ceshi, ,郝先生,郝小姐,何先生,何小姐,贺先生,贺小姐,侯先生,侯小姐,胡先生,胡小姐,华先生,华小姐,江先生,江小姐,姜先生,姜小姐,蒋先生,蒋小姐,焦先生,焦小姐,金先生,金小姐,孔先生,孔小姐,梁先生,梁小姐,林先生,林小姐,罗先生,罗小姐,孟先生,孟小姐,牛先生,牛小姐,";
    if ([self isNotEmpty]) {
        NSString *regexStr = [self stringByAppendingString:@","];   // 加上逗号，匹配时变为绝对匹配
        BOOL isMatch = NO;
        if ([sensitiveWord isEmpty]) {
            isMatch = NO;
        }
        
        NSError* error = NULL;
        NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:regexStr
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:&error];
        NSInteger matchCnt = [regex numberOfMatchesInString:sensitiveWord options:0 range:NSMakeRange(0, sensitiveWord.length)];
        isMatch = (matchCnt > 0);
        
        if (isMatch) {
            return self;
        }
    }
    return nil;
}

- (NSString *)stringByReplaceWithAsteriskToIndex:(NSInteger)length {
    return [NSString stringWithFormat:@"%@%@",[@"**********************************************" substringToIndex:length],
            [self substringFromIndex:length]];
}

- (NSString *)stringByReplaceWithAsteriskFromIndex:(NSInteger)length {
    return [[self substringToIndex:length] stringByPaddingToLength:self.length withString:@"*" startingAtIndex:0];
}
- (NSString *)stringByInsertingWithFormat:(NSString *)format perDigit:(NSInteger)digit {
    NSMutableString *mString = [NSMutableString stringWithCapacity:2];
    for (int i = 0, count = 0; i < self.length; i ++) {
        unichar character = [self characterAtIndex:i];
        if ((i + 1) % digit == 0) {
            // 除最后一位外，都加上分隔符
            [mString appendFormat:@"%c%@", character, format];
            count ++;
        }
        else {
            [mString appendFormat:@"%c", character];
        }
    }
    
    return mString;
}
+ (NSString *)replaceUnicode:(NSString *)unicodeStr {
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}






//计算文本文字的矩形的尺寸
- (CGSize)sizeWithFont:(UIFont *)font MaxSize:(CGSize)maxSize
{
    //传入一个字体（大小号）保存到字典
    NSDictionary *attrs = @{NSFontAttributeName : font};
    //maxSize定义他的最大尺寸   当实际比定义的小会返回实际的尺寸，如果实际比定义的大会返回定义的尺寸超出的会剪掉，所以一般要设一个无限大 MAXFLOAT
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+(NSString *)displayDateWithJsonDate:(NSString *)jsondate formatter:(NSString *)formatter{
    
    return [self displayDateWithNSDate:[self parseJsonDate:jsondate] formatter:formatter];
    
}

+(NSString *)displayDateWithNSDate:(NSDate *)date formatter:(NSString *)formatter{
    
    NSTimeZone *tz=[NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    //NSTimeZone *tz=[NSTimeZone systemTimeZone];
    NSDateFormatter* f = [[NSDateFormatter alloc] init];
    [f setTimeZone:tz];
    [f setDateFormat:formatter];
    NSString* s=[f stringFromDate:date];
    return s;
    
}

+(NSDate *)parseJsonDate:(NSString *)jsondate{
    NSTimeInterval interval;
    NSRange range1 = [jsondate rangeOfString:@"/Date("];
    NSRange range2 = [jsondate rangeOfString:@")/"];
    if (range1.length ==0 && range2.length == 0) {
        interval = [jsondate longLongValue]/1000;
    }else{
        NSInteger start = range1.location + range1.length;
        NSInteger end = range2.location;
        
        NSCharacterSet* timezoneDelimiter = [NSCharacterSet characterSetWithCharactersInString:@"+-"];
        NSRange rangeOfTimezoneSymbol = [jsondate rangeOfCharacterFromSet:timezoneDelimiter];
        if (rangeOfTimezoneSymbol.length!=0) {
            NSInteger firstend = rangeOfTimezoneSymbol.location;
            
            NSRange secondrange=NSMakeRange(start, firstend-start);
            NSString* timeIntervalString = [jsondate substringWithRange:secondrange];
            
            unsigned long long s = [timeIntervalString longLongValue];
            interval = s/1000;
        }
        else {
            NSRange timerange=NSMakeRange(start, end-start);
            NSString* timestring =[jsondate substringWithRange:timerange];
            unsigned long long t = [timestring longLongValue];
            interval = t/1000;
        }
    }
    
    return [NSDate dateWithTimeIntervalSince1970:interval];
}








- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    CGSize textSize;
    if (CGSizeEqualToSize(size, CGSizeZero))
    {
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        textSize = [self sizeWithAttributes:attributes];
    }
    else
    {
        NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        //NSStringDrawingTruncatesLastVisibleLine如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。 如果指定了NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略 NSStringDrawingUsesFontLeading计算行高时使用行间距。（译者注：字体大小+行间距=行高）
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        CGRect rect = [self boundingRectWithSize:size
                                         options:option
                                      attributes:attributes
                                         context:nil];
        
        textSize = rect.size;
    }
    return textSize;
}

- (CGFloat)widthWithFont:(UIFont *)font height:(CGFloat)height
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGFloat width = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
    /*
     This method returns fractional sizes (in the size component of the returned CGRect); to use a returned size to size views, you must use raise its value to the nearest higher integer using the ceil function.
     */
    
    return ceil(width);
}

- (CGFloat)heightWithFont:(UIFont *)font width:(CGFloat)width
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGFloat height = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
    /*
     This method returns fractional sizes (in the size component of the returned CGRect); to use a returned size to size views, you must use raise its value to the nearest higher integer using the ceil function.
     */
    
    return ceil(height);
}

- (NSAttributedString *)attributStringWithPosition:(NSDictionary *)position color:(UIColor *)color font:(UIFont *)font
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self];
    for (int i = 0; i < position.allKeys.count; i++) {
        NSString* key = position.allKeys[i];
        NSString* val = position[key];
        if (color) {
            [attrString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange([key intValue],[val intValue])];
        }
        if (font) {
            [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange([key intValue],[val intValue])];
        }
    }
    
    return attrString;
}

//判断是否为整形：
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}
//判断是否为浮点形：
- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

// 字符串安全考虑
- (double)doubleValueSafe
{
    if (!self) {
        GH_NSString_LOG(@"[NSString doubleValue] nil - null 问题-- [%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        return 0;
    }
    return [self doubleValue];;
}
- (float)floatValueSafe
{
    if (!self) {
        GH_NSString_LOG(@"[NSString floatValue] nil - null 问题-- [%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        return 0;
    }
    return [self floatValue];
}
- (NSInteger)integerValueSafe
{
    if (!self) {
        GH_NSString_LOG(@"[NSString integerValue] nil - null 问题-- [%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        return 0;
    }
    return [self integerValue];
}
- (int)intValueSafe
{
    if (!self) {
        GH_NSString_LOG(@"[NSString intValue] nil - null 问题-- [%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        return 0;
    }
    return [self intValue];
}
- (NSInteger)lengthSafe
{
    if (!self) {
        GH_NSString_LOG(@"[NSString length] nil - null 问题-- [%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        return 0;
    }
    return [self length];
}



#pragma mark - MD5加密
// 对字符串进行MD5加密
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *)MD5WithData:(NSData *)data
{
    NSString* s=@"";
    if (data!=nil && data.length>0) {
        
        CC_MD5_CTX md5;
        CC_MD5_Init(&md5);
        
        NSData* fileData = data;
        CC_MD5_Update(&md5, [fileData bytes],(int)[fileData length]);
        
        unsigned char result[16];
        CC_MD5_Final(result, &md5);
        
        s = [NSString stringWithFormat:
             @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ];
    }
    return s;
    
}

+ (NSString *)getOnlyStringByNowDate
{
    long long nowDateNum = [self getDateTimeTOMilliSeconds:[NSDate new]];
    NSString *nowDateStr = [NSString stringWithFormat:@"%llu", nowDateNum];
    
    NSInteger randomNum = arc4random() % 10000;
    NSString *randomStr = [NSString stringWithFormat:@"%li", (long)randomNum];
    
    NSString *mergeStr = [NSString stringWithFormat:@"%@%@", nowDateStr, randomStr];
    NSString *result = [self md5:mergeStr];
    return result;
}

- (NSDate *)getDateTimeFromMilliSeconds:(long long) miliSeconds
{
    NSTimeInterval tempMilli = miliSeconds;
    NSTimeInterval seconds = tempMilli/1000.0;
    NSLog(@"seconds=%f",seconds);
    return [NSDate dateWithTimeIntervalSince1970:seconds];
}

//将NSDate类型的时间转换为NSInteger类型,从1970/1/1开始
+ (long long)getDateTimeTOMilliSeconds:(NSDate *)datetime
{
    
    NSTimeInterval interval = [datetime timeIntervalSince1970];
    //    NSLog(@"interval=%f",interval);
    long long totalMilliseconds = interval * 1000 * 1000 * 1000 ;
    //    NSLog(@"totalMilliseconds=%llu",totalMilliseconds);
    return totalMilliseconds;
    
}
#pragma mark - 计算文件大小
- (unsigned long long)ga_fileSize
{
    // 计算self这个文件夹\文件的大小
    
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 文件类型
    NSDictionary *attrs = [mgr attributesOfItemAtPath:self error:nil];
    NSString *fileType = attrs.fileType;
    
    if ([fileType isEqualToString:NSFileTypeDirectory]) { // 文件夹
        // 获得文件夹的遍历器
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        
        // 总大小
        unsigned long long fileSize = 0;
        
        // 遍历所有子路径
        for (NSString *subpath in enumerator) {
            // 获得子路径的全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            fileSize += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
        }
        
        return fileSize;
    }
    
    // 文件
    return attrs.fileSize;
}
- (instancetype)cacheDir
{
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return [dir stringByAppendingPathComponent:[self lastPathComponent]];
}
- (instancetype)docDir
{
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [dir stringByAppendingPathComponent:[self lastPathComponent]];
}

- (instancetype)tmpDir
{
    NSString *dir = NSTemporaryDirectory();
    return [dir stringByAppendingPathComponent:[self lastPathComponent]];
}
/**
 *  字符串反转
 */
- (NSString*)reverseWordsInString:(NSString*)str
{
    NSMutableString *reverString = [NSMutableString stringWithCapacity:str.length];
    [str enumerateSubstringsInRange:NSMakeRange(0, str.length) options:NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences  usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [reverString appendString:substring];
    }];
    return reverString;
}
/**
 *  字符串按多个符号分割
 */
- (NSArray *)componentsSeparatedBySthString:(NSString *)str;
{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:str];
    return [self componentsSeparatedByCharactersInSet:set];
}
/**
 *  获取汉字的拼音
 */
+ (NSString *)transform:(NSString *)chinese
{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    NSLog(@"%@", pinyin);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    //返回最近结果
    return pinyin;
}


//Des加密
+(NSString *) encryptUseDES:(NSString *)plainText{
    NSString *ciphertext = nil;
    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [gkey UTF8String], kCCKeySizeDES,
                                          iv,
                                          [textData bytes], dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [GTMBase64 stringByEncodingData:data];
    }
    return ciphertext;
}

//Des解密
+(NSString *)decryptUseDES:(NSString *)cipherText {
    NSString *plaintext = nil;
    NSData *cipherdata = [GTMBase64 decodeString:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [gkey UTF8String], kCCKeySizeDES,
                                          iv,
                                          [cipherdata bytes], [cipherdata length],
                                          buffer, 1024,
                                          &numBytesDecrypted);
    if(cryptStatus == kCCSuccess)
    {
        NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
    }
    return plaintext;
}

#pragma mark - 32位 小写
+(NSString *)MD5ForLower32Bate:(NSString *)str{
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

#pragma mark - 32位 大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str{
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}

#pragma mark - 16位 大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str{
    NSString *md5Str = [self MD5ForUpper32Bate:str];
    NSString *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


#pragma mark - 16位 小写
+(NSString *)MD5ForLower16Bate:(NSString *)str{
    NSString *md5Str = [self MD5ForLower32Bate:str];
    NSString *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}

@end
