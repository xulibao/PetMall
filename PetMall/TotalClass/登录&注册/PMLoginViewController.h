//
//  PMLoginViewController.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/8/28.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "STBaseTableViewController.h"

@interface PMLoginViewController : STBaseTableViewController
@property(nonatomic, copy) void (^callBack)(PMLoginViewController *viewController);
@end
