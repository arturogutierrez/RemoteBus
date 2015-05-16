//
// Created by Arturo Gutierrez on 15/05/15.
// Copyright (c) 2015 Arturo Gutierrez. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RBMessage;


@interface RBRemoteFolder : NSObject

- (instancetype)initWithBusName:(NSString *)busName appGroupUrl:(NSURL *)appGroupUrl;

- (void)saveMessage:(RBMessage *)message;

- (RBMessage *)messageForIdentifier:(NSString *)identifier;

- (void)clear;

@end