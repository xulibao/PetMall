//
//  STQNTokenRequest.h
//  SnailTruck
//
//  Created by imeng on 3/3/17.
//  Copyright © 2017 GhGh. All rights reserved.
//

#import "SARequest.h"

@interface STQNTokenResponseEntity : STAPIBaseResponse

@property(nonatomic, strong) NSString *upToken;

@end

@interface STQNTokenRequest : GARequest

@end
