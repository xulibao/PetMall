//
//  STTabBtnModel.h
//  SnailTruck
//
//  Created by 曼 on 15/10/23.
//  Copyright (c) 2015年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STTabBtnModel : NSObject

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * normalImageName;
@property (nonatomic, copy) NSString * selectImageName;

+ (instancetype)tabBtnModelWithTitle:(NSString *)title normalImageName:(NSString *)normalImageName andSelectImageName:(NSString *)selectImageName;

@end
