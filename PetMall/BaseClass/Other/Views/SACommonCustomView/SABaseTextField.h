//
//  SABaseTextField.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/8.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SABaseFieldDelegate;

@interface SABaseTextField : UITextField
@property (nonatomic, copy) NSString * placeString;//占位
@property (nonatomic, assign) NSInteger maxNumber;//最大位数
@property (nonatomic, weak) id <SABaseFieldDelegate> baseFieldDelegate;
@property (nonatomic, weak) UILabel * placeLabel;

@end

@protocol SABaseFieldDelegate <NSObject>

@optional
- (void)baseFieldDidEditWithText:(SABaseTextField *)baseField;

@end
