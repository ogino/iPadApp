//
//  Authorize.h
//  iPadApp
//
//  Created by 荻野 雅 on 11/02/02.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLLoader.h"


@interface Authorize : NSObject {
@private
	NSString* userId_;
	NSString* password_;
	NSString* consumerKey_;
	NSString* consumerSecret_;
	NSString* requestKey_;
	NSString* requestSecret_;
	NSString* pinCode_;
	NSString* accessKey_;
	NSString* accessSecret_;
	URLLoader* urlLoader_;
}

@property (nonatomic, copy) NSString* userId;
@property (nonatomic, copy) NSString* password;
@property (nonatomic, copy) NSString* consumerKey;
@property (nonatomic, copy) NSString* consumerSecret;
@property (nonatomic, copy) NSString* requestKey;
@property (nonatomic, copy) NSString* requestSecret;
@property (nonatomic, copy) NSString* pinCode;
@property (nonatomic, copy) NSString* accessKey;
@property (nonatomic, copy) NSString* accessSecret;
@property (nonatomic, retain) URLLoader* urlLoader;

- (id)initWithUserInfo:(NSString*)userId password:(NSString*)password;
- (void)createOAuthRequestKeys;
- (void)createOAuthAccessKeys;
- (NSString*)createAuthorizeHeader:(NSURL*)url method:(NSString*)method body:(NSData*)body;

@end
