//
//  SARequest+Private.h
//  SnailAuction
//
//  Created by imeng on 2018/2/7.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SARequest.h"

@interface SARequest ()

@property(nonatomic, copy) NSString *p_requestUrl;
@property(nonatomic, assign) GARequestMethod p_method;
@property(nonatomic, strong) id p_parameters;

@end
