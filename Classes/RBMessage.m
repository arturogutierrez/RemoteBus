//
// Created by Arturo Gutierrez on 15/05/15.
// Copyright (c) 2015 Arturo Gutierrez. All rights reserved.
//

#import "RBMessage.h"


@implementation RBMessage

- (instancetype)initWithIdentifier:(NSString *)identifier body:(id <NSCoding, NSObject>)body {
    if (self = [super init]) {
        _identifier = identifier;
        _body = body;
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    if (!object || ![object isKindOfClass:[self class]]) {
        return NO;
    }

    return [self isEqualToMessage:object];
}

- (BOOL)isEqualToMessage:(RBMessage *)message {
    if (self == message) {
        return YES;
    }

    return [message.identifier isEqualToString:self.identifier] && [message.body isEqual:self.body];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"RBMessage{identifier: \"%@\", body: \"%@\"}", self.identifier, self.body];
}

#pragma mark - Class Methods

+ (instancetype)emptyMessageWithIdentifier:(NSString *)identifier {
    return [[RBMessage alloc] initWithIdentifier:identifier body:nil];
}

@end