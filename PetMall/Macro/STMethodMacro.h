//
//  STMethodMacro.h
//  SnailTruck
//
//  Created by GhGh on 16/5/19.
//  Copyright © 2016年 GhGh. All rights reserved.
//

#ifndef STMethodMacro_h
#define STMethodMacro_h
#import "SAAccount.h"
#import "STNavigationController.h"
#import "STTabBarController.h"
//   (1)
/**
 Synthsize a weak or strong reference.
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#import <objc/runtime.h>

#pragma mark - Clang

#define ArgumentToString(macro) #macro
#define ClangWarningConcat(warning_name) ArgumentToString(clang diagnostic ignored warning_name)

// 参数可直接传入 clang 的 warning 名，warning 列表参考：https://clang.llvm.org/docs/DiagnosticsReference.html
#define BeginIgnoreClangWarning(warningName) _Pragma("clang diagnostic push") _Pragma(ClangWarningConcat(#warningName))
#define EndIgnoreClangWarning _Pragma("clang diagnostic pop")

#define BeginIgnorePerformSelectorLeaksWarning BeginIgnoreClangWarning(-Warc-performSelector-leaks)
#define EndIgnorePerformSelectorLeaksWarning EndIgnoreClangWarning

#define BeginIgnoreAvailabilityWarning BeginIgnoreClangWarning(-Wpartial-availability)
#define EndIgnoreAvailabilityWarning EndIgnoreClangWarning

#define BeginIgnoreDeprecatedWarning BeginIgnoreClangWarning(-Wdeprecated-declarations)
#define EndIgnoreDeprecatedWarning EndIgnoreClangWarning

#import <UIKit/UIKit.h>

CG_INLINE BOOL
ReplaceMethod(Class _class, SEL _originSelector, SEL _newSelector) {
    Method oriMethod = class_getInstanceMethod(_class, _originSelector);
    Method newMethod = class_getInstanceMethod(_class, _newSelector);
    if (!newMethod) {
        // class 里不存在该方法的实现
        return NO;
    }
    BOOL isAddedMethod = class_addMethod(_class, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        class_replaceMethod(_class, _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
    return YES;
}

// 字体相关的宏，用于快速创建一个字体对象，更多创建宏可查看 UIFont+QMUI.h
#define UIFontMake(size) [UIFont systemFontOfSize:size]
#define UIFontItalicMake(size) [UIFont italicSystemFontOfSize:size] // 斜体只对数字和字母有效，中文无效
#define UIFontBoldMake(size) [UIFont boldSystemFontOfSize:size]
#define UIFontBoldWithFont(_font) [UIFont boldSystemFontOfSize:_font.pointSize]

// (2)
#define fRandom(x)              (arc4random()%x + arc4random()%100/100.f)
#define iRandom(x)              arc4random()%x
#define SourcePath(n,e)         [[NSBundle mainBundle] pathForResource:n ofType:e]
#define kWindow     [[[UIApplication sharedApplication] delegate] window]
//显示隐藏statusBar
#define SETSTATUSBARHIDDEN(isHidden)\
if (isHidden){\
[[UIApplication sharedApplication] setStatusBarHidden:YES];\
}else{\
[[UIApplication sharedApplication] setStatusBarHidden:NO];\
}

// (3)
//电话 - 快速拨打 - 建议不要使用
#define MakePhone(phoneNumber)  ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[phoneNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]]])
//电话 - 提示拨打
#define MakePhoneTelprompt(phoneNumber) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",[phoneNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]]];

#define IS_LOGIN  if (![SAAccount isLog]) {\
PMLoginViewController *loginVc = [[PMLoginViewController alloc] init];\
UIViewController *vc = [[SAApplication sharedApplication].mainTabBarController selectedViewController];\
STNavigationController * nav = [[STNavigationController alloc] initWithRootViewController:loginVc];\
[vc presentViewController:nav animated:YES completion:nil];\
return;\
}

// 需要强制跳转的页面
#define ForceJumpTabbar(Num) STTabBarController *tabVc = [STTabBarController sharedSTTabBarController];\
STTabBarView *bar = tabVc.tabBarView;\
[bar selectIndex:Num];\
return;

// 需要登录之后直接跳转到想要进入的界面1
#define IS_LOGIN_TO_WANT_VC(classStr) Class vcClass = NSClassFromString(classStr);\
if (vcClass != nil)\
{\
UIViewController *vc = [[vcClass alloc] init];\
if ([STAccount isLog])\
{\
[[STTabBarController sharedSTTabBarController].currtentNavController pushViewController:vc animated:YES];\
return;\
}\
STNavigationController *nav = [[STNavigationController alloc] init];\
STLoginController *loginVc = [[STLoginController alloc] init];\
[nav addChildViewController:loginVc];\
[[STTabBarController sharedSTTabBarController].currtentController presentViewController:nav animated:YES completion:nil];\
loginVc.loginBlockCallBack = ^(){\
[[STTabBarController sharedSTTabBarController].currtentNavController pushViewController:vc animated:YES];\
};\
}


// 需要登录之后直接跳转到想要进入的界面2  - 这种是需要传值给下一个VC的
#define IS_LOGIN_TO_WANT_VC2(VC) if ([STAccount isLog])\
{\
    [[STTabBarController sharedSTTabBarController].currtentNavController pushViewController:vc animated:YES];\
    return;\
}\
STNavigationController *nav = [[STNavigationController alloc] init];\
STLoginController *loginVc = [[STLoginController alloc] init];\
[nav addChildViewController:loginVc];\
[[STTabBarController sharedSTTabBarController].currtentController presentViewController:nav animated:YES completion:nil];\
loginVc.loginBlockCallBack = ^(){\
    [[STTabBarController sharedSTTabBarController].currtentNavController pushViewController:VC animated:YES];\
};

// tabbar选择哪个控制器判断登陆，给我控制器的序列 如：3
#define IS_LOGIN_TO_WANT_SELECT_VC(number) if (self.subviews.count == self.tabBtnModelArray.count) {\
    if ([self subviews][number] == tabBarBtn) {\
        if (![STAccount isLog])\
        {\
            STNavigationController *nav = [[STNavigationController alloc] init];\
            STLoginController *loginVc = [[STLoginController alloc] init];\
            [nav addChildViewController:loginVc];\
            [[STTabBarController sharedSTTabBarController].currtentController presentViewController:nav animated:YES completion:nil];\
            __weak typeof(self) weakSelf = self;\
            loginVc.loginBlockCallBack = ^(){\
                if ([weakSelf.delegate respondsToSelector:@selector(tabBarVeiw:didClickTabBleBtn:)]){\
                    [weakSelf.delegate tabBarVeiw:self didClickTabBleBtn:tabBarBtn];\
                }\
                [weakSelf playAnimation:tabBarBtn.imageView];\
                weakSelf.selectBtn.selected = NO;\
                tabBarBtn.selected = YES;\
                weakSelf.selectBtn = tabBarBtn;\
            };\
            return;\
        }\
    }\
}



// 通过字符串push到下一个VC
#define PUSH_TO_VC(classStr) Class vcClass = NSClassFromString(classStr);\
if (vcClass != nil)\
[[STTabBarController sharedSTTabBarController].currtentNavController pushViewController:[[vcClass alloc] init] animated:YES];


// 调试时服务器不稳定，于是把请求数据用文件形式存入本地，这个宏是传入你文件名字，dataDict是你得到的字典
#define GET_LOCOL_SERVICE_DATA(fileName) NSString * dataPath = [[NSBundle mainBundle] pathForResource:(fileName) ofType:nil];\
NSString * dataJson = [[NSString alloc] initWithContentsOfFile:dataPath encoding:NSUTF8StringEncoding error:nil];\
NSDictionary * dataDict = [NSDictionary dictionary];\
dataDict = [STHelpTools dictionaryWithJsonString:dataJson];


#define current_View_Controller [[STTabBarController sharedSTTabBarController].currtentNavController.childViewControllers lastObject]


//#define IS_HaveDate(array)  if([(array) count] > 0) { \
//self.noDataListView.hidden = YES; \
//}else{ \
//self.noDataListView.hidden = NO; \
//return;\
//}


//#define IS_HaveDateTableHide(array)  if([(array) count] > 0) { \
//self.noDataListView.hidden = YES; \
//self.tableView.hidden = NO;\
//}else{ \
//self.noDataListView.hidden = NO; \
//self.tableView.hidden = YES;\
//return;\
//}

//验证手机号码
#define IS_PhoneNumber(PhoneNumber) [STHelpTools isMobileNumber:(PhoneNumber)]


//#define SuccessToast(message)  [self showSuccess:(message)];
//#define ErrorToast(message)  [self showErrow:(message)];
//#define WaringToast(message)  [self showWaring:(message)];

#define AdaptiveFont(fontSize) [STHelpTools AdaptiveFontWithFontFloat:fontSize]

//#define STLOADING(view) [STHelpTools showLoadingInView:view useSystemNav:YES];
//#define STHIDDEN(view) [STHelpTools hideLoadingInView:view];

//#define String2URL(x)           [NSURL URLWithString:x]

// Nil 或者 Null判断
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

// 2018年新年UI [STHelpTools isRangeTimeForm:@"2018-2-8" toTime:@"2018-3-3"]
//#define IS_NEW_YEAR_2018 [STHelpTools isRangeTimeForm:@"2018-2-8" toTime:@"2018-3-3"]

#endif /* STMethodMacro_h */
