//
//  STConstant.h
//  SnailTruck
//
//  Created by 曼 on 15/10/23.
//  Copyright (c) 2015年 GM. All rights reserved.
//
#ifndef SnailTruck_STConstant_h
#define SnailTruck_STConstant_h
// 1 表示表示打开了debug工具  0表示项目没有bug了，😝

#define KOpen_DebugView  1
/**
 *  返回x以内的带有两位小数的浮点数
 *
 *  @param x x
 *
 *  @return x以内的带有两位小数的浮点数
 */
#define kTimeOut @"时间超时，请重试"
// 状态栏高度
#define kStatusBarHeight     [[UIApplication sharedApplication] statusBarFrame].size.height

// 自定义TabBar属性
#define kTabBarHeight           49.f
//#define kTabBarIconSide         25.f

/** 屏幕高度 */
#define ScreenH [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define ScreenW [UIScreen mainScreen].bounds.size.width
//全局背景色
#define DCBGColor RGB(245,245,245)
#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"
/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self;

#define PFR20Font [UIFont fontWithName:PFR size:20];
#define PFR18Font [UIFont fontWithName:PFR size:18];
#define PFR16Font [UIFont fontWithName:PFR size:16];
#define PFR15Font [UIFont fontWithName:PFR size:15];
#define PFR14Font [UIFont fontWithName:PFR size:14];
#define PFR13Font [UIFont fontWithName:PFR size:13];
#define PFR12Font [UIFont fontWithName:PFR size:12];
#define PFR11Font [UIFont fontWithName:PFR size:11];
#define PFR10Font [UIFont fontWithName:PFR size:10];
#define PFR9Font [UIFont fontWithName:PFR size:9];
#define PFR8Font [UIFont fontWithName:PFR size:8];

// 自定义NavigationBar属性
#define kNavgationBarHeight     (44)
#define kIphoneXBottomHeight    (iPhoneX ? 34 : 0)
#define kNavigationWhiteColor   [UIColor whiteColor]
#define kNavigationBlackColor   [UIColor blackColor]
#define kNavigationTitleFont    [UIFont systemFontOfSize:18.f]

#define kMainBoundsWidth        UI_SCREEN_WIDTH
#define kMainBoundsHeight       UI_SCREEN_HEIGHT
// UI使用的是iPhone6屏幕尺寸
#define UI_Scale (kMainBoundsWidth / 375.0)
// 获取一个像素
#define PixelOne (1 / [[UIScreen mainScreen] scale])

#define SupportedOrientationMask (UIInterfaceOrientationMaskPortrait)

// 适配放大模式下的情况
//#define LISTCELL_ROWHEIGHT ((kMainBoundsWidth / 3.0f) < 106.7 ? 115.0 : (kMainBoundsWidth / 3.0f))

//400-0056-303    0537-2331977   客服热线
#define kPhoneNumber     @"400-169-7799"
#define kPhoneLianShanNumber     @"400-169-7799"
#define kBuyCarRecord @"buyCarRecord.plist"

#define SYSTEM_VERSION          [[[UIDevice currentDevice] systemVersion] floatValue]
#define RGB(r, g, b)            RGBA(r, g, b, 1)
// 随机色
#define kRandomColor RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


#define STSquarePlaceImage      [UIImage imageNamed:@"placeCell"]
// 列表cell高度
#define STMineReleaseCellRowHeigiht (kMainBoundsWidth * 0.35)
#define STMineReleaseCellRowMargin kMainBoundsWidth/37.5


#define kColorFAFAFA            [UIColor colorWithHexStr:@"#FAFAFA"]
#define kColor666666            [UIColor colorWithHexStr:@"#666666"]
#define kColorD8D8D8            [UIColor colorWithHexStr:@"#D8D8D8"]
#define kColor979797            [UIColor colorWithHexStr:@"#979797"]
#define kColorFF5554            [UIColor colorWithHexStr:@"#FF5554"]
#define kColorEEEEEE            [UIColor colorWithHexStr:@"#EEEEEE"]
#define kColor999999            [UIColor colorWithHexStr:@"#999999"]
#define kColor5C5C5C            [UIColor colorWithHexStr:@"#5C5C5C"]
#define kColor878787            [UIColor colorWithHexStr:@"#878787"]
#define kColorFFB191            [UIColor colorWithHexStr:@"#FFB191"]
#define kColorMain              RGBA(30, 171, 254, 1.f)
#define kColorSeperateLine      [UIColor colorWithHexStr:@"#d3d3d3"]
#define kColorBackground        [UIColor colorWithHexStr:@"#f2f2f2"]
#define kColorBG                 [UIColor colorWithHexStr:@"#F4F4F4"]
#define kColorMaskground        [UIColor colorWithHexStr:@"#000000"]
#define kColorMaiRed            [UIColor colorWithHexStr:@"#dd2727"]
#define kColorBGRed             [UIColor colorWithHexStr:@"#FF5A5A"]
#define kColorBGPink             [UIColor colorWithHexStr:@"#FFDFDF"]
#define kColorCityTextRed       [UIColor colorWithHexStr:@"#FC5959"]

#define kColorBGGay             [UIColor colorWithHexStr:@"#E6E6E6"]

#define kColorCellground        [UIColor colorWithHexStr:@"#ffffff"]
#define kColorTextGayPick        [UIColor colorWithHexStr:@"#f7f7f7"]
#define kColorBlue              [UIColor colorWithHexStr:@"#3472a5"]

#define kColorTextBlack         [UIColor colorWithHexStr:@"#333333"]
#define kColorTextLight         [UIColor colorWithHexStr:@"#ccccd2"]
#define kColorTextGay           [UIColor colorWithHexStr:@"#666666"]
#define kColorTextRed           [UIColor colorWithHexStr:@"#C60B0B"]
#define kColorTextLighGay       [UIColor colorWithHexStr:@"#888888"]
#define kColorPriceDrop         [UIColor colorWithHexStr:@"#3ec031"]
#define kColorOrangeTextColor   [UIColor colorWithHexStr:@"#ff7400"]
#define kColorBlueTextColor     [UIColor colorWithHexStr:@"#4891eb"]
#define kColorTextBlackbbbbbb   [UIColor colorWithHexStr:@"#bbbbbb"]
#define KCoverColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]

#define UIColorMake(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define UIColorMakeWithRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]

//七牛图片质量
#define QN(P) [NSString stringWithFormat:@"%@%d",@"?imageMogr2/strip/quality/",P]
// 城市模型存入本地对应的key
#define CITIES    @"expiredCities"//请使用STBigJsonSingleton/cityKey

//===============友盟分享=====================
#define YOUMENG_APPKEY @"566e68ea67e58e0c0b000a57"

#define Share_QQ_APPID @"1104939263"
#define Share_QQ_APPKEY @"WKl68ZZABq6mGtxS"

#define Share_WeiXin_APPID  @"wx41983c4c43a605fb"
#define Share_WeiXin_AppSecret @"3cba82b5074d44d10c06e74e4e45a4de"

// -------------友盟统计--------------
#define UMAPPKEY  @"5ab2182df29d9873d1000094"
#define UMChannelId @"App Store"

// -------------Bugly--------------
#define BUGLY_APP_ID @"50ac3b1d66"
#define BUGLY_APP_KEY @"1e53409f-5f50-4b81-b858-b880cdfec998"

// -------------激光推送--------------
#define JPUSH_Key   @"15d23c61b7a97d3684333575"
#define JPUSH_OFF_LINE  @"OfflineUser"//离线
#define JPUSH_ON_LINE  @"OnlineUser"  //在线

// -------------百度，高德--------------
#define BAI_DU_MAP_KEY  @"wIouYYsai6o9nNhiRtQhuyw7"
#define GAO_DE_MAP_KEY  @"19ed11d9f6c28a442118c85dc4af7f67"

// -------------环信--------------
#define HuanXin_App_KEY  @"1426171123068991#woniuhuoche"
#define HuanXin_IM_SERVICE_KEY @"woniuhuoche01" // IM服务号

// appId(蜗牛货车)
#define APPID 1346472787 // 蜗牛货车
// jspatch-蜗牛货车使用
//#define JSPatchKey @"c95084d764522a59"
// 通联支付 - 008370873990015正式id，蜗牛货车使用
#define TongLianPay_MerchantId @"008370873990015"

// 分享的网址
#define SHAREHTML [NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%d",APPID]

// 蜗牛货车官网
#define WONIUHTML @"http://www.woniuhuoche.com/share_down/index.html"

// 分享地址
#define MESSWONIUHTML @"http://www.woniuhuoche.com:8008/downPage/index.html"
// 分享title
#define SHARE_TITLE @"买靠谱二手货车，就上蜗牛货车！"
// 支付模块，支付成功 收到通知
#define paySuccesed  @"paySuccesed"
#define payFaild     @"payFaild"
#define seekPurchaseLocationAutoLocation @"seekPurchaseLocationAutoLocation"

#endif
