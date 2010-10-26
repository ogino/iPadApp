//
//  AlertUtil.m
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AlertUtil.h"


@implementation AlertUtil

+ (void)showAlert:(NSString*)title message:(NSString*)message delegate:(id)delegate {
#ifndef UNIT_TEST
	UIAlertView* alertView = [[[UIAlertView alloc] initWithTitle:title message:message
														delegate:delegate
											   cancelButtonTitle:nil
											   otherButtonTitles:NSLocalizedString(@"OK", nil), nil] autorelease];
	[alertView show];
#endif
}

+ (void)showAlert:(NSString*)title message:(NSString*)message delegate:(id)delegate cancelButtonTitle:(NSString*)cancel otherButtonTitles:(NSString*)otherButton {
#ifndef UNIT_TEST
	UIAlertView* alertView = [[[UIAlertView alloc] initWithTitle: title message: message delegate: delegate
											   cancelButtonTitle: cancel otherButtonTitles: otherButton, nil] autorelease];
	[alertView show];
#endif
}


@end
