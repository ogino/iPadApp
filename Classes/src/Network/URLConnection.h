//
//  URLConnection.h
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "define.h"


@interface URLConnection : NSObject {
//	NSURLConnection *connection_;
	NSMutableData	*data_;
}

//@property(retain, nonatomic) NSURLConnection *connection;
@property(retain ,nonatomic) NSMutableData *data;

- (void) createConnection:(NSURLRequest *)request;

@end
