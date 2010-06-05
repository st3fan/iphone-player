//  ShowsViewController.m

#import "Show.h"
#import "ShowView.h"
#import "ShowDatabase.h"
#import "EpisodesViewController.h"
#import "ShowsViewController.h"
#import "AllShowsTableViewController.h"

@implementation ShowsViewController

@synthesize scrollView = scrollView_;

- (CGRect) frameForCellAtIndex: (NSUInteger) index
{
	NSUInteger columns_ = self.view.bounds.size.width / (227 + 13.5);
	CGFloat cellPadding_ = 13.5;
	CGSize cellSize_ = CGSizeMake(227, 227);

	return CGRectMake(
		cellPadding_ + (index % columns_) * (cellSize_.width + 2 * cellPadding_),
		cellPadding_ + (index / columns_) * (cellSize_.height + 2 * cellPadding_),
		cellSize_.width,
		cellSize_.height
	);
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

- (void) handleSelectShowGesture: (UIGestureRecognizer*) gestureRecognizer
{
	ShowView* showView = (ShowView*) gestureRecognizer.view;
	if (showView != nil)
	{
		EpisodesViewController* episodesViewController = [[[EpisodesViewController alloc] initWithNibName: @"EpisodesViewController" bundle: nil] autorelease];
		if (episodesViewController != nil) {
			episodesViewController.show = showView.show;
			[self.navigationController pushViewController: episodesViewController animated: YES];
		}
	}
}

- (void) showAll
{
	AllShowsTableViewController* vc = [[[AllShowsTableViewController alloc] initWithNibName: nil bundle: nil] autorelease];
	if (vc != nil) {
		[self.navigationController pushViewController: vc animated: YES];
	}
}

- (void) viewDidLoad
{
	[super viewDidLoad];

	self.title = @"Shows";
	
	[[ShowDatabase sharedShowDatabase] refresh];
	NSArray* shows = [[ShowDatabase sharedShowDatabase] shows];
	
	for (NSUInteger i = 0; i < [shows count]; i++)
	{
		Show* show = [shows objectAtIndex: i];
				
		ShowView* showView = [[[ShowView alloc] initWithFrame: [self frameForCellAtIndex: i]] autorelease];
		if (showView != nil)
		{
			showView.show = show;
		
			UITapGestureRecognizer* gestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleSelectShowGesture:)] autorelease];
			if (gestureRecognizer != nil) {
				[showView addGestureRecognizer: gestureRecognizer];
			}
			
			[scrollView_ addSubview: showView];
		}
	}
	
	//
	
	UIBarButtonItem* button = [[[UIBarButtonItem alloc] initWithTitle: @"All" style: UIBarButtonItemStylePlain target: self action: @selector(showAll)] autorelease];
	self.navigationItem.rightBarButtonItem = button;
	
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
//	[UIView beginAnimations: nil context: nil];
//	{
//		[UIView setAnimationDuration: 0.125];
	
		for (NSUInteger i = 0; i < [scrollView_.subviews count]; i++) {
			UIView* view = [scrollView_.subviews objectAtIndex: i];
			view.frame = [self frameForCellAtIndex: i];
		}

		scrollView_.contentSize = scrollView_.frame.size;
//	}
//	[UIView commitAnimations];
}

@end
