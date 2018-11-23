//
//  SABillRecordViewController.h
//  SnailAuction
//
//  Created by imeng on 01/03/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "SAIndicatorSegmentViewController.h"
#import "SAInfoListViewController.h"
#import "PMOrderListCell.h"


@interface PMOrderViewController : SAIndicatorSegmentViewController

@property(nonatomic, assign) PMOrderOrderType type;

@end

@interface PMOrderListViewController : SAInfoListViewController <PMOrderListCellDelegate>

@property(nonatomic, assign) PMOrderOrderType type;


@end
