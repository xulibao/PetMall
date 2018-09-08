//
//  STHelpTools.h
//  SnailTruck
//
//  Created by 木鱼 on 15/11/5.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "IQKeyboardReturnKeyHandler.h"

typedef enum
{
    IDCARD_IS_VALID = 0,                            //合法身份证
    IDCARD_LENGTH_SHOULD_NOT_BE_NULL,               //身份证号码不能为空
    IDCARD_LENGTH_SHOULD_BE_MORE_THAN_15_OR_18,     //身份证号码长度应该为15位或18位
    IDCARD_SHOULD_BE_15_DIGITS,                     //身份证15位号码都应为数字
    IDCARD_SHOULD_BE_17_DIGITS_EXCEPT_LASTONE,      //身份证18位号码除最后一位外，都应为数字
    IDCARD_BIRTHDAY_SHOULD_NOT_LARGER_THAN_NOW,     //身份证出生年月日不能大于当前日期
    IDCARD_BIRTHDAY_IS_INVALID,                     //身份证出生年月日不是合法日期
    IDCARD_REGION_ENCODE_IS_INVALID,                //输入的身份证号码地域编码不符合大陆和港澳台规则
    IDCARD_IS_INVALID,                              //身份证无效，不是合法的身份证号码
    IDCARD_PARSER_ERROR,                            //解析身份证发生错误
}IdCardValidationType;
@class STBaseViewController;
static NSInteger getVerTime = 60;
@interface STHelpTools : NSObject
// 计算文件大小
+ (NSInteger)sizeWithPath:(NSString *)cachesPath;

// tost-
+ (void)showToastWithMessage:(NSString* )text;

+ (void)showLoadingInView:(UIView *)view useSystemNav:(BOOL)systemNav;
+ (void)hideLoadingInView:(UIView *)view;
// 加载弹框 图片
//+ (void)showToastPictureWithImageStr:(NSString *)pictureStr contentStr:(NSString *)contentStr leftBtnStr:(NSString *)leftStr rightBtnStr:(NSString *)rightStr LrftBtnTextColor:(UIColor *)leftColor rightBtnTextColor:(UIColor *)rightColor leftBtnClick:(void(^)())leftBtnClick rightBtnClick:(void(^)())rightBtnClick;

//拼接上传图片名称
+ (NSString *)getImageName;
+ (NSString *)getImageNameWithIndex:(NSInteger)index;

//按钮倒计时
+ (void)timeCountDown:(NSInteger)timeCountNum button:(UIButton *)button;

//压缩图片
+ (NSArray*)minImageFileArray:(NSArray*)imageArray wantSize:(CGFloat)wantSize;
+ (UIImage*)minImageFile:(UIImage*)image wantSize:(CGFloat)wantSize isWatermark:(BOOL)isWatermark;
//获取到当前的Controller
+ (UIViewController *)getCurrentVC;


////启动键盘监听-
//+ (void)openMonitorKeyBorad;
//+ (void)stopMonitorKeyBoradWithReturnKeyHandler:(IQKeyboardReturnKeyHandler *)returnKeyHandler;
// json转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

// 字典转json
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

//// 下拉刷新
//+ (void)addRefreshTableView:(UIScrollView*)tableView block:(void(^)())action;
//
//// 加载更多
//+ (void)addFooterTableView:(UIScrollView*)tableView block:(void(^)())action;

//大小屏适应字体--
+ (UIFont *)AdaptiveFontWithFontFloat:(CGFloat)fontFloat;

//是否加载引导页
+ (void)loadMainController;

//验证是否为手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

// 汉字
+ (BOOL)validateHanZi:(NSString*)str;

#pragma mark - 友盟统计
// 页面统计的时候，直接传入页面类名 － 已经封装完毕
+ (void)beginLogPageView:(NSString *)pageName;
// 页面统计的时候，直接传入页面类名 － 已经封装完毕
+ (void)endLogPageView:(NSString *)pageName;
// 点击事件统计,例如按钮点击 eventId 是名字
+ (void)event:(NSString *)eventId;
//NSDictionary *dict = @{@"type" : @"book", @"quantity" : @"3"};
//[MobClick event:@"purchase" attributes:dict];
+ (void)event:(NSString *)eventId attributes:(NSDictionary *)attributes isNeedUserId:(BOOL)isNeedUsrId andIsNeedCity:(BOOL)isNeedCity;
// 获取设备唯一标示
+ (NSString *)gen_uuid;
// 获取当前时间戳 - 十位数
+ (NSString *)timeStampStr;
// 检查 车牌 号码 正则
+ (BOOL)validateCarNo:(NSString*)carNo;

// 位数修补,如果是12.200 -> 12.2; 如果是12.00 -> 12; 如果是12.34 -> 12.34
+ (NSString *)repairCorrectNum:(NSString *)tempString;
// NSNumber 或者 NSString
+ (NSString *)repairNSNumber:(NSString *)number;

/** 生成唯一字符串 */
+ (NSString *)generateUniqueRandomString;

//
+ (UIImage *)imageAddImageWatermarkWithBaseImage:(UIImage *)baseImage logoImahe:(UIImage *)logoImage;

//将字典转换成json串
+ (NSString *)jsonFromDictionary:(NSDictionary *)dic;

/** 设置离线用户推送tag */
+ (void)setOffLineUserBindingTag;

// 时间工具  判断今年 刚刚 等 用在 聊天室
+ (NSString*)timeWithCreatTime:(NSDate *)date;

// 检测一个网络图片是否在缓存或者内存中,没有返回默认图 - 分享使用
+ (UIImage *)checkImageWithURL:(NSString *)urlStr;

// 身份证是否有效
+ (IdCardValidationType)isIdCardNumberValid:(NSString *)idNumber;
// 通过身份证号得到 生日
+ (NSDate *)getBirthday:(NSString *)idNumber;
/** 银行卡号有效性问题Luhn算法
 */
+ (BOOL)bankCardluhmVerify:(NSString *)string;
#pragma mark - 在时间段之内要求格式2018-1-2
+ (BOOL)isRangeTimeForm:(NSString *)formTimeStr toTime:(NSString *)toTimeStr;
@end
