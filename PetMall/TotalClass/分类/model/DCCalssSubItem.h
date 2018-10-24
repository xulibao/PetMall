//
//  DCCalssSubItem.h
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCCalssSubItem : NSObject

@property (nonatomic, copy ,readonly) NSString *cate_id;
/** 商品类题  */
@property (nonatomic, copy ,readonly) NSString *cate_title;
/** 商品图片  */
@property (nonatomic, copy) NSString *img;

@end
