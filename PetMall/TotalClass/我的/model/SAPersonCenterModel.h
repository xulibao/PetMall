//
//  SAPersonCenterModel.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/3/7.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, SAQualificationsStatus) { //
    SAQualificationsStatusCommit = 0, //还没提交 可以点击
    SAQualificationsStatusAudit = 1, //审核中
    SAQualificationsStatusComplete = 2, // 审核通过
    SAQualificationsStatusFail  =  3,// 审核失败
    SAQualificationsStatusServerAudit = 4, // 服务器的审核中
};

typedef NS_ENUM(NSUInteger, SASellerLevel) {
    SASellerLevelPrimary = 1,
    SASellerLevelProfessional,
};

typedef NS_ENUM(NSUInteger, SAApplyType) { //申请类型
    SAApplyTypeProOther = 0,
    SAApplyTypeProfessional,
    SAApplyTypePrimary,
};

@interface SAPersonCenterModel : NSObject

@property (nonatomic,copy) NSString *availableBond;
@property (nonatomic,copy) NSString *carDealer;
@property (nonatomic,copy) NSString *loginName;
@property (nonatomic,assign) SAQualificationsStatus status;
@property (nonatomic,assign) SASellerLevel type;
@property (nonatomic,assign) SAApplyType applyType;
@property (nonatomic,copy) NSString *waitOrderCount;
@property (nonatomic,copy) NSString *rebateRatio;//折扣
@property (nonatomic,copy) NSString *endTime;//结束时间
@property (nonatomic,copy) NSString *startTime;//开始时间


@end
