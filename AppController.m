//
//  AppController.m
//  Throttle
//
//  Created by Scott Jackson on 26/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"


@implementation AppController

- (id)init
{
    [super init];
    [self setValue:@"KB/s"  forKey:@"units"];
    [self setValue:[NSNumber numberWithInt:5] forKey:@"amountToThrottleTo"];
    [self setValue:0 forKey:@"throttling"];
    [self setValue:[NSNumber numberWithInt:80] forKey:@"port"];
    return self;
}

- (NSNumber*)amountToThrottleTo
{
    NSLog(@"amount is %@", amountToThrottleTo);
    return amountToThrottleTo;
}

- (void)setAmountToThrottleTo:(NSNumber*)n
{
    amountToThrottleTo = n;
    NSLog(@"amount is now %@", amountToThrottleTo);
    
}

- (NSString*)units
{
    NSLog(@"units is %@", units);
    return units;
}

- (void)setUnits:(NSString*)s
{
    units = s;
    NSLog(@"units is now %@", units);
}

- (NSNumber*)port
{
    NSLog(@"Port to throttle is %@", port);
    return port;
}

- (void)setPort:(NSNumber*)n
{
    port = n;
    NSLog(@"Port to throttle is now %@", port);
}

- (IBAction)toggleThrottling:(id)sender
{
    
    if (!throttling && amountToThrottleTo != nil && port != nil) {
        NSLog(@"Attempting to begin throttling to %@ %@ on port %@", amountToThrottleTo, units, port);
        
        NSString* ipfwPath = @"/sbin/ipfw";
        NSString* pipe = @"pipe";
        NSString* one = @"1";
        NSString* config = @"config";
        NSString* bw = @"bw";
        NSString* amount;
        
        if (units == @"KB/s") {
            amount = [NSString stringWithFormat:@"%@Kbyte/s", amountToThrottleTo];
        } else {
            amount = [NSString stringWithFormat:@"%@Mbyte/s", amountToThrottleTo];
        }
        
        /* Create a pipe that only allows up to `amount` through. */
        
        NSTask* makePipeTask = [[NSTask alloc] init];
        NSString* resourcesPath = [[NSBundle mainBundle] resourcePath]; // Gets path to Resources folder.
        NSString* cocoasudoPath = [resourcesPath stringByAppendingPathComponent:@"cocoasudo"];
        
        [makePipeTask setLaunchPath:cocoasudoPath];
        
        NSArray* arguments = [NSArray arrayWithObjects:ipfwPath, pipe, one, config, bw, amount, nil];
        [makePipeTask setArguments:arguments];
        
        [makePipeTask launch];
        NSLog(@"cocoasudo launched with arguments: %@", arguments);
        [makePipeTask waitUntilExit];
        
        if ([makePipeTask terminationStatus] == 0) {
            /* Attach the pipe to the traffic on `port`. */
            
            NSString* add = @"add";
            NSString* srcport = @"src-port";
            NSTask* throttleTask = [[NSTask alloc] init];
            [throttleTask setLaunchPath:cocoasudoPath];
            arguments = [NSArray arrayWithObjects:ipfwPath, add, one, pipe, one, srcport, [port stringValue], nil];
            [throttleTask setArguments:arguments];
            [throttleTask launch];
            NSLog(@"cocoasudo launched with arguments: %@", arguments);
            [throttleTask waitUntilExit];
            
            if ([throttleTask terminationStatus] == 0) {
                throttling = [NSNumber numberWithInt:1];
                
                NSLog(@"Throttling has begun.");
                NSLog(@"Throttling bandwidth on port %@ to %@%@", port, amountToThrottleTo, units);
                
                [throttleButton setTitle:@"Cancel throttling"];
                [textField setEditable:NO];
                [textField setSelectable:NO];
            } else {
                NSLog(@"Permission not granted to begin throttling.");
            }
        } else {
            NSLog(@"Permission not granted to begin throttling.");
        }

    } else if (throttling) {
        NSTask* stopThrottleTask = [[NSTask alloc] init];
        NSString* resourcesPath = [[NSBundle mainBundle] resourcePath]; // Gets path to Resources folder.
        NSString* cocoasudoPath = [resourcesPath stringByAppendingPathComponent:@"cocoasudo"];
        
        [stopThrottleTask setLaunchPath:cocoasudoPath];
        
        NSString* ipfwPath = @"/sbin/ipfw";
        NSString* del = @"delete";
        NSString* one = @"1";
        NSArray* arguments = [NSArray arrayWithObjects:ipfwPath, del, one, nil];
        [stopThrottleTask setArguments:arguments];
        
        [stopThrottleTask launch];
        NSLog(@"cocoasudo launched with arguments: %@", arguments);
        [stopThrottleTask waitUntilExit];
        
        if ([stopThrottleTask terminationStatus] == 0) {
            throttling = [NSNumber numberWithInt:0];
            
            NSLog(@"Throttling has stopped.");
            
            [throttleButton setTitle:@"Begin throttling"];
            [textField setEditable:YES];
            [textField setSelectable:YES];
        } else {
            NSLog(@"Permission not granted to stop throttling.");
        }
    } else {
        NSLog(@"Cannot begin throttling -- amount field and/or port field is empty.");
    }

}

@end
