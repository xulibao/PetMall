//
//  SABidAVIMTypedMessage.h
//  SnailAuction
//
//  Created by imeng on 08/03/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "AVIMTypedMessage.h"
#import "SALotPriceInfoEntity.h"

@interface SAAVIMLotInfoListUpdateMessage : AVIMTypedMessage <AVIMTypedMessageSubclassing>

@end

@interface SAAVIMBidMessage : AVIMTypedMessage <AVIMTypedMessageSubclassing>

@property(nonatomic, strong) SALotPriceInfoEntity *priceInfo;

@end

@class SAVideoViewerNotificationEntity;
@interface SAAVIMVideoViewerNotificationMessage : AVIMTypedMessage <AVIMTypedMessageSubclassing>

@property(nonatomic, strong) SAVideoViewerNotificationEntity *notification;

@end

@interface SAVideoViewerNotificationEntity : NSObject

@property(nonatomic, copy) NSString *surveyorId;//检测师ID
@property(nonatomic, copy) NSString *surveyorName;//检测师名称
@property(nonatomic, copy) NSString *roomNo;//视频房间
@property(nonatomic, copy) NSString *surveyorIcon;//检测师头像

@end
