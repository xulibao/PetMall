//
//  PMHomeSubModel.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/10/25.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMHomeSubBroadCastModel : NSObject

@property(nonatomic, copy) NSString *broadCastId;
@property(nonatomic, copy) NSString *img;
@property(nonatomic, copy) NSString *zl;
@end

@interface PMHomeSubNavigationModel : NSObject

@property(nonatomic, copy) NSString *navigationId;
@property(nonatomic, copy) NSString *img;
@property(nonatomic, copy) NSString *cate_title;
@property(nonatomic, copy) NSString *pid;

@end


@interface PMHomeSubModel : NSObject
// 轮播
@property(nonatomic, strong) NSArray *Broadcast;
//导航列表
@property(nonatomic, strong) NSArray *navigation;
//分类列表
@property(nonatomic, strong) NSArray *classification;

@end
