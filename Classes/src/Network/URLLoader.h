//
//  URLLoader.h
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "define.h"
#import "AlertUtil.h"
#import "URLConnection.h"
#import "NSData+Util.h"
#import "NSString+Util.h"


@interface URLLoader : NSObject {
@private
	URLConnection* connection_;
	NSMutableData* data_;
}

@property (nonatomic, retain) URLConnection* connection;
@property (nonatomic, retain) NSMutableData* data;

- (id)initWithTimeoutInterval:(NSTimeInterval)timeoutInterval;

- (NSData*)request:(NSURL*)url;

- (NSData*)request:(NSURL*)url get:(NSString*)get;

- (NSData*)request:(NSURL*)url post:(NSString*)post;

- (NSData*)request:(NSURL*)url header:(NSString*)header headerField:(NSString*)headerField get:(NSString*)get;

- (NSData*)request:(NSURL*)url header:(NSString*)header headerField:(NSString*)headerField post:(NSString*)post;

- (NSData*)request:(NSURL*)url method:(NSString*)method header:(NSString*)header headerField:(NSString*)headerField body:(NSData*)body;

- (NSData*)request:(NSURL*)url timeoutInterval:(NSTimeInterval)timeoutInterval;

- (NSData*)request:(NSURL*)url get:(NSString*)get timeoutInterval:(NSTimeInterval)timeoutInterval;

- (NSData*)request:(NSURL*)url post:(NSString*)post timeoutInterval:(NSTimeInterval)timeoutInterval;

- (NSData*)request:(NSURL*)url header:(NSString*)header headerField:(NSString*)headerField get:(NSString*)get timeoutInterval:(NSTimeInterval)timeoutInterval;

- (NSData*)request:(NSURL*)url header:(NSString*)header headerField:(NSString*)headerField post:(NSString*)post timeoutInterval:(NSTimeInterval)timeoutInterval;

- (NSData*)request:(NSURL*)url method:(NSString*)method header:(NSString*)header headerField:(NSString*)headerField body:(NSData*)body timeoutInterval:(NSTimeInterval)timeoutInterval;

@end
