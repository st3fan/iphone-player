//  EpisodesViewController.m

#import "MovieViewController.h"
#import "Show.h"
#import "Episode.h"
#import "EpisodeTableViewCell.h"
#import "EpisodesViewController.h"

@implementation EpisodesViewController

@synthesize showNameLabel = showNameLabel_;
@synthesize showImageView = showImageView_;
@synthesize tableView = tableView_;
@synthesize show = show_;

- (void) dealloc
{
	[show_ release];
	[super dealloc];
}

#pragma mark -

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	showNameLabel_.text = show_.name;
	showImageView_.image = [UIImage imageNamed: show_.largeImageName];

	tableView_.rowHeight = 68.0;
	[tableView_ reloadData];
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView: (UITableView*) tableView numberOfRowsInSection: (NSInteger) section
{
    return [show_.episodes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EpisodeTableViewCell";
    
    EpisodeTableViewCell *cell = (EpisodeTableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[EpisodeTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier] autorelease];
		cell.textLabel.font = [UIFont fontWithName: @"Trebuchet MS" size: 24.0];
		cell.textLabel.textColor = [UIColor whiteColor];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	Episode* episode = [show_.episodes objectAtIndex: indexPath.row];

	if (episode.date != nil) {
		NSDateFormatter* formatter = [[NSDateFormatter new] autorelease];
		[formatter setTimeStyle:NSDateFormatterNoStyle];
		[formatter setDateStyle:NSDateFormatterLongStyle];
		cell.textLabel.text = [formatter stringFromDate: episode.date];
	} else {
		cell.textLabel.text = [NSString stringWithFormat: @"Season %d Episode %d - %@", episode.season, episode.episode, episode.name];
	}
    
    return cell;
}

#pragma mark -

- (void) tableView: (UITableView*) tableView didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
	Episode* episode = [show_.episodes objectAtIndex: indexPath.row];

	NSString* documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSURL* url = [NSURL fileURLWithPath: [documentsDirectory stringByAppendingPathComponent: episode.path]];
	
	MovieViewController* movieViewController = [[MovieViewController new] autorelease];
	if (movieViewController != nil) {
		movieViewController.url = url;
		[self presentModalViewController: movieViewController animated: NO];
	}
	
	[tableView_ deselectRowAtIndexPath: indexPath animated: NO];
}

@end