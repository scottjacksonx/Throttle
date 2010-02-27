//
//  AppController.h
//  Throttle
//
//  Created by Scott Jackson on 26/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
    IBOutlet NSWindow* window;
    IBOutlet NSTextField* textField;
    IBOutlet NSPopUpButton* unitsBox;
    IBOutlet NSButton* throttleButton;
    IBOutlet NSTextField* portField;
    IBOutlet NSButton* confirmPrefsButton;
    IBOutlet NSWindow* prefsWindow;
    NSString* units;
    NSNumber* amountToThrottleTo;
    NSNumber* port;
    NSNumber* throttling;
}

@property(readwrite, assign) NSString* units;
@property(readwrite, assign) NSNumber* amountToThrottleTo;
@property(readwrite, assign) NSNumber* port;


- (IBAction)toggleThrottling:(id)sender;
- (IBAction)shouldClose:(id)sender;


@end
