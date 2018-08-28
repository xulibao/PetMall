//
//  STTabBtnModel.m
//  SnailTruck
//
//  Created by 曼 on 15/10/23.
//  Copyright (c) 2015年 GM. All rights reserved.
//

#import "STTabBtnModel.h"

@implementation STTabBtnModel
+ (instancetype)tabBtnModelWithTitle:(NSString *)title normalImageName:(NSString *)normalImageName andSelectImageName:(NSString *)selectImageName
{
    return [[self alloc] initWithTitle:title normalImageName:normalImageName andSelectImageName:selectImageName];
}

- (instancetype)initWithTitle:(NSString *)title normalImageName:(NSString *)normalImageName andSelectImageName:(NSString *)selectImageName
{
    if (self = [super init]) {
        
        self.title = title;
        self.normalImageName = normalImageName;
        self.selectImageName = selectImageName;
        
    }
    return self;
}
@end
