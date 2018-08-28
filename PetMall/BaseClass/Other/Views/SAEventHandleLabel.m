//
//  SAEventHandleLabel.m
//  SnailAuction
//
//  Created by imeng on 06/03/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "SAEventHandleLabel.h"

@implementation SAEventHandleLabel {
    BOOL didAddNotification;
}

- (instancetype)initWithEventName:(NSString *)eventName {
    self = [super init];
    if (self) {
        self.eventName = eventName;
    }
    return self;
}

- (void)handleNotification:(NSDictionary *)sender {
    dispatch_main_async_safe(^{
        self.eventCallBack ? self.eventCallBack(self) : nil;
    });
}

- (void)addNotification {
    if (self.enableEvent && self.eventName) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleNotification:)
                                                     name:self.eventName
                                                   object:nil];
        didAddNotification = YES;
    }
}

- (void)removeNotification {
    if (self.eventName) {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:self.eventName
                                                      object:nil];
        didAddNotification = NO;
    }
}

- (void)updateNotificationIfNeeds {
    if (didAddNotification) {
        [self removeNotification];
    }
    [self addNotification];
}

#pragma mark - Setter

- (void)setEnableEvent:(BOOL)enableEvent {
    BOOL shouldUpdate = _enableEvent != enableEvent;
    _enableEvent = enableEvent;
    if (shouldUpdate) {
        [self updateNotificationIfNeeds];
    }
}

- (void)setEventName:(NSString *)eventName {
    BOOL shouldUpdate = ![_eventName isEqualToString:eventName];
    _eventName = eventName;
    if (shouldUpdate) {
        [self updateNotificationIfNeeds];
    }
}

@end
