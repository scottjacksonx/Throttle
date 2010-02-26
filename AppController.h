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
    IBOutlet NSComboBox* comboBox;
    IBOutlet NSButton* throttleButton;
    NSString* units;
    NSNumber* amountToThrottleTo;
    NSNumber* throttling;
}


- (IBAction)toggleThrottling:(id)sender;


@end
