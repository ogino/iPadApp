//
//  AuthorizeTest.m
//  iPadApp
//
//  Created by 荻野 雅 on 11/02/03.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AuthorizeTest.h"


@implementation AuthorizeTest

- (void)setUp {
	authorize = [[Authorize alloc] init];
}

- (void)tearDown {
	[authorize release];
}

- (void)testCreateOAuthKeys {
	[authorize createOAuthKeys];
}

- (void)testAAAA {
}

@end
