//
//  STCoverView.h
//  SnailTruck
//
//  Created by 唐欢 on 15/11/5.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STCoverView : UIView
- (instancetype)initWithSuperView:(UIView*)container complete:(void(^)(UIView*))clickBlock;
@end
