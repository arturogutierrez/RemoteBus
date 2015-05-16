//
// Created by Arturo Gutierrez on 15/05/15.
// Copyright (c) 2015 Arturo Gutierrez. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RBSupportChecker : NSObject

+ (BOOL)hasAppGroupContainerSupport:(NSString *)appGroupIdentifier;

+ (NSURL *)containerURLForAppGroupIdentifier:(NSString *)identifier;

@end