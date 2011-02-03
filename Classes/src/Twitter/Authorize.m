//
//  Authorize.m
//  iPadApp
//
//  Created by 荻野 雅 on 11/02/02.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Authorize.h"
#import "NSArray+Util.h"
#import "NSString+Util.h"
#import "OAMutableURLRequest.h"
#import "OADataFetcher.h"
#import "OAServiceTicket.h"

@implementation Authorize

@synthesize consumer = consumer_;
@synthesize token = token_;
@synthesize userId = userId_;
@synthesize password = password_;

#pragma mark -
#pragma mark Definitions

#define CONSUMER_KEY @"4hYBQ1JJ7m05xC5wcKtA"
#define CONSUMER_SECRET @"5QsyXcfJaE9B0KEe2QV9d7xjUT3NlbIcaXvuf9LIs0Y"

#define REQUEST_API @"https://api.twitter.com/oauth/request_token"
#define ACCESS_TOKEN_API @"https://api.twitter.com/oauth/access_token"
#define AUTHORIZE_API @"https://api.twitter.com/oauth/authorize"

#define REGEX_TOKEN @"^oauth_token="
#define REGEX_TOKEN_SECRET @"^oauth_token_secret="

#pragma mark -
#pragma mark Private Methods

- (void)ticket:(OAServiceTicket*)ticket didFinishWithData:(NSData *)data {
    NSString *dataString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"data: %@", dataString);

}

- (void)ticket:(OAServiceTicket*)ticket didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
}


#pragma mark -
#pragma mark Public_Methods

- (id)initWithUserInfo:(NSString*)userId password:(NSString*)password {
	if (self = [self init]) {
		self.userId = userId;
		self.password = password;
	}
	return self;
}


#define GET_METHOD @"GET"

- (void)createOAuthKeys {
	OAMutableURLRequest* request =
	[[[OAMutableURLRequest alloc] initWithURL:[NSURL URLWithString:REQUEST_API] consumer:self.consumer token:self.token realm:nil signatureProvider:nil] autorelease];
	OADataFetcher* fetcher = [[[OADataFetcher alloc] init] autorelease];
	[fetcher fetchDataWithRequest:request delegate:self didFinishSelector:@selector(ticket:didFinishWithData:) didFailSelector:@selector(ticket:didFailWithError:)];
}


#pragma mark -
#pragma mark Inherit Methods

- (id)init {
	if (self = [super init]) {
		self.consumer = [[[OAConsumer alloc] initWithKey:CONSUMER_KEY secret:CONSUMER_SECRET] autorelease];
		self.token = nil;
	}
	return self;
}

- (void)dealloc {
	self.consumer = nil;
	self.token = nil;
	self.userId = nil;
	self.password = nil;
	[super dealloc];
}

@end
