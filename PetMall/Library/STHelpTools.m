//
//  STHelpTools.m
//  SnailTruck
//
//  Created by 木鱼 on 15/11/5.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "STHelpTools.h"

#import "STTabBarController.h"
//#import "STGuidePageController.h"
#import "KeychainItemWrapper.h" // 钥匙串

#import "UIImage+GIF.h"

//#import <IQKeyboardManager.h>

#import "NSString+STValid.h"

static NSString *userUuid;
@interface STHelpTools ()

@end

@implementation STHelpTools
+ (NSInteger)sizeWithPath:(NSString *)cachesPath
{
    // 1.获取文件管理者
    NSFileManager *manger = [NSFileManager defaultManager];
    // 2.判断路径是否合法
    BOOL directory = NO; // 是否时目录
    // fileExistsAtPath 需要判断的文件路径
    // isDirectory 如果时文件夹就会赋值为YES
    BOOL exists = [manger fileExistsAtPath:cachesPath isDirectory:&directory];
    if (!exists) return 0;
    
    // 3.判断是文件还是文件夹
    if (directory) {
        
        
        //  subpathsOfDirectoryAtPath : 可以获取文件夹下面所有的文件以及子文件夹中的文件
        NSArray *subPaths = [manger subpathsOfDirectoryAtPath:cachesPath error:nil];
        //        NSLog(@"subPaths = %@", subPaths);
        
        // 3.1拼接全路径
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *sdCachesPath = [cachesPath stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
        // 3.2累加文件的大小
        NSInteger totalSize = 0;
        for (NSString *subpath in subPaths) {
            NSString *fullPath = [sdCachesPath stringByAppendingPathComponent:subpath];
            //             NSLog(@"fullPath = %@", fullPath);
            // 3.2.1利用文件管理者获取文件的大小
            // 判断是否是文件夹
            BOOL dir = NO;
            [manger fileExistsAtPath:fullPath isDirectory:&dir];
            if (!dir) {
                // 不是文件夹
                NSDictionary *attr = [manger attributesOfItemAtPath:fullPath error:nil];
                totalSize += [attr[NSFileSize] integerValue];
            }
        }
        
        return totalSize;
        
    }else
    {
        // 是文件
        // 3.2如果时文件, 直接获取大小后返回'
        NSDictionary *attr = [manger attributesOfItemAtPath:cachesPath error:nil];
        return [attr[NSFileSize] intValue];
    }
    return 0;
    
}


+ (NSString *)getImageName {
    return [self getImageNameWithIndex:0];
}

+ (NSString *)getImageNameWithIndex:(NSInteger)index
{
    //时间字符串
    NSDateFormatter *formatter;
    NSString  *dateString;
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    dateString = [formatter stringFromDate:[NSDate date]];
    dateString = [dateString substringFromIndex:2];
    
    //设备信息
    NSString * deviceStr =[UIDevice currentDevice].identifierForVendor.UUIDString;
//    NSString * deviceStr =[STAccount shareAccount].user_id;
    
    //部位
    NSString * position = [NSString stringWithFormat:@"%ld",index];
    
    //随机数
    int i = arc4random() % 10;
    int j = arc4random() % 10;
    
    //图片后缀NWM
    NSString *imageFlag = @"NWM";
    
    //图片名字
    NSString * imageName = [NSString stringWithFormat:@"%@_ios%@_%@%d%d%@.jpg",position,dateString,deviceStr,i,j,imageFlag];
    
    return imageName;
}

//图片压缩
+ (NSArray*)minImageFileArray:(NSArray*)imageArray wantSize:(CGFloat)wantSize{
    
    // 1.获取image
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"沙盒地址: %@", documentsDirectory);
    
    
    NSMutableArray* resultArray = [NSMutableArray array];
    // 2.压缩图片
    for (int i = 0; i<imageArray.count; i++) {
        UIImage* image = [self miniImage:imageArray[i] documentsDirectory:documentsDirectory index:i wantSize:wantSize isWatermark:NO];
        [resultArray addObject:image];
    }
    
    return resultArray;
}

+ (UIImage*)minImageFile:(UIImage*)image wantSize:(CGFloat)wantSize isWatermark:(BOOL)isWatermark{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSLog(@"沙盒地址: %@", documentsDirectory);
    
    image = [self miniImage:image documentsDirectory:documentsDirectory index:0 wantSize:wantSize isWatermark:isWatermark];
    
    return image;
}



// 压缩图片
+ (UIImage*)miniImage:(UIImage*)image documentsDirectory:(NSString*)documentsDirectory index:(NSInteger)index wantSize:(int)wantSize isWatermark:(BOOL)isWatermark{
    
    UIImage * logoImage ;
    if (isWatermark) {
      logoImage = [UIImage imageNamed:@"logo_watermark"];
    }

    
    // Create a graphics image context
    
   
    CGFloat imageW = 375;
    CGFloat p = image.size.width / image.size.height;
    CGSize newSize = CGSizeMake(imageW, imageW / p);
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    CGFloat tempP = 120/ 320.0f;
    CGFloat logoP = logoImage.size.width / logoImage.size.height;
    CGFloat waterW = newSize.width * tempP;
    CGFloat waterH = waterW / logoP;
    CGFloat waterX = 3;
    CGFloat waterY = newSize.height - waterH ;
    
    [logoImage drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();

    
//   image = [self imaheAddImageWatermarkWithBaseImage:image logoImahe:logoImage withRect:rect];
    
    // 2.存入沙盒，NSFileManger来查看图片准确大小
    NSData* saveData = UIImageJPEGRepresentation(newImage, 1);
    NSString* saveName =[NSString stringWithFormat:@"%@%@", [self currentTime:index], [self typeForImageData:saveData]] ;
    NSString *imageDocPath = [documentsDirectory stringByAppendingPathComponent:saveName];
    [saveData writeToFile:imageDocPath atomically:YES];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:saveName];
    CGFloat NewFileSize = [self fileSizeAtPath:path]/1024;
    NSLog(@"比例压缩后图片大小：%luKB------manager", (unsigned long)NewFileSize);
    
    // 3.如果压缩后的大小不符合要求，降品压缩，（设置的目标压缩文件为wantSize）
    if(NewFileSize > wantSize){
        saveData = UIImageJPEGRepresentation(newImage,  0.9);
    }
    newImage = [UIImage imageWithData:saveData];
    [saveData writeToFile:imageDocPath atomically:YES];
    NSLog(@"品质压缩后图片大小：%luKB------manager      %@", (unsigned long)[self fileSizeAtPath:path]/1024,NSStringFromCGSize(newImage.size));
    
//    newImage = [STHelpTools imageAddImageWatermarkWithBaseImage:image logoImahe:[UIImage imageNamed:@"logo_watermark"] ];
    
    return newImage;
    
}

+ (UIImage *)imageAddImageWatermarkWithBaseImage:(UIImage *)baseImage logoImahe:(UIImage *)logoImage
{
    UIGraphicsBeginImageContext(baseImage.size);
    [baseImage drawInRect:CGRectMake(0, 0, baseImage.size.width, baseImage.size.height)];
    
    CGFloat waterW = logoImage.size.width ;
    CGFloat waterH = logoImage.size.height;
    CGFloat waterX = 3;
    CGFloat waterY = baseImage.size.height - waterH ;
    
    [logoImage drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


//单个文件的大小
+ (long long) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}



// 根据二进制得到图片类型
+ (NSString *)typeForImageData:(NSData *)data {
    
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    switch (c) {
            
        case 0xFF:
            
            return @".jpeg";
            
        case 0x89:
            
            return @".png";
            
        case 0x47:
            
            return @".gif";
            
        case 0x49:
            
        case 0x4D:
            
            return @".tiff";
        default:
            break;
            
    }
    
    return nil;
    
}


// 当前时间命名
+ (NSString*)currentTime:(NSInteger)index{
    
    return [NSString stringWithFormat:@"%ld", (long)index];
    
}
//按钮倒计时
+ (void)timeCountDown:(NSInteger)timeCountNum button:(UIButton *)button
{
    __block NSInteger timeout = timeCountNum; //倒计时时间
    // 发送网络请求
    //    [self verificationBtn];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                button.enabled = YES;
                [button setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
        }else{
            int seconds = timeout % 120;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                button.enabled = NO;
                [button setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
            });
            timeout--;
            getVerTime = timeout;
            if (timeout ==0) {
                getVerTime = 60;
            }
            
            
        }
    });
    dispatch_resume(_timer);
}

//// 启动键盘监听
//+ (void)openMonitorKeyBorad
//{
//    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
//    manager.enable = YES;
//    manager.shouldResignOnTouchOutside = YES;
//    manager.shouldToolbarUsesTextFieldTintColor = YES;
//    manager.enableAutoToolbar = NO;
//}
//
//+ (void)stopMonitorKeyBoradWithReturnKeyHandler:(IQKeyboardReturnKeyHandler *)returnKeyHandler
//{
//    returnKeyHandler = nil;
//}

// json转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

// 字典转json
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    if (dic == nil) {
        return nil;
    }
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//// 下拉刷新
//+ (void)addRefreshTableView:(UIScrollView*)tableView block:(void(^)())action{
//
//     MJRefreshGifHeader* header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
//     if (action) {
//     action();
//     }
//
//     }];
//
////     NSMutableArray* arr = [[NSMutableArray alloc] init];
////     for (int i = 1; i<= 5; i++) {
////     UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%d", i]];
////     [arr addObject:image];
////     }
//////      设置普通状态的动画图片
////     [header setImages:@[[UIImage imageNamed:@"refresh1"]] forState:MJRefreshStateIdle];
//////      设置即将刷新状态的动画图片（一松开就会刷新的状态）
////     [header setImages:@[[UIImage imageNamed:@"refresh1"]] forState:MJRefreshStatePulling];
//////      设置正在刷新状态的动画图片
////     [header setImages:arr forState:MJRefreshStateRefreshing];
//
//    UIImage *image = [UIImage sd_animatedGIFNamed:@"newRefresh"];
//    header.gifView.image = image;
//    header.lastUpdatedTimeLabel.hidden = YES;
//    tableView.mj_header = header;
//
////    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
////        // 进入刷新状态后会自动调用这个block
////        if (action) {
////            action();
////        }
////
////    }];
//
//}
//
//// 加载更多
//+ (void)addFooterTableView:(UIScrollView*)tableView block:(void(^)())action{
//
//    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        // 进入刷新状态后会自动调用这个block
//        if (action) {
//            action();
//        }
//    }];
//
//}
+ (UIFont *)AdaptiveFontWithFontFloat:(CGFloat)fontFloat
{
    UIFont * font;
    if (kMainBoundsWidth < 375) {
        font = [UIFont fontWithName:@"Helvetica" size:fontFloat - 1];
        
    }else if (kMainBoundsWidth == 375){
        font = [UIFont fontWithName:@"Helvetica" size:fontFloat];
    }else if (kMainBoundsWidth > 375){
        font = [UIFont fontWithName:@"Helvetica" size:fontFloat + 1];
    }
    return font;
}

+(void)loadMainController
{
   
    NSString * key = (__bridge_transfer NSString *)kCFBundleVersionKey;
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * localVersion = [defaults objectForKey:key];
    NSDictionary * dict = [NSBundle mainBundle].infoDictionary;
    NSString * currtenVersion = dict[key];
//#pragma mark - V2.3.0 不进行新特性显示
    if ([currtenVersion compare:localVersion] == NSOrderedDescending) {
          //新版本
//        STGuidePageController *guidePage = [[STGuidePageController alloc] init];
//        [defaults setObject:currtenVersion forKey:key];
//        [defaults synchronize];
//        UIWindow * window =[[UIApplication sharedApplication].delegate window];
//        window.rootViewController = guidePage;
        
    }else{
//        老版本
////        STTabBarController * vc = [STTabBarController sharedSTTabBarController];
//        UIWindow *window =[[UIApplication sharedApplication].delegate window];
//        window.rootViewController = vc;
    }
    
}

+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
    result = nextResponder;
    else
    result = window.rootViewController;
    return result;
}



//验证是否为手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum == nil || mobileNum.length == 0) {
        return NO;
    }
    NSString * regex = @"([0-9]{11})";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:mobileNum];
    
    BOOL isMobileNumber = NO;
    NSString * firstChar = [mobileNum substringToIndex:1];
    if ([firstChar isEqualToString:@"1"] && isMatch){
        isMobileNumber =  YES;
        
        NSArray *secondCharArray = @[@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        NSRange secondRange = NSMakeRange(1, 1);
        NSString * secondChar = [mobileNum substringWithRange:secondRange];
        
        for (NSString * charStr in secondCharArray) {
            
            if ([charStr isEqualToString:secondChar]) {
                isMobileNumber = YES;
                return isMobileNumber;
            }else{
                isMobileNumber = NO;
            }
        }
    }else{
        isMobileNumber =   NO;
    }
    return isMobileNumber;
}
// NSNumber 或者 NSString
+ (NSString *)repairNSNumber:(NSString *)number{
    if ([number isKindOfClass:[NSNumber class]]) {
        NSNumber *tempNum = (NSNumber *)number;
        return tempNum.stringValue;
    }
    return number;
}
// 获取设备唯一标示
+ (NSString *)gen_uuid
{
    if (userUuid == nil) {
        KeychainItemWrapper *keyChainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"wghWoNiuHuoChe" accessGroup:nil];
        NSString *strUUID = [keyChainItem  objectForKey:(id)kSecAttrAccount];
        if (strUUID == nil || [strUUID isEqualToString:@""])
        {
            [keyChainItem setObject:@"myChainValues" forKey:(id)kSecAttrService];
            [keyChainItem setObject:[self getUUid] forKey:(id)kSecAttrAccount];
            userUuid = [self getUUid];
        }else
        {
           userUuid = strUUID;
           return strUUID;
        }
    }
    return userUuid;
}
+ (NSString *)getUUid
{
    if (userUuid == nil) {
        CFUUIDRef uuid_ref=CFUUIDCreate(nil);
        CFStringRef uuid_string_ref =CFUUIDCreateString(nil, uuid_ref);
        CFRelease(uuid_ref);
        NSString *uuid=[NSString stringWithString:(__bridge NSString *)(uuid_string_ref)];
        userUuid = uuid;
        CFRelease(uuid_string_ref);
    }
    return userUuid;
}
// 获取当前时间戳
+ (NSString *)timeStampStr;
{
    NSDate *localDate = [NSDate date]; //获取当前时间
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localDate timeIntervalSince1970]];
    return timeSp;
}

// 检查 车牌 号码 正则
+ (BOOL)validateCarNo:(NSString*)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:carNo];
}
// 汉字
+ (BOOL)validateHanZi:(NSString*)str
{
    NSString *carRegex = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:str];
}

// 位数修补,如果是12.200 -> 12.2; 如果是12.00 -> 12; 如果是12.34 -> 12.34
+ (NSString *)repairCorrectNum:(NSString *)tempString
{
    if (!tempString) {
        return @"0";
    }
    if ([tempString isKindOfClass:[NSNumber class]]) {
        tempString = [NSString stringWithFormat:@"%@",tempString];
    }
    NSRange dotRange = [tempString rangeOfString:@"\\." options:NSRegularExpressionSearch];
    if (dotRange.location == NSNotFound) return tempString;
    
    tempString = [NSString stringWithFormat:@"%.2f",[tempString doubleValue]];
    NSRange zeroRange = [tempString rangeOfString:@"0+$" options:NSRegularExpressionSearch];
    if (zeroRange.location == NSNotFound) return tempString;
    
    tempString = [tempString substringToIndex:zeroRange.location];
    
    if (zeroRange.location == dotRange.location + dotRange.length) {
        tempString = [tempString substringToIndex:dotRange.location];
    }
    return tempString;
}

+ (NSString *)generateUniqueRandomString
{
    CFUUIDRef uuidRef =CFUUIDCreate(NULL);
    CFStringRef uuidStringRef =CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *uniqueId = (__bridge_transfer NSString *)uuidStringRef;
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"mmss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    int randomValue =arc4random() %[ dateString length];
    NSString *unique = [NSString stringWithFormat:@"%@%d",dateString,randomValue];
    NSString *uniqueStr = [NSString stringWithFormat:@"%@%@.jpg",uniqueId,unique];
    return uniqueStr;
}
//将字典、数组转换成json串
+ (NSString *)jsonFromDictionary:(NSDictionary *)dic
{
    if (dic == nil || dic.count == 0) {
        return @"";
    }
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/** 设置离线用户推送tag */
+ (void)setOffLineUserBindingTag
{
//    if ([STAccount isLog]) {
//        STAccount *account = [STAccount shareAccount];
//        NSString *uid = [NSString stringWithFormat:@"000000%@",account.user_id];
//        NSSet *jpushSet = nil;
//        if (KOpen_DebugView) {
//            jpushSet = [NSSet setWithObjects:JPUSH_ON_LINE, @"dev",nil];
//        }else{
//            jpushSet = [NSSet setWithObject:JPUSH_ON_LINE];
//        }
//        [JPUSHService setTags:jpushSet alias:uid callbackSelector:nil object:nil];
//        // growing IO - cs1
////        NSString *beMakeString1 = [NSString stringWithFormat:@"%@",account.loginName];
////        if (KOpen_DebugView) {
////            [Growing disable];
////        }else{
////        [Growing setCS1Value:beMakeString1 forKey:@"loginName"];
////        // cs2
////        NSString *beMakeString2 = [NSString stringWithFormat:@"%@",account.user_id];
////        [Growing setCS2Value:beMakeString2 forKey:@"id"];
////        }
//    }else{
//        // 离线
//        NSSet *jpushSet = nil;
//        if (KOpen_DebugView) {
//            jpushSet = [NSSet setWithObjects:JPUSH_OFF_LINE, @"dev",nil];
//        }else{
//            jpushSet = [NSSet setWithObject:JPUSH_OFF_LINE];
//        }
//        [JPUSHService setTags:jpushSet alias:@"" callbackSelector:nil object:nil];
////        if (KOpen_DebugView) {
////            [Growing disable];
////        }else{
////        [Growing setCS1Value:nil forKey:@"loginName"];
////        [Growing setCS2Value:nil forKey:@"id"];
////        }
//    }
}

//// 加载弹框 图片
//+ (void)showToastPictureWithImageStr:(NSString *)pictureStr contentStr:(NSString *)contentStr leftBtnStr:(NSString *)leftStr rightBtnStr:(NSString *)rightStr LrftBtnTextColor:(UIColor *)leftColor rightBtnTextColor:(UIColor *)rightColor leftBtnClick:(void(^)())leftBtnClick rightBtnClick:(void(^)())rightBtnClick
//{
//    [STToastPictureView showToastPictureWithImageStr:pictureStr contentStr:contentStr leftBtnStr:leftStr rightBtnStr:rightStr LrftBtnTextColor:leftColor rightBtnTextColor:rightColor leftBtnClick:^{
//        if (leftBtnClick) {
//            leftBtnClick();
//        }
//    } rightBtnClick:^{
//        if (rightBtnClick) {
//            rightBtnClick();
//        }
//    }];
//}

// 时间工具  判断今年 刚刚 等 用在 聊天室
+ (NSString*)timeWithCreatTime:(NSDate*)date{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //    _created_at = @"Tue Sep 30 17:06:25 +0600 2014";
    // 微博的创建日期
    NSDate *createDate = date;
    // 当前时间
    NSDate *now = [NSDate date];
    // 日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    if ([createDate isThisYear]) { // 今年
        if ([createDate isToday]) { // 今天
            if (cmps.minute >= 10) {
                fmt.dateFormat = @"HH:mm";
                return [fmt stringFromDate:createDate];
            } else {
                return @"刚刚";
            }
        } else { // 今年的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
}
// 检测一个网络图片是否在缓存或者内存中,没有返回默认图 - 分享使用
+ (UIImage *)checkImageWithURL:(NSString *)urlStr
{
//    NSURL *url = [NSURL URLWithString:urlStr];
//    SDWebImageManager *manager = [SDWebImageManager sharedManager];
//    // YY
//    YYWebImageManager *yyManager = [YYWebImageManager sharedManager];
//    YYImageCache *yyCache = [YYImageCache sharedCache];
//    // 先使用 SDW
//    if ([manager diskImageExistsForURL:url]) {
//        return [[manager imageCache] imageFromDiskCacheForKey:url.absoluteString];
//    }else if([yyCache containsImageForKey:[yyManager cacheKeyForURL:url]]){
////        YYImageCache
//        return [yyCache getImageForKey:[yyManager cacheKeyForURL:url]];
//    }else
    {
       return [UIImage imageNamed:@"icon"];
    }
}
// 身份证是否有效 0 为有效
+ (IdCardValidationType)isIdCardNumberValid:(NSString *)idNumber{
    idNumber = [idNumber lowercaseString];
    if(nil == idNumber)
        return IDCARD_LENGTH_SHOULD_NOT_BE_NULL;
    NSString* Ai = @"";
    NSString *idCardNumber = [idNumber stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([idCardNumber isEqualToString:@""]||idCardNumber.length==0) {
        return IDCARD_LENGTH_SHOULD_NOT_BE_NULL;
    }
    if ((idCardNumber.length != 15 && idCardNumber.length != 18)) {
        return IDCARD_LENGTH_SHOULD_BE_MORE_THAN_15_OR_18;
    }
    if (idCardNumber.length == 18) {
        Ai = [idCardNumber substringWithRange:NSMakeRange(0, 17)];
        if (![Ai isValidWithRegex:STNumberRegex]) {
            return IDCARD_SHOULD_BE_17_DIGITS_EXCEPT_LASTONE;
        }
    } else if (idCardNumber.length == 15) {
        Ai = [NSString stringWithFormat:@"%@19%@",
              [idCardNumber substringWithRange:NSMakeRange(0, 6)],
              [idCardNumber substringWithRange:NSMakeRange(6, 9)]];
        if (![Ai isValidWithRegex:STNumberRegex]) {
            return IDCARD_SHOULD_BE_15_DIGITS;
        }
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *tz = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:tz];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *birthday=[dateFormatter dateFromString:[Ai substringWithRange:NSMakeRange(6, 8)]];   //需要转化的字符串
    
    if(birthday == nil)
        return IDCARD_BIRTHDAY_IS_INVALID;
    
    NSDate *today = [NSDate date];
    NSTimeInterval secondsBetweenDates= [birthday timeIntervalSinceDate:today];
    if(secondsBetweenDates > 0) {
        return IDCARD_BIRTHDAY_SHOULD_NOT_LARGER_THAN_NOW;
    }
    
    int HONGKONG_AREACODE = 810000; // 香港地域编码值
    int TAIWAN_AREACODE = 710000; // 台湾地域编码值
    int MACAO_AREACODE = 820000; // 澳门地域编码值
    int areaCode = [[Ai substringWithRange:NSMakeRange(0, 6)] intValue];
    
    if (areaCode != HONGKONG_AREACODE
        && areaCode != TAIWAN_AREACODE
        && areaCode != MACAO_AREACODE
        && (areaCode > 659004 || areaCode < 110000)) {
        return IDCARD_REGION_ENCODE_IS_INVALID;
    }
    
    // 判断如果是18位身份证，判断最后一位的值是否合法
    /*
     * 校验的计算方式： 　　1. 对前17位数字本体码加权求和 　　公式为：S = Sum(Ai * Wi), i = 0, ... , 16
     * 　　其中Ai表示第i位置上的身份证号码数字值，Wi表示第i位置上的加权因子，其各位对应的值依次为： 7 9 10 5 8 4 2 1 6
     * 3 7 9 10 5 8 4 2 　　2. 以11对计算结果取模 　　Y = mod(S, 11) 　　3. 根据模的值得到对应的校验码
     * 　　对应关系为： 　　 Y值： 0 1 2 3 4 5 6 7 8 9 10 　　校验码： 1 0 X 9 8 7 6 5 4 3 2
     */
    NSArray* Wi = [[NSArray alloc] initWithObjects: @"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
    NSArray* ValCodeArr = [[NSArray alloc] initWithObjects: @"1", @"0", @"x", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", nil];
    int TotalmulAiWi = 0;
    for (int i = 0; i < 17; i++) {
        TotalmulAiWi += [[Ai substringWithRange:NSMakeRange(i, 1)] intValue] * [[Wi objectAtIndex:i] intValue];
    }
    int modValue = TotalmulAiWi % 11;
    NSString* strVerifyCode = [ValCodeArr objectAtIndex:modValue];
    Ai = [NSString stringWithFormat:@"%@%@", Ai, strVerifyCode];
    
    if (idCardNumber.length == 18) {
        if (![Ai isEqualToString: idCardNumber]) {
            return IDCARD_IS_INVALID;
        } else {
            return IDCARD_IS_VALID;
        }
    } else if (idCardNumber.length == 15) {
        return IDCARD_IS_VALID;
    }
    
    return IDCARD_PARSER_ERROR;
}
// 通过身份证号得到 生日
+ (NSDate *) getBirthday: (NSString *)idNumber {
    NSString* Ai = @"";
    NSString *idCardNumber = [idNumber stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (idCardNumber.length == 18) {
        Ai = [idCardNumber substringWithRange:NSMakeRange(0, 17)];
    } else if (idCardNumber.length == 15) {
        Ai = [NSString stringWithFormat:@"%@19%@",
              [idCardNumber substringWithRange:NSMakeRange(0, 6)],
              [idCardNumber substringWithRange:NSMakeRange(6, 9)]];
    }else{
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *tz = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:tz];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *birthday=[dateFormatter dateFromString:[Ai substringWithRange:NSMakeRange(6, 8)]];   //需要转化的字符串
    return birthday;
}

/** 银行卡号有效性问题Luhn算法
 */
+ (BOOL)bankCardluhmVerify:(NSString *)string{
    NSString *formattedString = [self formattedStringForProcessing:string];
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
+ (NSString *)formattedStringForProcessing:(NSString *)string{
    NSCharacterSet *illegalCharacters = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray *components = [string componentsSeparatedByCharactersInSet:illegalCharacters];
    return [components componentsJoinedByString:@""];
}
#pragma mark - 在时间段之内要求格式2018-1-2
+ (BOOL)isRangeTimeForm:(NSString *)formTimeStr toTime:(NSString *)toTimeStr{
    // 从 - 到
    NSArray *formArray = [formTimeStr componentsSeparatedByString:@"-"];
    NSArray *toArray = [toTimeStr componentsSeparatedByString:@"-"];
    if (formArray.count == 3 && toArray.count == 3) {
        NSInteger formTimeInt = [[formArray firstObject] integerValue] * 10000 + [formArray[1] integerValue] * 100 + [formArray[2] integerValue];
        NSInteger toTimeInt = [[toArray firstObject] integerValue] * 10000 + [toArray[1] integerValue] * 100 + [toArray[2] integerValue];
        // 本地时间
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyyMMdd"];
        NSInteger currentInt = [[dateFormatter stringFromDate:[NSDate date]] integerValue];
        if (currentInt >= formTimeInt && currentInt <= toTimeInt) {
            return YES;
        }
        return NO;
    }else{
        return NO;
    }
}
@end
