// ShowsTableViewController.m

#import "ShowDatabase.h"
#import "ShowsTableViewController.h"
#import "MovieViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation ShowsTableViewController

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

- (void) viewDidLoad
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	ShowDatabase* database = [ShowDatabase sharedShowDatabase];
	[database refresh];
	
	files_ = [[[NSFileManager defaultManager] directoryContentsAtPath: documentsDirectory] retain];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [files_ count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	cell.textLabel.text = [files_ objectAtIndex: indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];

	NSString* path = [documentsDirectory stringByAppendingPathComponent: [files_ objectAtIndex: indexPath.row]];
	NSURL* theURL = [NSURL fileURLWithPath: path];
	
	MovieViewController* movieViewController = [[MovieViewController new] autorelease];
	if (movieViewController != nil) {
		movieViewController.url = theURL;
		[self presentModalViewController: movieViewController animated: YES];
	}

//    MPMoviePlayerViewController* moviePlayerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL: theURL];
//	if (moviePlayerViewController != nil)
//	{
//		moviePlayerViewController.wantsFullScreenLayout = YES;
//		moviePlayerViewController.moviePlayer.fullscreen = YES;
//
//		[self.view addSubview:moviePlayerViewController.view];
//		[moviePlayerViewController.moviePlayer play];
//
//		//[self presentMoviePlayerViewControllerAnimated: moviePlayerViewController];
//	}
}

@end
