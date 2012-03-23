//
//  AppDelegate.m
//  UserAgent
//
//  Created by David Kennedy on 15/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize url = _url;
@synthesize method = _method;
@synthesize requestHeaderController = _requestHeaderController;
@synthesize responseHeaderController = _responseHeaderController;
@synthesize responseData = _responseData;
@synthesize window = _window;
@synthesize responseHeaderTable = _responseHeaderTable;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)fetch:(id)sender {
    NSLog(@"Fetching %@->%@", [_url stringValue], [_method title]);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString:[_url stringValue]]];
    
    [request setHTTPMethod:[_method title]];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                  delegate:self];
    
    
    for (id item in [_requestHeaderController content]) {
        NSLog(@"%@", item);
    }
    
    [connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        //[_responseHeaderTable beginUpdates];
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        NSDictionary* allHeaders = [httpResponse allHeaderFields];
        NSMutableArray* responseHeaders = [[NSMutableArray alloc] init];
        for (NSString* header in allHeaders) {
            NSMutableDictionary* entry = [[NSMutableDictionary alloc] init];
            [entry setValue:[NSString stringWithFormat:@"%@", header]
                     forKey:@"header"];
            [entry setValue:[allHeaders valueForKey:header]
                     forKey:@"value"];
            [responseHeaders addObject:entry];
            NSLog(@"%@", entry);
        }
        //[_responseHeaderTable endUpdates];
        [_responseHeaderController setContent:responseHeaders];
        [_responseHeaderTable reloadData];
       
    }
    //NSLog(@"didReceiveRespone %@", response);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSString *stringData = [[NSString alloc] initWithData:data
                                                encoding:NSUTF8StringEncoding];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:stringData];
    //NSLog(@"didReceiveData %@", stringData);
    NSTextStorage* storage = [_responseData textStorage];
    [storage beginEditing];
    [storage appendAttributedString:attributedString];
    [storage endEditing];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //NSLog(@"didFinishLoading");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //NSLog(@"didFailWithError %@", error);
}

@end
