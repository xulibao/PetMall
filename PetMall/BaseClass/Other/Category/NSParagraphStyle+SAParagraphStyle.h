#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//Modify from QMUI

@interface NSMutableParagraphStyle (SAParagraphStyle)

/**
 *  快速创建一个NSMutableParagraphStyle，等同于`sa_paragraphStyleWithLineHeight:lineBreakMode:NSLineBreakByWordWrapping textAlignment:NSTextAlignmentLeft`
 *  @param  lineHeight      行高
 *  @return 一个NSMutableParagraphStyle对象
 */
+ (instancetype)sa_paragraphStyleWithLineHeight:(CGFloat)lineHeight;

/**
 *  快速创建一个NSMutableParagraphStyle，等同于`sa_paragraphStyleWithLineHeight:lineBreakMode:textAlignment:NSTextAlignmentLeft`
 *  @param  lineHeight      行高
 *  @param  lineBreakMode   换行模式
 *  @return 一个NSMutableParagraphStyle对象
 */
+ (instancetype)sa_paragraphStyleWithLineHeight:(CGFloat)lineHeight lineBreakMode:(NSLineBreakMode)lineBreakMode;

/**
 *  快速创建一个NSMutableParagraphStyle
 *  @param  lineHeight      行高
 *  @param  lineBreakMode   换行模式
 *  @param  textAlignment   文本对齐方式
 *  @return 一个NSMutableParagraphStyle对象
 */
+ (instancetype)sa_paragraphStyleWithLineHeight:(CGFloat)lineHeight lineBreakMode:(NSLineBreakMode)lineBreakMode textAlignment:(NSTextAlignment)textAlignment;
@end
