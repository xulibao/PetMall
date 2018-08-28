//
//  UIButton+GHExtension.m
//  GHFrameWork
//
//  Created by GhGh on 15/10/14.
//  Copyright © 2015年 王光辉. All rights reserved.
//

#import "UIButton+GHExtension.h"
#import <objc/runtime.h>
@interface UIControl ()
/** 是否忽略点击 */
@property(nonatomic)BOOL ga_ignoreEvent;
@end
@implementation UIButton (GHExtension)
//+ (void)load{
//    Method systemMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
//    SEL sysSEL = @selector(sendAction:to:forEvent:);
//    Method customMethod = class_getInstanceMethod(self, @selector(custom_sendAction:to:forEvent:));
//    SEL customSEL = @selector(custom_sendAction:to:forEvent:);
//    //添加方法 语法：BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types) 若添加成功则返回No
//    
//    // cls：被添加方法的类  name：被添加方法方法名  imp：被添加方法的实现函数  types：被添加方法的实现函数的返回值类型和参数类型的字符串
//    
//    BOOL didAddMethod = class_addMethod(self, sysSEL, method_getImplementation(customMethod), method_getTypeEncoding(customMethod));
//    
//    //如果系统中该方法已经存在了，则替换系统的方法  语法：IMP class_replaceMethod(Class cls, SEL name, IMP imp,const char *types)
//    if (didAddMethod) {
//        class_replaceMethod(self, customSEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
//    }else{
//        method_exchangeImplementations(systemMethod, customMethod);
//    }
//    
//}
//
//- (NSTimeInterval )custom_acceptEventInterval{
//    return [objc_getAssociatedObject(self, "UIControl_acceptEventInterval") doubleValue];
//}
//
//- (void)setCustom_acceptEventInterval:(NSTimeInterval)custom_acceptEventInterval{
//    objc_setAssociatedObject(self, "UIControl_acceptEventInterval", @(custom_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (NSTimeInterval )custom_acceptEventTime{
//    return [objc_getAssociatedObject(self, "UIControl_acceptEventTime") doubleValue];
//}
//
//- (void)setCustom_acceptEventTime:(NSTimeInterval)custom_acceptEventTime{
//    objc_setAssociatedObject(self, "UIControl_acceptEventTime", @(custom_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (void)custom_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
//     if (self.custom_acceptEventInterval <= 0) {
//         // 如果没有自定义时间间隔，则默认为1秒
//        self.custom_acceptEventInterval = 1;
//     }
//    
//    // 是否小于设定的时间间隔
//    BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - self.custom_acceptEventTime >= self.custom_acceptEventInterval);
//    // 更新上一次点击时间戳
//    if (self.custom_acceptEventInterval > 0) {
//        
//        self.custom_acceptEventTime = NSDate.date.timeIntervalSince1970;
//        
//    }
//    
//    // 两次点击的时间间隔小于设定的时间间隔时，才执行响应事件
//    if (needSendAction) {
//        [self custom_sendAction:action to:target forEvent:event];
//    }
//}
// 禁用多按钮同时点击效果
- (BOOL)isExclusiveTouch
{
    return YES;
}
+ (UIButton *)creatButtonFrame:(CGRect)frame title:(NSString *)title andNormalImage:(UIImage *)normalImage withHightImage:(UIImage *)hightImage
{
    UIButton *bnt= [UIButton buttonWithType:UIButtonTypeCustom];
    [bnt setFrame:frame];
    [bnt setTitle:title forState:UIControlStateNormal];
    bnt.titleLabel.text =title;
    [bnt setBackgroundImage:normalImage forState:UIControlStateNormal];
    [bnt setBackgroundImage:hightImage forState:UIControlStateHighlighted];
    [bnt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return bnt;
}




#pragma mark - 延期时间 - 之后可以交互
//-(void)jp_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
//    if (self.ga_ignoreEvent) return;
//    if (self.ga_acceptEventInterval > 0) {
//        self.ga_ignoreEvent = YES;
//        [self performSelector:@selector(setga_ignoreEvent:) withObject:@(NO) afterDelay:self.ga_acceptEventInterval];
//    }
//    [self jp_sendAction:action to:target forEvent:event];
//}
//
//-(void)setga_ignoreEvent:(BOOL)ga_ignoreEvent{
//    objc_setAssociatedObject(self, @selector(ga_ignoreEvent), @(ga_ignoreEvent), OBJC_ASSOCIATION_ASSIGN);
//}
//
//-(BOOL)ga_ignoreEvent{
//    return [objc_getAssociatedObject(self, _cmd) boolValue];
//}
//
//
//-(void)setGa_acceptEventInterval:(NSTimeInterval)ga_acceptEventInterval{
//    objc_setAssociatedObject(self, @selector(ga_acceptEventInterval), @(ga_acceptEventInterval), OBJC_ASSOCIATION_ASSIGN);
//}
//
//-(NSTimeInterval)ga_acceptEventInterval{
//    return [objc_getAssociatedObject(self, _cmd) doubleValue];
//}
//// 交换方法
//+ (void)load{
//    Method sys_Method = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
//    Method add_Method = class_getInstanceMethod(self, @selector(jp_sendAction:to:forEvent:));
//    method_exchangeImplementations(sys_Method, add_Method);
//}

@end
