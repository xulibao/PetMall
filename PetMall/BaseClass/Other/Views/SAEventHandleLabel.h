//
//  SAEventHandleLabel.h
//  SnailAuction
//
//  Created by imeng on 06/03/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAEventHandleLabel : UILabel

- (instancetype)initWithEventName:(NSString *)eventName;

@property(nonatomic, copy) NSString *eventName;
@property(nonatomic, copy) void (^eventCallBack)(SAEventHandleLabel *label);

@property(nonatomic, assign) BOOL enableEvent;

@end
