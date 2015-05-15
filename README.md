RemoteBus
======

Small library to help to pass messages between iOS apps and extensions. RemoteBus simulates a bus between them so you can use the bus to help you to synchronize data or just pass events.

Demo
-----------
![Demo][1]


Usage
-----------
```objc
    // Create bus for this app group and name
    remoteBus = [[RBRemoteBus alloc] initWithName:@"OneBus" appGroupIdentifier:@"group.com.arturogutierrez.remotebus"];

    // Subscribe for remote events
    [remoteBus subscribeForIdentifier:@"SomeEventIdentifier" subscriber:^(RBMessage *message) {
        NSString *text = (NSString *) message.body;
        [self.label setText:text];
    }];
    
    // Pass an event
    RBMessage *message = [[RBMessage alloc] initWithIdentifier:@"AnotherEventIdentifier" body:@"Hey there!"];
    [remoteBus sendMessage:message];
```

Installation
-----------
* Download the source files (Classes folder) and add to your project or install it via [CocoaPods](https://github.com/cocoapods/cocoapods) 
* Configure your app and extension to use same app group container. You can learn how to do it [here](https://developer.apple.com/library/ios/documentation/Miscellaneous/Reference/EntitlementKeyReference/Chapters/EnablingAppSandbox.html#//apple_ref/doc/uid/TP40011195-CH4-SW19) or [here](https://developer.apple.com/library/ios/documentation/General/Conceptual/ExtensibilityPG/ExtensionScenarios.html).


Pod
-----------
It will be available via [CocoaPods](https://github.com/cocoapods/cocoapods) very soon.

Developed By
------------

* Arturo Gutiérrez Díaz-Guerra - <arturo.gutierrez@gmail.com>

<a href="https://twitter.com/arturogdg">
  <img alt="Follow me on Twitter" src="http://imageshack.us/a/img812/3923/smallth.png" />
</a>
<a href="http://www.linkedin.com/in/arturogutierrezdiazguerra">
  <img alt="Add me to Linkedin" src="http://imageshack.us/a/img41/7877/smallld.png" />
</a>


[1]: ./Art/remotebusdemo.gif
