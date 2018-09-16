//
//  SPInputMsgBaseModel.h
//  SnailPlatform
//
//  Created by 徐礼宝 on 2018/5/8.
//  Copyright © 2018年 guangan. All rights reserved.
//

#import "STCommonTableViewBaseItem.h"
#import "SATextFieldInputValidHandle.h"
@interface SPInputMsgBaseModel : STCommonBaseTableRowItem<STCommonTableRowItem>

@property (nonatomic, copy)NSString    *severKey; // 网络上传对应的字段
@property (nonatomic, copy)NSString    *severValue; // 网络上传对应的字段值
@property(nonatomic, copy) NSString *placeholderStr;
@property(nonatomic, copy) NSString *errorStr;
@property (nonatomic, assign) NSInteger maxNumber;//文字输入的最大位数
@property (nonatomic, assign) UIKeyboardType keyBoardType;
@property(nonatomic, strong) SATextFieldInputValidHandle *handle;


@end
