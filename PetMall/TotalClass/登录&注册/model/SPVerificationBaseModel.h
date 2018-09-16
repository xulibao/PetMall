//
//  SAVerificationBaseModel.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/9.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SACommonCountDownItem.h"
#import "SATextFieldInputValidHandle.h"
typedef NS_ENUM(NSInteger,VerificationShow) {
    
    /** 显示验证 */
    kVerificationShowForShow = 0,
    /** 隐藏验证 */
    kVerificationShowForHidden,
};

extern NSTimeInterval const SPVerificationCountDownTime;

@interface SPVerificationBaseModel : SACommonCountDownItem

@property (nonatomic, copy) NSString * feildPlace;//占位字符
@property (nonatomic, copy) NSString * imageName;//图片名称
@property (nonatomic, copy) NSString * errorStr;//错误提示
@property (nonatomic, assign) VerificationShow showType;
@property (nonatomic, assign) BOOL isShowCiphertext;//是否显示密文
@property (nonatomic, assign) BOOL isCiphertext;//是否密文
@property (nonatomic, assign) BOOL isAddTimer;
@property (nonatomic, assign) NSInteger maxNumber;//文字输入的最大位数
@property (nonatomic, assign) UIKeyboardType keyBoardType;
@property (nonatomic, copy)NSString    *severKey; // 网络上传对应的字段
@property (nonatomic, copy)NSString    *severValue; // 网络上传对应的字段值
@property (nonatomic, strong) UITableViewCell *staticCell;
@property(nonatomic, strong) SATextFieldInputValidHandle *handle;
- (void)startCountDown;

@end

