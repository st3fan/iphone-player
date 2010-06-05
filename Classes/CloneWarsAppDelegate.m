// CloneWarsAppDelegate.m

#import "CloneWarsAppDelegate.h"
#import "ShowsViewController.h"

@implementation CloneWarsAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	self.viewController.navigationBar.barStyle = UIBarStyleBlack;
	self.viewController.toolbar.barStyle = UIBarStyleBlack;
	
	ShowsViewController* showsViewController = [[[ShowsViewController alloc] initWithNibName: @"ShowsViewController" bundle: nil] autorelease];
	if (showsViewController != nil) {
		[self.viewController pushViewController: showsViewController animated: NO];
	}
	
	return YES;
}

- (void) dealloc
{
    [viewController release];
    [window release];
    [super dealloc];
}

@end