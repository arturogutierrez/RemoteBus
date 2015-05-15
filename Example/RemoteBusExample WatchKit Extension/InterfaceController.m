//
//  InterfaceController.m
//  RemoteBusExample WatchKit Extension
//
//  Created by Arturo Gutierrez on 15/05/15.
//  Copyright (c) 2015 Arturo Gutierrez. All rights reserved.
//

#import "InterfaceController.h"
#import "RBRemoteBus.h"
#import "RBMessage.h"

NSString *const kAppGroupIdentifier = @"group.com.arturogutierrez.remotebus";
NSString *const kBusName = @"ExampleRemoteBus";

NSString *const kSwitchMessageIdentifier = @"switch_message_identifier";
NSString *const kTextWatchMessageIdentifier = @"watch_text_message_identifier";
NSString *const kTextMessageIdentifier = @"text_message_identifier";

@interface InterfaceController ()

@property(nonatomic, strong) RBRemoteBus *remoteBus;

@end

@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    [self configureBus];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

#pragma mark - UI Actions

- (IBAction)heyButtonPessed {
    RBMessage *message = [[RBMessage alloc] initWithIdentifier:kTextWatchMessageIdentifier body:@"Hey there!"];

    [self sendMessage:message remoteBus:self.remoteBus];
}

- (IBAction)coolButtonPressed {
    RBMessage *message = [[RBMessage alloc] initWithIdentifier:kTextWatchMessageIdentifier body:@"Cool, it just works!"];

    [self sendMessage:message remoteBus:self.remoteBus];
}

- (IBAction)switchPressed:(BOOL)on {
    RBMessage *message = [[RBMessage alloc] initWithIdentifier:kSwitchMessageIdentifier body:@(on)];

    [self sendMessage:message remoteBus:self.remoteBus];
}

#pragma mark - Private Methods

- (void)configureBus {
    // Create bus for this app group and name
    self.remoteBus = [[RBRemoteBus alloc] initWithName:kBusName appGroupIdentifier:kAppGroupIdentifier];

    // Listen remote events from Watch
    [self.remoteBus subscribeForIdentifier:kSwitchMessageIdentifier subscriber:^(RBMessage *message) {
        NSNumber *switchStatus = (NSNumber *) message.body;
        [self.someSwitch setOn:[switchStatus boolValue]];
    }];
    [self.remoteBus subscribeForIdentifier:kTextMessageIdentifier subscriber:^(RBMessage *message) {
        NSString *text = (NSString *) message.body;
        [self.label setText:text];
    }];
}

- (void)sendMessage:(RBMessage *)message remoteBus:(RBRemoteBus *)remoteBus {
    NSLog(@"Sending %@ to bus %@", message, self.remoteBus);

    [remoteBus sendMessage:message];
}

@end



