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
    [self setValue:[NSNumber numberWithInt:1] forKey:@"amountToThrottleTo"];
    [self setValue:0 forKey:@"throttling"];
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

- (IBAction)toggleThrottling:(id)sender
{
    if (!throttling) {
        NSLog(@"Throttling back to %@ %@", amountToThrottleTo, units);
        
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
        
        NSTask* throttleTask = [[NSTask alloc] init];
        NSString* resourcesPath = [[NSBundle mainBundle] resourcePath]; // Gets path to Resources folder.
        NSString* cocoasudoPath = [resourcesPath stringByAppendingPathComponent:@"cocoasudo"];
        
        [throttleTask setLaunchPath:cocoasudoPath];
        
        NSArray* arguments = [NSArray arrayWithObjects:ipfwPath, pipe, one, config, bw, amount, nil];
        [throttleTask setArguments:arguments];
        
        [throttleTask launch];
        NSLog(@"Task launched with arguments: %@", arguments);
        [throttleTask waitUntilExit];
        
        /* Attach the pipe to the outgoing traffic on port 80. */
        
        NSString* add = @"add";
        NSString* srcport = @"src-port";
        NSString* eighty = @"80";
        NSTask* task2 = [[NSTask alloc] init];
        [task2 setLaunchPath:cocoasudoPath];
        arguments = [NSArray arrayWithObjects:ipfwPath, add, one, pipe, one, srcport, eighty, nil];
        [task2 setArguments:arguments];
        [task2 launch];
        NSLog(@"Task launched with arguments: %@", arguments);
        [task2 waitUntilExit];
        
        throttling = [NSNumber numberWithInt:1];
        
        [throttleButton setTitle:@"Cancel throttling"];
        [textField setEditable:NO];
        [textField setSelectable:NO];
        [comboBox setEditable:NO];
        [comboBox setSelectable:NO];
    } else {
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
        [stopThrottleTask waitUntilExit];
        
        throttling = [NSNumber numberWithInt:0];
        
        [throttleButton setTitle:@"Begin throttling"];
        [textField setEditable:YES];
        [textField setSelectable:YES];
        [comboBox setEditable:YES];
        [comboBox setSelectable:YES];
    }
}

@end
