//
//  SATextFieldInputValidHandle.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/3/4.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SATextFieldInputValidHandle :  NSObject <UITextFieldDelegate>

@property(nonatomic, assign) NSUInteger maxLength;//最大长度 默认不限制 NSNotFound
@property(nonatomic, copy) NSString *inputRegex;//输入正则
@property(nonatomic, copy) NSString *validRegex;//验证正则
@property(nonatomic, copy) NSString *specialString;//特殊字符 需要在 判断是排除

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

- (BOOL)validInputString:(NSString *)string;
- (BOOL)isValidString:(NSString *)string;

@end

@interface SATextFieldGroupInputHandle : NSObject

@property(nonatomic, assign) NSUInteger groupSize;//每组个数 默认为 4
@property(nonatomic, copy) NSString *separatorString;//分组分割字符 默认为" "

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end

@interface SAPhoneNumberInputHandle : SATextFieldInputValidHandle

@end

@interface SAChineseIDCardInputHandle : SATextFieldInputValidHandle

@end

@interface SABankCardInputHandle : SATextFieldInputValidHandle

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end

@interface SAPriceInputValidHandle : SATextFieldInputValidHandle

@end


