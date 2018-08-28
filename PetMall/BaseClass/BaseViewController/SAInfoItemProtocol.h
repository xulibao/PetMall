//
//  SAInfoItemProtocol.h
//  SnailAuction
//
//  Created by imeng on 2018/2/9.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCommonTableViewProtocol.h"
#import "NSAttributedString+STAttributedString.h"
#import "SACommonEnum.h"

@protocol SACommonListInfoItem <STCommonTableRowItem>

- (NSURL *)imageURL;
- (NSAttributedString *)label0Text;//  标题 （北京 中国重汽 HOKA ）牵引车 590 匹 6X4
- (NSAttributedString *)label1Text;//  地址和日期 （北京 2019年7月）
- (NSAttributedString *)label2Text;//  当前最高价：29万 当前最高出价：25.9万
- (NSAttributedString *)label3Text;//  国三
- (NSAttributedString *)label4Text;//  已下架

@optional

- (NSAttributedString *)countDownLabelText;//时间
- (NSArray<NSAttributedString*> *)tagsText;//标签

- (BOOL)shouldDisplayCountDown;

- (SAAuctionStatus)status;
- (void)setStatus:(SAAuctionStatus)status;

@end

