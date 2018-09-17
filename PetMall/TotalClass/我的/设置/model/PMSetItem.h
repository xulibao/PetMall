//
//  PMMyCommentItem.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "STCommonTableViewBaseItem.h"

@interface PMSetItem : STCommonBaseTableRowItem

/** 标题 */
@property (nonatomic, copy ) NSString *title;

@property(nonatomic, copy) void(^itemSelect)();

@end
