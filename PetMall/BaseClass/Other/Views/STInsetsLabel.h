//
//  STInsetsLabel.h
//  SnailTruck
//
//  Created by 唐欢 on 15/11/26.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STInsetsLabel : UILabel

@property(nonatomic) UIEdgeInsets textContainerInset;

-(instancetype) initWithInsets: (UIEdgeInsets) insets;

@end
