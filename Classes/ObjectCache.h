//  ObjectCache.h

#import <Foundation/Foundation.h>

@interface ObjectCache : NSObject {
	NSMutableDictionary* cache_;
}

+ (id) sharedObjectCache;

- (void) cacheObject: (id) object withType: (NSString*) type name: (NSString*) name;
- (id) cachedObjectOfType: (NSString*) type name: (NSString*) name;

@end