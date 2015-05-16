RemoteBus
======

Small library to pass messages between iOS apps and extensions. RemoteBus simulates a bus between app and extension to provide a mechanism to to synchronize data or just pass events in a easy way.

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
<img src="https://cocoapod-badges.herokuapp.com/v/RemoteBus/badge.png"/><br/>
You can install [RemoteBus](https://github.com/arturogutierrez/RemoteBus) via [CocoaPods](https://github.com/cocoapods/cocoapods):

```Ruby
pod 'RemoteBus', '~> 1.0.0'
```

Example
-----------
You can check a example in the [Example](Example) folder or just take a look into the [Tests](Example/RemoteBusExampleTests).

Developed By
------------

* Arturo Gutiérrez Díaz-Guerra - <arturo.gutierrez@gmail.com>

<a href="https://twitter.com/arturogdg">
  <img alt="Follow me on Twitter" src="http://imageshack.us/a/img812/3923/smallth.png" />
</a>
<a href="http://www.linkedin.com/in/arturogutierrezdiazguerra">
  <img alt="Add me to Linkedin" src="http://imageshack.us/a/img41/7877/smallld.png" />
</a>


License
-------

    Copyright 2015 Arturo Gutiérrez Díaz-Guerra

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

[1]: ./Art/remotebusdemo.gif
