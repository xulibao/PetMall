//
//  SABaseTextField.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/8.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SABaseTextField.h"

#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

@interface SABaseTextField () <UITextFieldDelegate>


@end

@implementation SABaseTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpPlaceLabel];
        self.textColor = kColorTextGay;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        
    }
    return self;
}

- (void)setUpPlaceLabel
{
    
    UILabel * placeLabel = [[UILabel alloc] init];
    
    placeLabel.textColor = kColorTextLight;
    
    self.font = placeLabel.font;
    
    placeLabel.numberOfLines = 0;
    
    [self addSubview:placeLabel];
    
    self.placeLabel = placeLabel;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textdidBeginToChange) name:UITextFieldTextDidChangeNotification object:nil];
}


- (void)textdidBeginToChange
{
    if (self.keyboardType == UIKeyboardTypeDecimalPad) {
        //第一位不可以为'.'或0
        if (self.text.length == 1) {
            NSRange rang = NSMakeRange(0, 1);
            NSString * chars = [self.text substringWithRange:rang];
            if ([chars isEqualToString:@"."] |[chars isEqualToString:@"0"] ) {
                self.text= [self.text substringToIndex:self.text.length -1];
            }
        }
        
        if (self.text.length >= 1) {
            //小数点只能出现一次
            NSArray *array = [self.text componentsSeparatedByString:@"."];
            if (array.count > 2) {
                self.text= [self.text substringToIndex:self.text.length -1];
                
            }else if (array.count == 2){
                
                //只能留2位小数
                NSRange range = [self.text rangeOfString:@"."];
                NSString * text = [self.text substringFromIndex:range.location+ 1];
                if (text.length > 2) {
                    self.text = [self.text substringToIndex:self.text.length -1];
                }
                
            }
            
        }
        
    }
    self.placeLabel.hidden = (self.text.length != 0);
    
    //当位置超过最大位数的时候截取到Max位置的文字
    if (self.text.length > self.maxNumber && self.maxNumber > 0) {
        self.text = [self.text substringToIndex:self.maxNumber];
    }
    if ([self.baseFieldDelegate respondsToSelector:@selector(baseFieldDidEditWithText:)]) {
        [self.baseFieldDelegate baseFieldDidEditWithText:self];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (text.length > self.maxNumber && string.length > 0) {
        return NO;
    }
    return YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)setPlaceString:(NSString *)placeString
{
    _placeString = placeString;
    
    _placeLabel.text = placeString;
    
    [self getPlaceLabelFrame];
    
}
- (void) setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeLabel.font = font;
    
    [self getPlaceLabelFrame];
    
}


- (void)getPlaceLabelFrame
{
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT);
    //NSLineBreakByWordWrapping
    //    self.placeLabel.size = [_placeLabel.text sizeWithFont:_placeLabel.font constrainedToSize:maxSize];
    self.placeLabel.size = [_placeLabel boundingRectWithSize:maxSize];
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.placeLabel.y = (self.height - self.placeLabel.height) * 0.5;
}


@end
