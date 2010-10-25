//
//  NSArray+Util.m
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/22.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NSArray+Util.h"


@implementation NSArray (NSArray_Util)

- (BOOL) isEmpty {
	if (self == nil) return YES;
	return (BOOL)([self count] == 0);
}

@end
