//
//  PMOrderDetailBottomView.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMOrderDetailBottomView : UIView
@property(nonatomic, copy) void (^copyBlcok)();
@property(nonatomic, copy) void (^commentBlcok)();
@end
