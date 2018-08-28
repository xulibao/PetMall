//
//  SABaseInputValidTextField.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/3/4.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SAInsetsTextField.h"
#import "SATextFieldInputValidHandle.h"
@interface SABaseInputValidTextField : SAInsetsTextField

@property(nonatomic, strong) SATextFieldInputValidHandle *inputHandle;
@property(nonatomic, assign, readonly) BOOL isValid;

@end
