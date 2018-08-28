//
//  SALotListRequest.h
//  SnailAuction
//
//  Created by imeng on 05/03/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "SARequest.h"
#import "SALotInfoItem.h"//拍品对象
#import "SACommonEnum.h"

//1 首页（首页只显示30条数据） 2其他
typedef NS_ENUM(NSUInteger, SALotListSource) {
    SALotListSourceHome = 1,
    SALotListSourceOther,
};

@interface SALotListResponseEntity : NSObject

@property(nonatomic, copy) NSString *auctionName;//场次名称
@property(nonatomic, copy) NSArray<SALotInfoItem*> *lotList;

@end

@interface SALotListRequest : SARequest

@property(nonatomic, assign) SALotListSource source;//default SALotListSourceOther
@property(nonatomic, assign) SAAuctionStatus type;//default SAAuctionStatusAll

@property(nonatomic, copy) NSString *auctionId;//    场次id    number
@property(nonatomic, copy) NSString *brandId;//    品牌id    number
@property(nonatomic, copy) NSString *carAgeEnd;//    车龄结束条件    number
@property(nonatomic, copy) NSString * carAgeStart;//    车龄起始条件    number
@property(nonatomic, copy) NSString * drive;//    驱动形式    number    1. 4x2 2. 6x2 3. 6x4 4. 6x6 5. 8x2 6. 8x4
@property(nonatomic, copy) NSString *emission;//    排放标准    number    3.国二 1.国三 2.国四 4.国五 5国一 6国六
@property(nonatomic, copy) NSString * fuel;//    燃料    number    1.柴油 2.天然气 3.纯电动
@property(nonatomic, copy) NSString * mileageEnd;//    行驶里程结束条件    number
@property(nonatomic, copy) NSString * mileageStart;//    行驶里程起始条件    number
@property(nonatomic, copy) NSString * modelId;//    车型id    number

@end

@interface SALotListDirectRequest : SALotListRequest

@property(nonatomic, copy) NSDictionary *directParameters;


@end
