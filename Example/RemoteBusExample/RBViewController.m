//
//  RBViewController.m
//  RemoteBusExample
//
//  Created by Arturo Gutierrez on 15/05/15.
//  Copyright (c) 2015 Arturo Gutierrez. All rights reserved.
//


#import "RBViewController.h"
#import "RBRemoteBus.h"

NSString *const appGroupIdentifier = @"group.com.arturogutierrez.remotebus";
NSString *const busName = @"example_bus";

@interface RBViewController ()

@property(nonatomic, strong) RBRemoteBus *remoteBus;

@end

@implementation RBViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.remoteBus = [[RBRemoteBus alloc] initWithName:busName appGroupIdentifier:appGroupIdentifier];
}


@end