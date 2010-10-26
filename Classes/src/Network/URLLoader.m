//
//  URLLoader.m
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "URLLoader.h"


@implementation URLLoader

//@synthesize connection = connection_;
@synthesize data = data_;
@synthesize done = done_;

- (id)init {
	if (self = [super init]) {
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(completeRequest:) name:CON_SUCCESS object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(abortRequest:) name:CON_FAIL object:nil];
		//self.connection = [[[URLConnection alloc] init] autorelease];
		self.done = NO;
	}
	return self;
}

- (void)completeRequest: (NSNotification *)notification {
	self.done = YES;
	//self.data = self.connection.data;

#ifndef UNIT_TEST
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
#endif
}

- (void)abortRequest: (NSNotification *)notification {
    [AlertUtil showAlert:@"通信エラー" message:@"通信がタイムアウトし、データ取得に失敗しました。" delegate:nil];
	self.done = YES;
	self.data = nil;

#ifndef UNIT_TEST
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
#endif
}

- (NSURL*)createGETURL:(NSURL*) url get:(NSString*) get {
	NSString* urlStr = [url absoluteString];
	NSString* encGET = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)get, NULL, CFSTR(";,/?:@&=+$#"), kCFStringEncodingUTF8);
	NSString* reqURLStr = [NSString stringWithFormat:@"%@?%@", urlStr, encGET];
	return [NSURL URLWithString:reqURLStr];
}

- (void)sendRequest:(NSMutableURLRequest*) request {

#ifndef UNIT_TEST
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
#endif

	//[self.connection createConnection:request];
	[NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)request:(NSURL*) url {
	[self sendRequest:[NSMutableURLRequest requestWithURL:url]];
}

- (void)request:(NSURL*) url get:(NSString*) get {
	NSURL* requstURL = [self createGETURL:url get:get];
	[self request:requstURL];
}

- (void)request:(NSURL *)url post:(NSString*) post {
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
	[self sendRequest:request];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	self.data = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)receiveData {
    [self.data appendData:receiveData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [[NSNotificationCenter defaultCenter] postNotificationName:CON_SUCCESS object: self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"Error: code is %@, description is %@", [error code], [error description]);
    [[NSNotificationCenter defaultCenter] postNotificationName:CON_FAIL object: self];
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:CON_SUCCESS object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:CON_FAIL object:nil];
//	self.connection = nil;
	self.data = nil;
	[super dealloc];
}

@end
