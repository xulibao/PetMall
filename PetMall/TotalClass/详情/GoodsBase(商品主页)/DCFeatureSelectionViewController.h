//
//  DCFeatureSelectionViewController.h
//  CDDStoreDemo
//
//  Created by apple on 2017/7/12.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "STBaseViewController.h"


@interface DCFeatureSelectionViewController : STBaseViewController

/* 商品图片 */
@property (strong , nonatomic)NSString *goodImageView;
/* 上一次选择的属性 */
@property (strong , nonatomic)NSMutableArray *lastSeleArray;
/* 上一次选择的数量 */
@property (assign , nonatomic)NSString *lastNum;

///** 选择的属性和数量 */
@property (nonatomic , copy) void(^userChooseBlock)(NSInteger tag);
//@property(nonatomic, copy) void (^)()

@end
