// ObjectCache.m

#import "ObjectCache.h"

@implementation ObjectCache

+ (id) sharedObjectCache
{
	static ObjectCache* objectCacheSingleton = nil;
	
	if (objectCacheSingleton == nil) {
		objectCacheSingleton = [self new];
	}

	return objectCacheSingleton;
}

- (id) init
{
	if ((self = [super init]) != nil) {
		NSString* documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		NSString* path = [documentsDirectory stringByAppendingPathComponent: @"Cache.archive"];
		NSData* data = [NSData dataWithContentsOfFile: path];
		if (data != nil) {
			cache_ = [[NSKeyedUnarchiver unarchiveObjectWithData: data] retain];
		} else {
			cache_ = [NSMutableDictionary new];
		}
	}
	return self;
}

- (void) dealloc
{
	[cache_ release];
	[super dealloc];
}

- (void) cacheObject: (id) object withType: (NSString*) type name: (NSString*) name
{
	[cache_ setValue: object forKey: [NSString stringWithFormat: @"%@/%@", type, name]];

	NSString* documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString* path = [documentsDirectory stringByAppendingPathComponent: @"Cache.archive"];
	[NSKeyedArchiver archiveRootObject: cache_ toFile: path];
}

- (id) cachedObjectOfType: (NSString*) type name: (NSString*) name
{
	return [cache_ objectForKey: [NSString stringWithFormat: @"%@/%@", type, name]];
}

@end