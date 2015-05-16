//
// Created by Arturo Gutierrez on 15/05/15.
// Copyright (c) 2015 Arturo Gutierrez. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RBMessage;

typedef void (^subscriberBlock)(RBMessage *message);

@interface RBRemoteBus : NSObject

- (instancetype)initWithName:(NSString *)name appGroupIdentifier:(NSString *)appGroupIdentifier;

- (void)sendMessage:(RBMessage *)message;

- (void)subscribeForIdentifier:(NSString *)identifier subscriber:(subscriberBlock)subscriber;

- (void)unsubscribeForIdentifier:(NSString *)identifier;

- (void)clearAllMessages;

@end