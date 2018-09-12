//
//  SAWithdrawalsModel.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/26.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "STCommonTableViewBaseItem.h"

@interface SAWithdrawalsModel : STCommonBaseTableRowItem<STCommonTableRowItem>
@property (nonatomic,copy) NSString *cardId;
@property (nonatomic,copy) NSString *bankLogo;
@property (nonatomic,copy) NSString *bankName;
@property (nonatomic,copy) NSString *bankAccount;

@property (nonatomic,assign) BOOL isSelect;

@end
