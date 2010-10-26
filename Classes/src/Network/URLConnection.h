//
//  URLConnection.h
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "define.h"
#import "AlertUtil.h"


@interface URLConnection : NSObject {
@private
	NSURLConnection *connection_;
	NSMutableData	*data_;
	BOOL done_;
}

@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, assign) BOOL done;

- (void) createConnection:(NSURLRequest *)request;

@end
