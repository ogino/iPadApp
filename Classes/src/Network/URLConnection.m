//
//  URLConnection.m
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "URLConnection.h"


@implementation URLConnection

//@synthesize connection = connection_;
@synthesize data = data_;

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	self.data = [NSMutableData data];
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)receiveData {
    [self.data appendData:receiveData];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    [[NSNotificationCenter defaultCenter] postNotificationName:CON_SUCCESS object: self];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"Error: code is %@, description is %@", [error code], [error description]);
    [[NSNotificationCenter defaultCenter] postNotificationName:CON_FAIL object: self];
}

- (void) createConnection:(NSURLRequest *)request {
	[NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)dealloc {
//	self.connection = nil;
	self.data = nil;
	[super dealloc];
}

@end
