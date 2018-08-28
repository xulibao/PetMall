//
//  SABaseInputValidTextField.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/3/4.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SABaseInputValidTextField.h"

@implementation SABaseInputValidTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 15);
        self.backgroundColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:15];
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.height = 45;
    return size;
}

#pragma mark - Property

- (void)setInputHandle:(SATextFieldInputValidHandle *)inputHandle {
    _inputHandle = inputHandle;
    self.delegate = inputHandle;
}

- (BOOL)isValid {
    return self.text.length > 0 && [self.inputHandle isValidString:self.text];
}

@end
