//
// Created by Arturo Gutierrez on 15/05/15.
// Copyright (c) 2015 Arturo Gutierrez. All rights reserved.
//

#import "RBRemoteFolder.h"
#import "RBSupportChecker.h"


@implementation RBSupportChecker

+ (BOOL)hasAppGroupContainerSupport:(NSString *)appGroupIdentifier {
    NSFileManager *defaultFileManager = [NSFileManager defaultManager];
    BOOL containerSupport = [defaultFileManager respondsToSelector:@selector(containerURLForSecurityApplicationGroupIdentifier:)];
    if (containerSupport) {
        return [RBSupportChecker containerURLForAppGroupIdentifier:appGroupIdentifier] != nil;
    }
    return YES;
}

+ (NSURL *)containerURLForAppGroupIdentifier:(NSString *)identifier {
    NSFileManager *defaultFileManager = [NSFileManager defaultManager];
    NSURL *appGroupUrl = [defaultFileManager containerURLForSecurityApplicationGroupIdentifier:identifier];

    return appGroupUrl;
}
@end