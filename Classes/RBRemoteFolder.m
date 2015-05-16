//
// Created by Arturo Gutierrez on 15/05/15.
// Copyright (c) 2015 Arturo Gutierrez. All rights reserved.
//

#import "RBRemoteFolder.h"
#import "RBMessage.h"

@interface RBRemoteFolder ()

@property(nonatomic, copy) NSString *busName;
@property(nonatomic, strong) NSURL *folderUrl;

@end

@implementation RBRemoteFolder

- (instancetype)initWithBusName:(NSString *)busName appGroupUrl:(NSURL *)appGroupUrl {
    if (self = [super init]) {
        _busName = busName;

        [self configureBusFolder:appGroupUrl];
        [self createBusFolder];
    }
    return self;
}

#pragma mark - Public Methods

- (void)saveMessage:(RBMessage *)message {
    NSData *messageData = [self serializeMessage:message];

    if (messageData != nil) {
        NSString *messageFilePath = [self filePathForMessage:message];
        [messageData writeToFile:messageFilePath atomically:YES];
    }
}

- (RBMessage *)messageForIdentifier:(NSString *)identifier {
    NSString *messageFilePath = [self filePathForIdentifier:identifier];
    RBMessage *message = [self createMessageFromFilePath:messageFilePath withIdentifier:identifier];

    return message;
}

- (void)clear {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *folderPath = self.folderUrl.path;

    NSArray *files = [fileManager contentsOfDirectoryAtPath:folderPath error:nil];
    for (NSString *fileName in files) {
        NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}


#pragma mark - Private Methods

- (void)configureBusFolder:(NSURL *)appGroupUrl {
    NSString *appGroupPath = [appGroupUrl path];
    NSString *busPath = [appGroupPath stringByAppendingPathComponent:self.busName];

    self.folderUrl = [NSURL fileURLWithPath:busPath];
}

- (void)createBusFolder {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtURL:self.folderUrl withIntermediateDirectories:YES attributes:nil error:nil];
}

- (NSData *)serializeMessage:(RBMessage *)message {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:message.body];
    return data;
}

- (NSString *)filePathForMessage:(RBMessage *)message {
    return [self filePathForIdentifier:message.identifier];
}

- (NSString *)filePathForIdentifier:(NSString *)identifier {
    NSString *folderPath = [self.folderUrl path];
    NSString *messageFilePath = [folderPath stringByAppendingPathComponent:identifier];

    return messageFilePath;
}

- (RBMessage *)createMessageFromFilePath:(NSString *)filePath withIdentifier:(NSString *)identifier {
    @try {
        id <NSCoding, NSObject> messageBody = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        if (messageBody) {
            return [[RBMessage alloc] initWithIdentifier:identifier body:messageBody];
        }
    } @catch (NSException *exception) {
        // Unable to unarchive saved message.
    }

    return nil;
}

@end