//
//  AppController.h
//  Throttle
//
//  Created by Scott Jackson on 26/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
    IBOutlet NSTextField* textField;
    IBOutlet NSPopUpButton* comboBox;
    IBOutlet NSButton* throttleButton;
    IBOutlet NSTextField* portField;
    IBOutlet NSButton* confirmPrefsButton;
    IBOutlet NSWindow* prefsWindow;
    NSString* units;
    NSNumber* amountToThrottleTo;
    NSNumber* port;
    NSNumber* throttling;
}


- (IBAction)toggleThrottling:(id)sender;


@end
