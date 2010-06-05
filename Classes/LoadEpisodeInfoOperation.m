// LoadEpisodeInfoOperation.m

#import "Show.h"
#import "Episode.h"
#import "LoadEpisodeInfoOperation.h"
#import "ObjectCache.h"

@implementation LoadEpisodeInfoOperation

- (id) initWithEpisode: (Episode*) episode
{
	if ((self = [super init]) != nil) {
		episode_ = [episode retain];
		data_ = [NSMutableData new];
	}
	return self;
}

- (void) dealloc
{
	[episode_ release];
	[super dealloc];
}

#pragma mark -

- (void) start
{
	if (![self isCancelled])
	{
		NSString* url = [NSString stringWithFormat:
			@"http://services.tvrage.com/tools/quickinfo.php?show=%@&ep=%dx%d",
				episode_.show.identifier, episode_.season, episode_.episode];
	
		NSLog(@"URL is %@", url);
	
		connection_ = [[NSURLConnection connectionWithRequest: [NSURLRequest requestWithURL: [NSURL URLWithString: url]] delegate: self] retain];

		if (connection_ != nil) {
			[self willChangeValueForKey:@"isExecuting"];
			executing_ = YES;
			[self didChangeValueForKey:@"isExecuting"];
		} else {
			[self willChangeValueForKey:@"isExecuting"];
			finished_ = YES;
			[self didChangeValueForKey:@"isExecuting"];
		}
	}
	else
	{
		// If it's already been cancelled, mark the operation as finished.
		[self willChangeValueForKey:@"isFinished"];
		{
			finished_ = YES;
		}
		[self didChangeValueForKey:@"isFinished"];
	}
}

- (BOOL) isConcurrent
{
	return YES;
}

- (BOOL) isExecuting
{
	return executing_;
}

- (BOOL) isFinished
{
  return finished_;
}

#pragma mark NSURLConnection Delegate Methods

- (void) connection: (NSURLConnection*) connection didReceiveData: (NSData*) data
{
	[data_ appendData: data];
}

- (void)connection: (NSURLConnection*) connection didReceiveResponse: (NSHTTPURLResponse*) response
{
	statusCode_ = [response statusCode];
}

- (void) connection: (NSURLConnection*) connection didFailWithError: (NSError*) error
{
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
	{
		finished_ = YES;
		executing_ = NO;
	}
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];	

	//[delegate_ loadImageDataOperationDidFail: self];
}

- (void) connectionDidFinishLoading: (NSURLConnection*) connection
{
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
	{
		finished_ = YES;
		executing_ = NO;
	}
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];	
	
	if (statusCode_ == 200) {
		NSLog(@"Yay! Got episode info!");
		//[delegate_ loadImageDataOperationDidFinish: self];
		
		NSString* string = [[[NSString alloc] initWithData: data_ encoding: NSUTF8StringEncoding] autorelease];
		if (string != nil) {
			NSLog(@"%@", string);
		}
		
		NSArray* lines = [string componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
		for (NSString* line in lines)
		{
			if ([line hasPrefix: @"Episode Info@"])
			{
				NSArray* components = [string componentsSeparatedByString: @"^"];
				episode_.name = [components objectAtIndex: 1];
				
				[[ObjectCache sharedObjectCache] cacheObject: episode_.name withType: @"ShowName" name: episode_.path];
			}
		}
		
	} else {
		//[delegate_ loadImageDataOperationDidFail: self];
	}
}

@end
