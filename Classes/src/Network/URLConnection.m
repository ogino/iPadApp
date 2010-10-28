//
//  URLConnection.m
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "URLConnection.h"


@implementation URLConnection

@synthesize connection = connection_;
@synthesize data = data_;
@synthesize done = done_;

- (void)completeRequest: (NSNotification *)notification {
	self.done = YES;
}

- (void)abortRequest: (NSNotification *)notification {
    [AlertUtil showAlert:@"通信エラー" message:@"通信がタイムアウトし、データ取得に失敗しました。" delegate:nil];
	self.done = YES;
	self.data = nil;
}

- (void)asynchronousRequest:(NSURLRequest *)request {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
	[[NSRunLoop currentRunLoop] run];
	[pool release];
}

- (id)init {
	if (self = [super init]) {
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(completeRequest:) name:CON_SUCCESS object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(abortRequest:) name:CON_FAIL object:nil];
		self.done = NO;
	}
	return self;
}

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
	NSLog(@"Error: code is \"%d\", domain is \"%@\", description is \"%@\"", [error code], [error domain], [error localizedDescription]);
//	NSLog(@"Error: code is %d", [error code]);
//	NSLog(@"Error: domain is %@", [error domain]);
//	NSLog(@"Error: description is %@", [error localizedDescription]);
    [[NSNotificationCenter defaultCenter] postNotificationName:CON_FAIL object: self];
}

- (void) createConnection:(NSURLRequest *)request {
	[self performSelectorInBackground:@selector(asynchronousRequest:) withObject:request];
	
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:CON_SUCCESS object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:CON_FAIL object:nil];
	self.connection = nil;
	self.data = nil;
	[super dealloc];
}

@end
