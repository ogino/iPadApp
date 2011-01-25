//
//  RootViewController.m
//  iPadApp
//
//  Created by 荻野 雅 on 10/12/07.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "AppDelegate.h"


@implementation RootViewController

@synthesize tabBarController = tabBarController_;


#define ROOTVIEW_PREPARED @"ROOT VIEW PREPARED"


#pragma mark -
#pragma mark Privated Methods

- (void)proceedMainView {
	[self.view removeFromSuperview];
	UIWindow* window = [(AppDelegate*)[[UIApplication sharedApplication] delegate] window];
	[window addSubview:self.tabBarController.view];
}

- (void)prepared:(NSNotification*)notifination {
	[self performSelectorOnMainThread:@selector(proceedMainView) withObject:nil waitUntilDone:YES];
}

- (void)createTabBarController {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	self.tabBarController = [[[TabBarController alloc] init] autorelease];
	[[NSNotificationCenter defaultCenter] postNotificationName:ROOTVIEW_PREPARED object:nil];
	[pool release];
}

#pragma mark -
#pragma mark Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


#pragma mark -
#pragma mark View lifecycle

- (void)loadView {
	self.view = [[[UIView alloc] init] autorelease];
	self.view.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.5];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(prepared:) name:ROOTVIEW_PREPARED object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Root View Controller";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	[self performSelectorInBackground:@selector(createTabBarController) withObject:nil];
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

- (void)dealloc {
	self.tabBarController = nil;
	[super dealloc];
}

@end
