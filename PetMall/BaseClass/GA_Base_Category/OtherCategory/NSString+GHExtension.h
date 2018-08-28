//
//  NSString+GHExtension.h
//  GA_Base_FrameWork
//
//  Created by GhGh on 15/10/29.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (GHExtension)

// 以下是方法
- (BOOL)isEmpty;
- (BOOL)isNotEmpty;
// 判断字符串是否为敏感词，如果是敏感词，返回该词，如果不是返回nil
- (NSString *)sensitiveWord;
// 将一串字符的前xx位变为"*"号
- (NSString *)stringByReplaceWithAsteriskToIndex:(NSInteger)length;
// 将一串字符的后xx位变为"*"号
- (NSString *)stringByReplaceWithAsteriskFromIndex:(NSInteger)length;
// 每x位用指定字符分隔字符串
- (NSString *)stringByInsertingWithFormat:(NSString *)format perDigit:(NSInteger)digit;
// 显示'\U...'unicode编码的正确文字
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;




/*
 得到NSString的Size
 */
- (CGSize)sizeWithFont:(UIFont *)font MaxSize:(CGSize)maxSize;
// 返回 1970 时间戳
+ (NSString *)displayDateWithJsonDate:(NSString *)jsondate formatter:(NSString *)formatter;
// 判断时间 与 当前时间比较，之前的返回 NO，现在或者之后的返回YES


- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

/**
 *  获取字符对应的label宽度
 *
 *  @param font   label字体
 *  @param height label固定高度
 *
 *  @return label宽度 官方文档提示：如果该宽度用于创建label，建议通过ceil函数处理进行处理
 */
- (CGFloat)widthWithFont:(UIFont *)font height:(CGFloat)height;
- (CGFloat)heightWithFont:(UIFont *)font width:(CGFloat)width;

/**
 *  返回属性字符串
 *
 *  @param position 修改属性的位置
 *  @param color    position位置处的字符串待设置颜色
 *  @param font     position位置处的字符串待设置字体
 *
 *  @return 返回修改完成后的属性字符串
 */
- (NSAttributedString *)attributStringWithPosition:(NSDictionary *)position color:(UIColor *)color font:(UIFont *)font;



//判断是否为整形：
- (BOOL)isPureInt:(NSString*)string;
//判断是否为浮点形：
- (BOOL)isPureFloat:(NSString*)string;


// 字符串安全考虑
- (double)doubleValueSafe;
- (float)floatValueSafe;
- (NSInteger)integerValueSafe;
- (int)intValueSafe;
- (NSInteger)lengthSafe;



/**
 *  md5加密
 */
/**
 *  对字符串进行MD5加密
 *
 *  @param string 需要加密的字符串
 *
 *  @return 加密后的字符串
 */
+ (NSString *)md5:(NSString *)string;

/**
 *  对数据流进行MD5加密
 *
 *  @param data 需要加密的数据流
 *
 *  @return 加密后的字符串
 */
+(NSString *)MD5WithData:(NSData *)data;

/*
 *由于MD5加密是不可逆的,多用来进行验证
 */
// 32位小写
+(NSString *)MD5ForLower32Bate:(NSString *)str;
// 32位大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str;
// 16为大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str;
// 16位小写
+(NSString *)MD5ForLower16Bate:(NSString *)str;


/**
 *  使用时间戳生成一个唯一的字符串
 */
+ (NSString *)getOnlyStringByNowDate;


/**
 *  根据文件名计算出文件大小
 */
- (unsigned long long)ga_fileSize;
/**
 *  生成缓存目录全路径
 */
- (instancetype)cacheDir;
/**
 *  生成文档目录全路径
 */
- (instancetype)docDir;
/**
 *  生成临时目录全路径
 */
- (instancetype)tmpDir;
/**
 *  字符串反转
 */
- (NSString *)reverseWordsInString:(NSString *)str;
/**
 *  字符串按多个符号分割 例如某个字符串是@"abd,1233.cdn"，则str需要为@",."即可
 */
- (NSArray *)componentsSeparatedBySthString:(NSString *)str;
/**
 *  获取汉字的拼音
 */
+ (NSString *)transform:(NSString *)chinese;

// DES加密
+(NSString *) encryptUseDES:(NSString *)plainText;

//解密方法
+(NSString *)decryptUseDES:(NSString *)cipherText;


@end
