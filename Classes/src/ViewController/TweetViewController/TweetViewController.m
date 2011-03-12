    //
//  TweetViewController.m
//  iPadApp
//
//  Created by 荻野 雅 on 11/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TweetViewController.h"


@implementation TweetViewController

@synthesize textView = textView_;

#pragma mark -
#pragma mark Private Methods

- (void)sendTweet {
	NSLog(@"%@: Tweet Now!", [NSDate date]);
}


#pragma mark -
#pragma mark Inherit Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)loadView {
	[super loadView];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	self.navigationItem.rightBarButtonItem =
	[[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"send", @"") style:UIBarButtonItemStylePlain target:self action:@selector(sendTweet)] autorelease];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	self.textView = nil;
    [super dealloc];
}


@end
