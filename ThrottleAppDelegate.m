//
//  ThrottleAppDelegate.m
//  Throttle
//
//  Created by Scott Jackson on 26/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ThrottleAppDelegate.h"

@implementation ThrottleAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

@end
