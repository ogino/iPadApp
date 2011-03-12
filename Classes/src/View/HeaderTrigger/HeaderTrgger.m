//
//  HeaderTrgger.m
//  iPadApp
//
//  Created by 荻野 雅 on 11/01/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HeaderTrgger.h"


@implementation HeaderTrgger

@synthesize label = label_;
@synthesize indicator = indicator_;

#define LABEL_WIDTH 500
#define LABEL_HEIGHT 80
#define BEFORE_LOAD NSLocalizedString(@"refresh", @"")

- (void)createLabel {
	self.label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, LABEL_WIDTH, LABEL_HEIGHT)] autorelease];
	self.label.backgroundColor = [UIColor clearColor];
	self.label.textColor = [UIColor whiteColor];
	self.label.text = BEFORE_LOAD;
	self.label.numberOfLines = 0;
	self.label.lineBreakMode = UILineBreakModeWordWrap;
	self.label.textAlignment = UITextAlignmentCenter;
}

- (void) createIndicator {
	self.indicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
	[self.indicator startAnimating];
}

#pragma mark -
#pragma mark Inherit Methods

#define HALF_WIDTH (self.frame.size.width / 2)
#define HALF_HEIGHT (self.frame.size.height / 2)
#define LABEL_Y_CENTER (self.frame.size.height - (80 / 2))

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		[self createLabel];
		[self createIndicator];
		self.label.center = CGPointMake(HALF_WIDTH, LABEL_Y_CENTER);
		self.indicator.center = CGPointMake(self.label.frame.origin.x - (self.indicator.frame.size.width / 2), self.label.center.y);
		[self addSubview:self.label];
		[self addSubview:self.indicator];
		self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame text:(NSString*)text {
    if (self = [self initWithFrame:frame]) {
		self.label.text = text;
    }
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)labelText:(NSString*)text {
	self.label.text = text;
}

- (void)restoreText {
	self.label.text = BEFORE_LOAD;
}

- (void)visible:(BOOL)visible {
	self.label.hidden = !visible;
	if (visible) [self.indicator startAnimating];
	else [self.indicator stopAnimating];
}

- (void)dealloc {
	self.label = nil;
	self.indicator = nil;
    [super dealloc];
}


@end
