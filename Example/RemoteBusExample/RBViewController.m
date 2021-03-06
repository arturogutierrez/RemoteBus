//
//  RBViewController.m
//  RemoteBusExample
//
//  Created by Arturo Gutierrez on 15/05/15.
//  Copyright (c) 2015 Arturo Gutierrez. All rights reserved.
//


#import "RBViewController.h"
#import "RBRemoteBus.h"
#import "RBMessage.h"

NSString *const kAppGroupIdentifier = @"group.com.arturogutierrez.remotebus";
NSString *const kBusName = @"ExampleRemoteBus";

NSString *const kSwitchMessageIdentifier = @"switch_message_identifier";
NSString *const kTextWatchMessageIdentifier = @"watch_text_message_identifier";
NSString *const kTextMessageIdentifier = @"text_message_identifier";

@interface RBViewController ()

@property(nonatomic, strong) RBRemoteBus *remoteBus;

@end

@implementation RBViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureBus];

    [self.someSwitch addTarget:self action:@selector(switchStateChanged:) forControlEvents:UIControlEventValueChanged];
    [self.textfield addTarget:self action:@selector(textfieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - UI Actions

- (void)switchStateChanged:(id)sender {
    RBMessage *message = [[RBMessage alloc] initWithIdentifier:kSwitchMessageIdentifier body:@(self.someSwitch.on)];

    [self sendMessage:message remoteBus:self.remoteBus];
}

- (void)textfieldValueChanged:(id)sender {
    RBMessage *message = [[RBMessage alloc] initWithIdentifier:kTextMessageIdentifier body:self.textfield.text];

    [self sendMessage:message remoteBus:self.remoteBus];
}

#pragma mark - Private Methods

- (void)configureBus {
    // Create bus for this app group and name
    self.remoteBus = [[RBRemoteBus alloc] initWithName:kBusName appGroupIdentifier:kAppGroupIdentifier];
    // Listen remote events from Watch
    [self.remoteBus subscribeForIdentifier:kSwitchMessageIdentifier subscriber:^(RBMessage *message) {
        NSNumber *switchStatus = (NSNumber *) message.body;
        [self.someSwitch setOn:[switchStatus boolValue] animated:YES];
    }];
    [self.remoteBus subscribeForIdentifier:kTextWatchMessageIdentifier subscriber:^(RBMessage *message) {
        NSString *text = (NSString *) message.body;
        self.textfield.text = text;
    }];
}

- (void)sendMessage:(RBMessage *)message remoteBus:(RBRemoteBus *)remoteBus {
    NSLog(@"Sending %@ to bus %@", message, self.remoteBus);

    [remoteBus sendMessage:message];
}


@end