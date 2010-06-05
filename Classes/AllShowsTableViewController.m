//  AllShowsTableViewController.m

#import "AllShowsTableViewController.h"
#import "ShowDatabase.h"
#import "MovieViewController.h"

@implementation AllShowsTableViewController

- (void) viewDidLoad
{
	self.title = @"All Shows";
	NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	files_ = [[[NSFileManager defaultManager] directoryContentsAtPath: documentsDirectory] retain];
}

- (void) dealloc
{
	[files_ release];
	[super dealloc];
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [files_ count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [files_ objectAtIndex: indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString* documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSURL* url = [NSURL fileURLWithPath: [documentsDirectory stringByAppendingPathComponent: [files_ objectAtIndex: indexPath.row]]];
	
	MovieViewController* movieViewController = [[MovieViewController new] autorelease];
	if (movieViewController != nil) {
		movieViewController.url = url;
		[self presentModalViewController: movieViewController animated: NO];
	}
	
	[tableView deselectRowAtIndexPath: indexPath animated: NO];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

@end

