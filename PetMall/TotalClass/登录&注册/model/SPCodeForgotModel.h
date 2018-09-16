//
//  SPCodeForgotModel.h
//  SnailPlatform
//
//  Created by 徐礼宝 on 2018/5/15.
//  Copyright © 2018年 guangan. All rights reserved.
//

#import "STCommonTableViewBaseItem.h"

@interface SPCodeForgotModel : STCommonBaseTableRowItem<STCommonTableRowItem>
@property (nonatomic,strong) NSString *companyName;
@property (nonatomic,strong) NSString *companyId;
@property (nonatomic,strong) NSString *managerPhone;
@end
