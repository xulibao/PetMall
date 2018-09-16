//
//  PMShareView.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/16.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMShareView : UIView

@property(nonatomic, strong) NSArray *btnArray;
@property(nonatomic, copy) void (^cancel)();
@end
