//
// Created by Arturo Gutierrez on 15/05/15.
// Copyright (c) 2015 Arturo Gutierrez. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RBMessage : NSObject

@property(nonatomic, copy) NSString *identifier;
@property(nonatomic, strong) id <NSCoding, NSObject> body;

- (instancetype)initWithIdentifier:(NSString *)identifier body:(id <NSCoding, NSObject>)body;

- (BOOL)isEqualToMessage:(RBMessage *)message;

+ (instancetype)emptyMessageWithIdentifier:(NSString *)identifier;

@end