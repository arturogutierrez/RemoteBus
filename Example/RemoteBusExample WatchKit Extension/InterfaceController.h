//
//  InterfaceController.h
//  RemoteBusExample WatchKit Extension
//
//  Created by Arturo Gutierrez on 15/05/15.
//  Copyright (c) 2015 Arturo Gutierrez. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController

@property(nonatomic, weak) IBOutlet WKInterfaceSwitch *someSwitch;
@property(nonatomic, weak) IBOutlet WKInterfaceLabel *label;

- (IBAction)heyButtonPessed;

- (IBAction)coolButtonPressed;

- (IBAction)switchPressed:(BOOL)on;

@end
