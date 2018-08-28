//
//  SALotInfoItem.h
//  SnailAuction
//
//  Created by imeng on 2018/2/12.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SACommonCountDownItem.h"
#import "SACommonEnum.h"
#import "SAInfoItemProtocol.h"

//type    竞拍类型    number    1-顺序拍 2-并行拍
typedef NS_ENUM(NSUInteger, SALotType) {
    SALotTypeSerial,
    SALotTypeConcurrent,
};

//拍品对象

@interface SALotInfoItem : SACommonCountDownItem <
SACommonListInfoItem
//SAPriceUpdateDelegate
>

@property(nonatomic, assign) long long endCountDown;
@property(nonatomic, assign) long long startCountDown;
@property(nonatomic, copy) NSString *endTime;    //结束时间    string
@property(nonatomic, copy) NSString *startTime;    //开始竞拍时间    string

@property(nonatomic, copy) NSString *bidPrice;    //出价价格    string
@property(nonatomic, copy) NSString *checkGrade;    //检测等级    string
@property(nonatomic, copy) NSString *emission;    //排放标准    string
@property(nonatomic, copy) NSString *finalPrice;    //最终价格    string
//@property(nonatomic, ) isSynchronize;    //是否需要同步    number
@property(nonatomic, copy) NSString *lotId;    //拍品id    number
@property(nonatomic, copy) NSString *maxPrice;    //当前最高价格    string
@property(nonatomic, copy) NSString *placeId;    //场次id    number
@property(nonatomic, copy) NSString *registAddress;    //注册地址    string
@property(nonatomic, copy) NSString *registDate;    //注册时间    string
@property(nonatomic, copy) NSString *showImgUrl;    //列表图片    string
@property(nonatomic, assign) SAAuctionStatus status;    //拍卖状态    number    1.预展中(竞拍未开始) 2.竞拍中
@property(nonatomic, copy) NSString *title;    //车辆标题    string
@property(nonatomic, copy) NSString *truckId;    //车辆iid    number
@property(nonatomic, assign) long long truckNum;    //拍品中车辆的数量    number
@property(nonatomic, assign) SALotType type;    //竞拍类型    number    1-顺序拍 2-并行拍

@property(nonatomic, copy) NSString *convId;//即时通讯ID

/********************UI*******************/
@property(nonatomic, strong, readonly) NSString *statusText;
- (NSAttributedString *)uiEndTime;
/********************UI*******************/

@end
