//
//  PublicTLViewController.m
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PublicTLViewController.h"


@implementation PublicTLViewController

@synthesize loaded = loaded_;
@synthesize timeLine = timeLine_;
@synthesize tweets = tweets_;

static NSString* const PUBLIC_TIMELINE = @"http://api.twitter.com/1/statuses/public_timeline.json";
static NSString* const PTNOFIFY = @"PUBLIC TIMELINE NOTIFICATION";

#pragma mark -
#pragma mark Private Methods

- (void)refleshTable {
	[self.tableView reloadData];
}

- (void)requestTimeLine {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	self.tweets = (NSArray*)[self.timeLine createData];
	self.loaded = YES;
	[[NSNotificationCenter defaultCenter] postNotificationName:PTNOFIFY object:nil];
	[pool release];
}

- (void)fetchedTimeLine:(NSNotification*) notification {
	[self performSelectorOnMainThread:@selector(refleshTable) withObject:nil waitUntilDone:YES];
}

- (UIImage*)adjustImage:(UIImage*)image {
	CGRect rect = CGRectMake(0, 0, 80, 80);

	UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
	
	[image drawInRect:rect];
	
	UIImage* shrinkedImage = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return shrinkedImage;
}

- (UIImage*)createImage:(NSString*)urlStr {
	NSURL* url = [NSURL URLWithString:urlStr];
	NSData* data = [NSData dataWithContentsOfURL:url];
	UIImage* image = [UIImage imageWithData:data];
	return [image shrinkImage:CGRectMake(0, 0, 80, 80)];
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

	self.title = @"ついったぁ";
	self.loaded = NO;
	self.timeLine = [[[TimeLine alloc] init] autorelease];
	self.timeLine.url = PUBLIC_TIMELINE;

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchedTimeLine:) name:PTNOFIFY object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	if (!self.loaded)
		[self performSelectorInBackground:@selector(requestTimeLine) withObject:nil];
	else
		[self refleshTable];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return ([self.tweets isEmpty]) ? 0 : 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return ([self.tweets isEmpty]) ? 0 : [self.tweets count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }

	if (![self.tweets isEmpty]) {
		NSDictionary* tweet = [self.tweets objectAtIndex:indexPath.row];
		cell.detailTextLabel.text = (NSString*)[tweet objectForKey:@"text"];
		cell.detailTextLabel.numberOfLines = 0;
		cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
		NSDictionary* user = [tweet objectForKey:@"user"];
		cell.imageView.image = [self createImage:(NSString*)[user objectForKey:@"profile_image_url"]];
		cell.textLabel.text = (NSString*)[user objectForKey:@"name"];
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.lineBreakMode = UILineBreakModeCharacterWrap;
	}

    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	NSLog(@"Move");
}


// Override to support conditional rearranging of the table view.
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
	self.tweets = nil;
    [super dealloc];
}


@end

