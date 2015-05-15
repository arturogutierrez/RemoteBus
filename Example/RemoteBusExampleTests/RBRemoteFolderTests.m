//
// Created by Arturo Gutierrez on 15/05/15.
// Copyright (c) 2015 Arturo Gutierrez. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RBRemoteFolder.h"
#import "RBMessage.h"


NSString *const kExampleAppGroup = @"group.example";
NSString *const kExampleName = @"exampleBusName";

@interface RBRemoteFolderTests : XCTestCase

@property (nonatomic, copy) NSString *containerDirectory;
@property (nonatomic, copy) NSString *busDirectory;

@end

@implementation RBRemoteFolderTests

- (void)setUp {
    [super setUp];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = paths[0];
    self.containerDirectory = [cacheDirectory stringByAppendingPathComponent:kExampleAppGroup];
    self.busDirectory = [self.containerDirectory stringByAppendingPathComponent:kExampleName];
}

- (void)tearDown {
    [super tearDown];

    // Clean bus folder after each test
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:self.containerDirectory error:nil];
}

- (void)testCreatingFolderForBus {
    NSURL *urlContainerDirectory = [NSURL fileURLWithPath:self.containerDirectory];
    RBRemoteFolder *remoteFolder = [[RBRemoteFolder alloc] initWithBusName:kExampleName appGroupUrl:urlContainerDirectory];

    BOOL isDirectory = NO;
    BOOL existsBusDirectory = [[NSFileManager defaultManager] fileExistsAtPath:self.busDirectory isDirectory:&isDirectory];
    XCTAssertNotNil(remoteFolder, @"should be a valid instance");
    XCTAssertTrue(existsBusDirectory, @"should exists the bus folder");
    XCTAssertTrue(isDirectory, @"should be a directory");
}

- (void)testSaveMessage {
    NSString *identifier = @"identifier";
    NSDictionary *bodyMessage = @{@"key" : @"value"};

    RBMessage *message = [[RBMessage alloc] initWithIdentifier:identifier body:bodyMessage];
    RBRemoteFolder *remoteFolder = [[RBRemoteFolder alloc] initWithBusName:kExampleName appGroupUrl:[NSURL fileURLWithPath:self.containerDirectory]];
    [remoteFolder saveMessage:message];

    NSString *messageFilePath = [self.busDirectory stringByAppendingPathComponent:identifier];
    BOOL existsMessageFile = [[NSFileManager defaultManager] fileExistsAtPath:messageFilePath];
    XCTAssertTrue(existsMessageFile, @"should exists the message file");
}

- (void)testSaveAndLoadMessage {
    NSString *identifier = @"identifier";
    NSDictionary *bodyMessage = @{@"key" : @"value"};

    RBRemoteFolder *remoteFolder = [[RBRemoteFolder alloc] initWithBusName:kExampleName appGroupUrl:[NSURL fileURLWithPath:self.containerDirectory]];
    RBMessage *message = [[RBMessage alloc] initWithIdentifier:identifier body:bodyMessage];
    [remoteFolder saveMessage:message];
    RBMessage *loadedMessage = [remoteFolder messageForIdentifier:identifier];

    XCTAssertEqualObjects(message, loadedMessage, @"should be equals");
}

@end