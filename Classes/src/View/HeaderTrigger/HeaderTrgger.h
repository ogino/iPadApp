//
//  HeaderTrgger.h
//  iPadApp
//
//  Created by 荻野 雅 on 11/01/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HeaderTrgger : UIView {
@private
	UILabel* label_;
	UIActivityIndicatorView* indicator_;
}

@property (nonatomic, retain) UILabel* label;
@property (nonatomic, retain) UIActivityIndicatorView* indicator;

@end