//
//  PMSearchResultViewController.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "SPInfoListFilterViewController.h"

@interface PMSearchResultViewController : SPInfoListFilterViewController
@property(nonatomic, copy) NSString *keyword;
@property(nonatomic, assign) BOOL isClassic;
@end
