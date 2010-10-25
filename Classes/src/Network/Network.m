//
//  Network.m
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Network.h"


@implementation Network

- (NSURL*) createGETURL:(NSURL*) url get:(NSString*) get {
	NSString* urlStr = [url absoluteString];
	NSString* encGET = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)get, NULL, CFSTR(";,/?:@&=+$#"), kCFStringEncodingUTF8);
	NSString* reqURLStr = [NSString stringWithFormat:@"%@?%@", urlStr, encGET];
	return [NSURL URLWithString:reqURLStr];
}

- (NSData*) sendRequest:(NSMutableURLRequest*) request {

#ifndef UNIT_TEST
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
#endif

	NSHTTPURLResponse* response = nil;
	NSError* error = nil;
	NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

	if (error) {
		NSLog(@"Error :[%@]. Description is %@, Reason is %@", error, [error localizedDescription], [error localizedFailureReason]);
		@throw error;
	}
	if ([response statusCode] >= 400u) {
		NSLog(@"Your status code [%d] is error response!", [response statusCode]);
	}

#ifndef UNIT_TEST
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
#endif

	return data;

}

- (NSData*)request:(NSURL*) url {
	return [self sendRequest:[NSMutableURLRequest requestWithURL:url]];
}

- (NSData*)request:(NSURL*) url get:(NSString*) get {
	NSURL* requstURL = [self createGETURL:url get:get];
	return [self request:requstURL];
}

- (NSData*)request:(NSURL *)url post:(NSString*) post {
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];

	return [self sendRequest:request];
}

- (void)dealloc {
	[super dealloc];
}

@end
