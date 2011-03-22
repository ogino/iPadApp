//
//  TimeLineViewController.m
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TimeLineViewController.h"
#import "TweetViewController.h"


@implementation TimeLineViewController

@synthesize loaded = loaded_;
@synthesize triggered = triggered_;
@synthesize timeLine = timeLine_;
@synthesize url = url_;
@synthesize userId = userId_;
@synthesize password = password_;
@synthesize tweets = tweets_;
@synthesize trigger = trigger_;
@synthesize images = images_;
@synthesize popOverController = popOverController_;

#pragma mark -
#pragma mark Private Methods

#define HEADER_SIZE 400

- (void)createTrigerHeader {
	CGRect rect = self.tableView.bounds;
	rect.origin.y -= HEADER_SIZE;
	rect.size.height = HEADER_SIZE;
	self.trigger = [[[HeaderTrgger alloc] initWithFrame:rect] autorelease];
	[self.tableView addSubview:self.trigger];
}

#define HEADER_HEIGHT 80 

- (void)createTableHeader {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	if (!self.tableView.tableHeaderView) {
		CGRect rect = self.tableView.bounds;
		rect.origin.y -= HEADER_HEIGHT;
		rect.size.height = HEADER_HEIGHT;
		HeaderTrgger* tableHeader = [[[HeaderTrgger alloc] initWithFrame:rect text:NSLocalizedString(@"loading", @"")] autorelease];
		self.tableView.tableHeaderView = tableHeader;
	}
	[pool release];
}

#define ADJUST_SIZE 80

- (UIImage*)createImage:(NSString*)urlStr {
	NSURL* url = [NSURL URLWithString:urlStr];
	URLLoader* urlLoader = [[[URLLoader alloc] init] autorelease];
	NSData* data = [urlLoader request:url];
	UIImage* image = [UIImage imageWithData:data];
	if (!image) image = [UIImage imageNamed:@"noimage"];
	return [image shrinkImage:CGRectMake(0, 0, ADJUST_SIZE, ADJUST_SIZE)];
}

- (void)createUserImage:(NSArray*)tweets {
	[self.images removeAllObjects];
	for (NSMutableDictionary* tweet in tweets) {
		NSMutableDictionary* user = [tweet objectForKey:@"user"];
		UIImage* image = [self createImage:(NSString*)[user objectForKey:@"profile_image_url"]];
		[self.images addObject:image];
	}
}

- (void)refreshTable {
	[tweetBuff addObjectsFromArray:self.tweets];
	[self createUserImage:tweetBuff];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	self.tableView.tableHeaderView = nil;
	[self.trigger restoreText];
	[self.trigger visible:YES];
	self.tweets = tweetBuff, tweetBuff = nil;
	self.loaded = YES;
	self.triggered = NO;
	[self.tableView reloadData];
}

- (void)requestTimeLine {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	tweetBuff = (NSMutableArray*)[self.timeLine createData];
	[tweetBuff retain];
	[[NSNotificationCenter defaultCenter] postNotificationName:TIMELINE_NOFIFY object:nil];
	[pool release];
}

- (void)fetchedTimeLine:(NSNotification*) notification {
	[self performSelectorOnMainThread:@selector(refreshTable) withObject:nil waitUntilDone:YES];
}

#define POPOVER_SIZE CGSizeMake(640u, 480u)

- (void)showTweetView:(id)sender {
	if (self.popOverController.popoverVisible) {
		[self.popOverController dismissPopoverAnimated:YES];
		return;
	}
	TweetViewController* viewController = [[[TweetViewController alloc] init] autorelease];
	UINavigationController* navigationController = [[[UINavigationController alloc] initWithRootViewController:viewController] autorelease];
	self.popOverController = [[[UIPopoverController alloc] initWithContentViewController:navigationController] autorelease];
	self.popOverController.delegate = self;
	self.popOverController.popoverContentSize = POPOVER_SIZE;
	[self.popOverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(showTweetView:)];
	
	self.tweets = [NSMutableArray array];
	self.images = [NSMutableArray array];
	self.loaded = NO;
	self.timeLine = [[[TimeLine alloc] init:self.url userId:self.userId password:self.password] autorelease];
	self.triggered = NO;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchedTimeLine:) name:TIMELINE_NOFIFY object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self createTrigerHeader];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	if (!self.loaded)
		[self performSelectorInBackground:@selector(requestTimeLine) withObject:nil];
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

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[self.trigger removeFromSuperview];
	self.tableView.tableHeaderView = nil;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[self createTrigerHeader];
	if (self.triggered) [self createTableHeader];
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return ([NSArray isEmpty:self.tweets]) ? 0 : 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ([NSArray isEmpty:self.tweets]) ? 0 : [self.tweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *identifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
	cell.backgroundColor = [UIColor whiteColor];
	if (![NSArray isEmpty:self.tweets] && self.tweets.count > indexPath.row && self.loaded) {
		NSDictionary* tweet = [self.tweets objectAtIndex:indexPath.row];
		cell.detailTextLabel.text = (NSString*)[tweet objectForKey:@"text"];
		cell.detailTextLabel.numberOfLines = 0;
		cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
		NSDictionary* user = [tweet objectForKey:@"user"];
		cell.imageView.image = (self.images != nil && [self.images count] > indexPath.row) ? [self.images objectAtIndex:indexPath.row] : nil;
		cell.textLabel.text = (NSString*)[user objectForKey:@"name"];
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.lineBreakMode = UILineBreakModeCharacterWrap;
	}
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	NSLog(@"Move");
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


#pragma mark -
#pragma mark Table view controller data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80.0;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#define ZERO_POINT 0
#define TRIGGER_TOGGLE -(self.tableView.frame.size.height / 6)

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
	CGRect rect = scrollView.bounds;
	if (self.triggered) {
		[self.trigger visible:NO];
		return;
	}
	
	if (rect.origin.y < TRIGGER_TOGGLE) {
		[self.trigger labelText:NSLocalizedString(@"loading", @"")];
	} else if (rect.origin.y >= TRIGGER_TOGGLE && rect.origin.y < ZERO_POINT && !self.triggered) {
		[self.trigger restoreText];
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate {
	if (self.triggered) return;
	CGRect rect = scrollView.bounds;
	if (rect.origin.y < TRIGGER_TOGGLE) {
		self.triggered = YES;
		[self createTableHeader];		
		[self performSelectorInBackground:@selector(requestTimeLine) withObject:nil];
	} else {
		self.triggered = NO;
		self.tableView.tableHeaderView = nil;
		[self.trigger visible:YES];
	}
	
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	[super viewDidUnload];
}


- (void)dealloc {
	self.timeLine = nil;
	self.url = nil;
	self.userId = nil;
	self.password = nil;
	self.tweets = nil;
	self.trigger = nil;
	self.images = nil;
	self.popOverController = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark PopoverController delegate

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
	return YES;
}
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
}


@end

