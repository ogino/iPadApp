//
//  AlertUtil.h
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AlertUtil : NSObject {

}

+ (void)showAlert:(NSString*)title message:(NSString*)message delegate:(id)delegate;

+ (void)showAlert:(NSString*)title message:(NSString*)message delegate:(id)delegate cancelButtonTitle:(NSString*)cancel otherButtonTitles:(NSString*)otherButton;

@end
