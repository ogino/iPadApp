//
//  NSString+Util.m
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/28.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NSString+Util.h"


@implementation NSString (NSString_Util)

- (BOOL)isEmpty {
	if (self == nil) return YES;
	return (BOOL)([self length] == 0);
}

+ (NSString*)encodeUTF8:(NSString*)source {
	return (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)source, NULL, CFSTR(";,/?:@&=+$#"), kCFStringEncodingUTF8);
}

@end
