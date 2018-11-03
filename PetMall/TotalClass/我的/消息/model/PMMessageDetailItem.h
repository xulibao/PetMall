//
//  PMMyCommentItem.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "STCommonTableViewBaseItem.h"

@interface PMMessageDetailItem : STCommonBaseTableRowItem
/** 图片URL */
@property (nonatomic, copy ) NSString *message_id;
/** 商品标题 */
@property (nonatomic, copy ) NSString *name;
/** 商品小标题 */
@property (nonatomic, copy ) NSString *content;
/** 商品价格 */
@property (nonatomic, copy ) NSString *time;

@end
