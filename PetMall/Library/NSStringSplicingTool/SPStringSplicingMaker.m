//
//  XLBSumMaker.m
//  Blcok
//
//  Created by 徐礼宝 on 2018/5/21.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "SPStringSplicingMaker.h"

@interface SPStringSplicingMaker()

@end

@implementation SPStringSplicingMaker

- (SPStringSplicingMaker *(^)(id str))add{
    @weakify(self);
   return ^(id str){
       NSString * addStr;
       if ([str isKindOfClass:[NSNumber class]]) {
           addStr = [str stringValue];
       }else{
           addStr = str;
       }
       weak_self.result = [weak_self.result stringByAppendingString:addStr ? addStr : @""];
        return self;
   };
    
}

@end
