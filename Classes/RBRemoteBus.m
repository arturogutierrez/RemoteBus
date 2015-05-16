//
// Created by Arturo Gutierrez on 15/05/15.
// Copyright (c) 2015 Arturo Gutierrez. All rights reserved.
//

#import "RBRemoteBus.h"
#import "RBRemoteFolder.h"
#import "RBMessage.h"
#import "RBSupportChecker.h"

NSString *const RBRemoteBusDarwinNotification = @"RBRemoteBusDarwinNotification";
NSString *const RBRemoteBudDarwinNotificationIdentifierKey = @"identifier";

void darwinNotificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, void const *object, CFDictionaryRef userInfo);

@interface RBRemoteBus ()

@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong) RBRemoteFolder *remoteFolder;
@property(nonatomic, strong) NSMutableDictionary *subscribers;

@end

@implementation RBRemoteBus

- (instancetype)initWithName:(NSString *)name appGroupIdentifier:(NSString *)appGroupIdentifier {
    if (self = [super init]) {
        if (![RBSupportChecker hasAppGroupContainerSupport:appGroupIdentifier]) {
            return nil;
        }

        NSURL *groupContainerUrl = [self groupContainerUrlForAppGroupIdentifier:appGroupIdentifier];
        _remoteFolder = [[RBRemoteFolder alloc] initWithBusName:name appGroupUrl:groupContainerUrl];
        _subscribers = [NSMutableDictionary new];
        _name = name;

        [self registerForDarwinNotification];
    }

    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@(%ld subscribers)", self.name, (unsigned long) [self.subscribers count]];
}

- (void)dealloc {
    [self unregisterForAllNotifications];
    [self unregisterForAllRemoteNotifications];
}

#pragma mark - Public Methods

- (void)sendMessage:(RBMessage *)message {
    if (message.identifier == nil) {
        return;
    }

    if (message) {
        [self.remoteFolder saveMessage:message];
    }

    [self notifyRemoteSubscribers:message.identifier];
}

- (void)subscribeForIdentifier:(NSString *)identifier subscriber:(subscriberBlock)subscriber {
    if (identifier == nil) {
        return;
    }

    [self saveSubscriber:subscriber identifier:identifier];
    [self registerForRemoteNotifications:identifier];
}

- (void)unsubscribeForIdentifier:(NSString *)identifier {
    if (identifier == nil) {
        return;
    }

    [self removeSubscriber:identifier];
    [self unregisterForRemoteNotifications:identifier];
}

- (void)clearAllMessages {
    [self.remoteFolder clear];
}


#pragma mark - Private Methods

- (NSURL *)groupContainerUrlForAppGroupIdentifier:(NSString *)appGroupIdentifier {
    return [RBSupportChecker containerURLForAppGroupIdentifier:appGroupIdentifier];
}

- (void)saveSubscriber:(subscriberBlock)subscriber identifier:(NSString *)identifier {
    self.subscribers[identifier] = subscriber;
}

- (void)removeSubscriber:(NSString *)identifier {
    [self.subscribers removeObjectForKey:identifier];
}

- (void)didReceiveDarwinCallback:(NSNotification *)notification {
    NSString *identifier = notification.userInfo[RBRemoteBudDarwinNotificationIdentifierKey];
    RBMessage *message = [self.remoteFolder messageForIdentifier:identifier];

    if (message) {
        [self notifyLocalSubscribers:message];
    }
}

- (void)notifyLocalSubscribers:(RBMessage *)message {
    subscriberBlock subscriber = self.subscribers[message.identifier];
    if (subscriber) {
        dispatch_async(dispatch_get_main_queue(), ^{
            subscriber(message);
        });
    }
}

- (void)registerForDarwinNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveDarwinCallback:) name:RBRemoteBusDarwinNotification object:nil];
}

- (void)unregisterForAllNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)notifyRemoteSubscribers:(NSString *)identifier {
    CFNotificationCenterRef darwinNotificationCenter = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterPostNotification(darwinNotificationCenter, (__bridge CFStringRef) identifier, NULL, NULL, YES);
}

- (void)registerForRemoteNotifications:(NSString *)identifier {
    CFNotificationCenterRef darwinNotificationCenter = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterAddObserver(darwinNotificationCenter,
            (__bridge const void *) self,
            darwinNotificationCallback,
            (__bridge CFStringRef) identifier,
            NULL,
            CFNotificationSuspensionBehaviorDeliverImmediately);
}

- (void)unregisterForRemoteNotifications:(NSString *)identifier {
    CFNotificationCenterRef darwinNotificationCenter = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterRemoveObserver(darwinNotificationCenter,
            (__bridge const void *) self,
            (__bridge CFStringRef) identifier,
            NULL);
}

- (void)unregisterForAllRemoteNotifications {
    CFNotificationCenterRef const center = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterRemoveEveryObserver(center, (__bridge const void *) (self));
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"

void darwinNotificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, void const *object, CFDictionaryRef userInfo) {
    if (name == NULL) {
        return;
    }

    NSString *identifier = (__bridge NSString *) name;
    [[NSNotificationCenter defaultCenter] postNotificationName:RBRemoteBusDarwinNotification object:nil userInfo:@{RBRemoteBudDarwinNotificationIdentifierKey : identifier}];
}
#pragma clang diagnostic pop

@end