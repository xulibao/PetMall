//
//  PMTimeLimitViewController.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/16.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "SAIndicatorSegmentViewController.h"
#import "SAInfoListViewController.h"

@interface PMTimeLimitViewController : SAIndicatorSegmentViewController

@end
@interface PMTimeLimitListViewController : SAInfoListViewController
@property(nonatomic, copy) NSString *timeLimitNavId;
@property(nonatomic, strong) NSMutableArray *dataArray;
@end
