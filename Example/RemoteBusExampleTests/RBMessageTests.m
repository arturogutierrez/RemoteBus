//
// Created by Arturo Gutierrez on 15/05/15.
// Copyright (c) 2015 Arturo Gutierrez. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RBMessage.h"

NSString *const kExampleIdentifier = @"example_identifier";

@interface RBMessageTests : XCTestCase

@end

@implementation RBMessageTests

- (void)testEmptyMessage {
    RBMessage *message = [RBMessage emptyMessageWithIdentifier:kExampleIdentifier];

    XCTAssertEqual(kExampleIdentifier, message.identifier, @"should return a identifier");
    XCTAssertNil(message.body, @"should return a empty body");
}

- (void)testMessageWithContent {
    NSString *body = @"body";
    RBMessage *message = [[RBMessage alloc] initWithIdentifier:kExampleIdentifier body:body];

    XCTAssertEqual(kExampleIdentifier, message.identifier, @"should return a identifier");
    XCTAssertEqual(body, message.body, @"should return a body");
}

- (void)testMessagesWithDifferentIdentifierAndBodies {
    RBMessage *message = [[RBMessage alloc] initWithIdentifier:@"id1" body:@"body1"];
    RBMessage *anotherMessage = [[RBMessage alloc] initWithIdentifier:@"id2" body:@{@"key" : @"value"}];

    XCTAssertNotEqualObjects(message, anotherMessage, @"should be not equal");
}

- (void)testMessagesWithSameIdentifierButDifferentBodies {
    RBMessage *message = [[RBMessage alloc] initWithIdentifier:@"identifier" body:@"body1"];
    RBMessage *anotherMessage = [[RBMessage alloc] initWithIdentifier:@"identifier" body:@{@"key" : @"value"}];

    XCTAssertNotEqualObjects(message, anotherMessage, @"should be not equal");
}

- (void)testMessagesWithSameIdentifierAndBody {
    RBMessage *message = [[RBMessage alloc] initWithIdentifier:@"identifier" body:@{@"key" : @"value"}];
    RBMessage *anotherMessage = [[RBMessage alloc] initWithIdentifier:@"identifier" body:@{@"key" : @"value"}];
    XCTAssertEqualObjects(message, anotherMessage, @"should be equal");

    message = [[RBMessage alloc] initWithIdentifier:@"id" body:@"body"];
    anotherMessage = [[RBMessage alloc] initWithIdentifier:@"id" body:@"body"];
    XCTAssertEqualObjects(message, anotherMessage, @"should be equal");
}

@end