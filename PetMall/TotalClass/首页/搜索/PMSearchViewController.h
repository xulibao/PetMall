//
//  PMSearchViewController.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/16.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "STBaseViewController.h"

@interface PMSearchViewController : STBaseViewController
/** 搜索栏 */
@property (nonatomic, weak) UISearchBar *searchBar;

@property (nonatomic, strong) NSArray *tagsArray;
@end
