//
//  DCCommentsItem.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2018/2/23.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCCommentsItem : NSObject

/* 名字 */
@property (nonatomic, copy) NSString *user_name;
/* 头像 */
@property (nonatomic, copy) NSString *img;
/* 时间 */
@property (nonatomic, copy) NSString *user_time;
/* 内容 */
@property (nonatomic, copy) NSString *user_comment;
/* 店家回复 */
@property (nonatomic, copy) NSString *comReBack;

@property (nonatomic, copy) NSString *user_images;

/*图片数组*/
@property (strong , nonatomic)NSMutableArray *imgsArray;



/** cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/** 中间图片Frame */
@property (nonatomic, assign) CGRect imagesFrames;




@end
