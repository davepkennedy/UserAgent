//
//  AppDelegate.h
//  UserAgent
//
//  Created by David Kennedy on 15/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define GET     0
#define PUT     1
#define POST    2
#define DELETE  3
#define HEAD    4
#define TRACE   5
#define OPTIONS 6

@interface AppDelegate : NSObject <NSApplicationDelegate, NSURLConnectionDelegate>

@property (weak) IBOutlet NSTextField *url;
@property (weak) IBOutlet NSPopUpButton *method;
@property (weak) IBOutlet NSArrayController *requestHeaderController;
@property (weak) IBOutlet NSArrayController *responseHeaderController;
@property (unsafe_unretained) IBOutlet NSTextView *responseData;
@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTableView *responseHeaderTable;

@end
