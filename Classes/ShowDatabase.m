// ShowDatabase.m

#import "RegexKitLite.h"

#import "Episode.h"
#import "Show.h"
#import "LoadEpisodeInfoOperation.h"
#import "ShowDatabase.h"
#import "ObjectCache.h"

@implementation ShowDatabase

+ (id) sharedShowDatabase
{
	static ShowDatabase* showDatabaseSingleton = nil;
	
	@synchronized (self) {
		if (showDatabaseSingleton == nil) {
			showDatabaseSingleton = [self new];
		}
	}
	
	return showDatabaseSingleton;
}

- (id) init
{
	if ((self = [super init]) != nil) {
		shows_ = [NSMutableDictionary new];
		operationQueue_ = [NSOperationQueue new];
		[operationQueue_ setMaxConcurrentOperationCount: 2];
	}
	return self;
}

- (void) dealloc
{
	[operationQueue_ release];
	[shows_ release];
	[super dealloc];
}

#pragma mark -

- (void) refresh
{
	NSDictionary* showDescriptors = [NSDictionary dictionaryWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"ShowDescriptors" ofType: @"plist"]];

	NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSArray* files = [[NSFileManager defaultManager] directoryContentsAtPath: documentsDirectory];
	
	for (NSString* file in files)
	{
		NSLog(@"%@", file);
	
		NSString* expression = @"^((?:\\w+)(?:\\.\\w+)*)\\.s(\\d\\d)e(\\d\\d)\\.(\\w+)$";
		
		if ([file isMatchedByRegex: expression])
		{
			NSString* identifier = [file stringByMatching: expression capture: 1];
			NSString* seasonNumber = [file stringByMatching: expression capture: 2];
			NSString* episodeNumber = [file stringByMatching: expression capture: 3];
			//NSString* type = [file stringByMatching: expression capture: 4];
			
			Show* show = [self showByIdentifier: identifier];
			if (show == nil)
			{
				NSDictionary* showDescriptor = [showDescriptors objectForKey: identifier];
				if (showDescriptor != nil)
				{
					show = [[Show new] autorelease];

					show.identifier = identifier;
					show.name = [showDescriptor objectForKey: @"Name"];
					show.largeImageName = [showDescriptor objectForKey: @"LargeImage"];
					
					[shows_ setObject: show forKey: identifier];
				}
			}
			
			if (show != nil)
			{
				Episode* episode = [[Episode new] autorelease];
				episode.season = [seasonNumber integerValue];
				episode.episode = [episodeNumber integerValue];
				episode.path = file;
				episode.show = show;
				
				[show.episodes addObject: episode];

				episode.name = [[ObjectCache sharedObjectCache] cachedObjectOfType: @"ShowName" name: episode.path];
				if (episode.name == nil)
				{
					NSLog(@"Pushing queue task for %@", episode.path);
					
					LoadEpisodeInfoOperation* operation = [[[LoadEpisodeInfoOperation alloc] initWithEpisode: episode] autorelease];
					if (operation != nil) {
						[operationQueue_ addOperation: operation];
					}
				}
			}
		}
		
		NSString* expression2 = @"^((?:\\w+)(?:\\.\\w+)*)\\.(\\d\\d\\d\\d)\\.(\\d\\d)\\.(\\d\\d)\\.(\\w+)$";

		if ([file isMatchedByRegex: expression2])
		{
			NSString* identifier = [file stringByMatching: expression2 capture: 1];
			NSString* year = [file stringByMatching: expression2 capture: 2];
			NSString* month = [file stringByMatching: expression2 capture: 3];
			NSString* day = [file stringByMatching: expression2 capture: 4];
			//NSString* type = [file stringByMatching: expression capture: 5];
			
			Show* show = [self showByIdentifier: identifier];
			if (show == nil)
			{
				NSDictionary* showDescriptor = [showDescriptors objectForKey: identifier];
				if (showDescriptor != nil)
				{
					show = [[Show new] autorelease];
					
					show.identifier = identifier;
					show.name = [showDescriptor objectForKey: @"Name"];
					show.largeImageName = [showDescriptor objectForKey: @"LargeImage"];
					
					[shows_ setObject: show forKey: identifier];
				}
			}
			
			if (show != nil)
			{
				Episode* episode = [[Episode new] autorelease];
				if (episode != nil)
				{
					NSDateFormatter* formatter = [[NSDateFormatter new] autorelease];
					[formatter setDateFormat:@"yyyy-MM-dd"];

					episode.date = [formatter dateFromString: [NSString stringWithFormat: @"%@-%@-%@", year, month, day]];				
					episode.path = file;
					episode.show = show;
					
					[show.episodes addObject: episode];
				}
			}
		}
	}
}

#pragma mark -

- (NSArray*) shows
{
	return [shows_ allValues];
}

- (Show*) showByIdentifier: (NSString*) identifier
{
	return [shows_ objectForKey: identifier];
}

@end
