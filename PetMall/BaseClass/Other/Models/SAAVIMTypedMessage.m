//
//  SAAVIMTypedMessage.m
//  SnailAuction
//
//  Created by imeng on 08/03/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "SAAVIMTypedMessage.h"

@implementation SAAVIMLotInfoListUpdateMessage

+ (void)load {
    [self registerSubclass];
}

#pragma mark - AVIMTypedMessageSubclassing

+ (AVIMMessageMediaType)classMediaType {
    return 3;
}

@end

@implementation SAAVIMBidMessage

+ (void)load {
    [self registerSubclass];
}

- (SALotPriceInfoEntity *)priceInfo {
    if (_priceInfo) {return _priceInfo;}
    _priceInfo = [SALotPriceInfoEntity mj_objectWithKeyValues:self.attributes];
    return _priceInfo;
}

#pragma mark - AVIMTypedMessageSubclassing

+ (AVIMMessageMediaType)classMediaType {
    return 1;
}

@end

@implementation SAAVIMVideoViewerNotificationMessage

+ (void)load {
    [self registerSubclass];
}

- (SAVideoViewerNotificationEntity *)notification {
    if (_notification) {return _notification;}
    _notification = [SAVideoViewerNotificationEntity mj_objectWithKeyValues:self.attributes];
    return _notification;
}

#pragma mark - AVIMTypedMessageSubclassing

+ (AVIMMessageMediaType)classMediaType {
    return 6;
}

@end

@implementation SAVideoViewerNotificationEntity

@end
