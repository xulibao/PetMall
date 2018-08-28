//
//  SATextFieldInputValidHandle.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/3/4.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SATextFieldInputValidHandle.h"
#import "NSString+STValid.h"

/**
 * UITextField Category 用于控制光标位置
 */
@interface UITextField (ExtendRange)

- (NSRange)selectedRange;

- (void)setSelectedRange:(NSRange)range;

@end

@implementation SATextFieldInputValidHandle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _maxLength = NSNotFound;
    }
    return self;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *beingString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *cardNo = [beingString removeingSpecialString:self.specialString];
    
    if ( (string.length != 0 && ![self validInputString:cardNo]) || (self.maxLength != NSNotFound && cardNo.length > self.maxLength) ) {
        return NO;
    }
    
    return YES;
}

- (BOOL)validInputString:(NSString *)string {
    if (!self.inputRegex || self.inputRegex.length == 0) {
        return YES;
    }
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",self.inputRegex];
    return [numberPre evaluateWithObject:string];
}

- (BOOL)isValidString:(NSString *)string {
    if (!self.validRegex || self.validRegex.length == 0) {
        return YES;
    }
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",self.validRegex];
    return [numberPre evaluateWithObject:string];
}

@end

@implementation SATextFieldGroupInputHandle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _groupSize = 4;
        _separatorString = @" ";
    }
    return self;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *text = textField.text;
    NSString *beingString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *cardNo = [beingString removeingSpecialString:self.separatorString];
    
    //获取【光标右侧的数字个数】
    NSInteger rightNumberCount = [[text substringFromIndex:textField.selectedRange.location + textField.selectedRange.length] removeingSpecialString:self.separatorString].length;
    //输入长度大于4 需要对数字进行分组，每4个一组，用空格隔开
    if (beingString.length > self.groupSize) {
        textField.text = [self groupedString:beingString];
    } else {
        textField.text = beingString;
    }
    text = textField.text;
    /**
     * 计算光标位置(相对末尾)
     * 光标右侧空格数 = 所有的空格数 - 光标左侧的空格数
     * 光标位置 = 【光标右侧的数字个数】+ 光标右侧空格数
     */
    NSInteger rightOffset = [self rightOffsetWithCardNoLength:cardNo.length rightNumberCount:rightNumberCount];
    NSRange currentSelectedRange = NSMakeRange(text.length - rightOffset, 0);
    
    //如果光标左侧是一个空格，则光标回退一格
    if (currentSelectedRange.location > 0 && [[text substringWithRange:NSMakeRange(currentSelectedRange.location - 1, 1)] isEqualToString:self.separatorString]) {
        currentSelectedRange.location -= 1;
    }
    [textField setSelectedRange:currentSelectedRange];
    return NO;
}

#pragma mark - Helper
/**
 *  计算光标相对末尾的位置偏移
 *
 *  @param length           卡号的长度(不包括空格)
 *  @param rightNumberCount 光标右侧的数字个数
 *
 *  @return 光标相对末尾的位置偏移
 */
- (NSInteger)rightOffsetWithCardNoLength:(NSInteger)length rightNumberCount:(NSInteger)rightNumberCount {
    NSInteger totalGroupCount = [self groupCountWithLength:length];
    NSInteger leftGroupCount = [self groupCountWithLength:length - rightNumberCount];
    NSInteger totalWhiteSpace = totalGroupCount -1 > 0? totalGroupCount - 1 : 0;
    NSInteger leftWhiteSpace = leftGroupCount -1 > 0? leftGroupCount - 1 : 0;
    return rightNumberCount + (totalWhiteSpace - leftWhiteSpace);
}

/**
 *  根据长度计算分组的个数
 *
 *  @param length 长度
 *
 *  @return 分组的个数
 */
- (NSInteger)groupCountWithLength:(NSInteger)length {
    return (NSInteger)ceilf((CGFloat)length /self.groupSize);
}

/**
 *  给定字符串根据指定的个数进行分组，每一组用空格分隔
 *
 *  @param string 字符串
 *
 *  @return 分组后的字符串
 */
- (NSString *)groupedString:(NSString *)string {
    NSString *str = [string removeingSpecialString:self.separatorString];
    NSInteger groupCount = [self groupCountWithLength:str.length];
    NSMutableArray *components = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < groupCount; i++) {
        if (i*self.groupSize + self.groupSize > str.length) {
            [components addObject:[str substringFromIndex:i*self.groupSize]];
        } else {
            [components addObject:[str substringWithRange:NSMakeRange(i*self.groupSize, self.groupSize)]];
        }
    }
    NSString *groupedString = [components componentsJoinedByString:self.separatorString];
    return groupedString;
}

@end

@implementation SAPhoneNumberInputHandle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inputRegex = STNumberRegex;
        self.validRegex = STPhoneNumberRegex;
        self.maxLength = 11;
    }
    return self;
}

@end

@implementation SAChineseIDCardInputHandle

- (instancetype)init {
    self = [super init];
    if (self) {
        //        self.regex = STChineseIDCardRegex;
        self.maxLength = 18;
    }
    return self;
}

- (BOOL)validInputString:(NSString *)string {
    return string.length <= self.maxLength;
}

- (BOOL)isValidString:(NSString *)string {
    if ([string accurateVerifyIDCardNumber]) {
        return YES;
    }
    return NO;
}

@end

@interface SABankCardInputHandle ()

@property(nonatomic, strong) SATextFieldInputValidHandle *validHandle;
@property(nonatomic, strong) SATextFieldGroupInputHandle *groupInputHandle;

@end

@implementation SABankCardInputHandle

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *separator = @" ";
        
        _validHandle = [[SATextFieldInputValidHandle alloc]init];
        _validHandle.maxLength = 20;
        _validHandle.specialString = separator;
        _validHandle.inputRegex = STNumberRegex;
        
        _groupInputHandle = [[SATextFieldGroupInputHandle alloc]init];
        _groupInputHandle.groupSize = 4;
        _groupInputHandle.separatorString = separator;
    }
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL valid = [self.validHandle textField:textField shouldChangeCharactersInRange:range replacementString:string];
    if (valid) {
        return [self.groupInputHandle textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return NO;
}

- (BOOL)validInputString:(NSString *)string {
    return YES;
}

- (BOOL)isValidString:(NSString *)string {
    if ([string bankCardluhmVerify]) {
        return YES;
    }
    return NO;
}

@end

@implementation SAPriceInputValidHandle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inputRegex = @"^\\d+$|^\\d+[.]\\d{0,2}$";
        self.validRegex = STPriceRegex;
    }
    return self;
}

@end

@implementation UITextField (ExtendRange)
- (NSRange)selectedRange {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextRange *selectedRange = self.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}
- (void)setSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}
@end

