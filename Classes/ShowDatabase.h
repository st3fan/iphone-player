// ShowDatabase.h

#import <Foundation/Foundation.h>

@class Show;

@interface ShowDatabase : NSObject {
  @private
	NSMutableDictionary* shows_;
	NSOperationQueue* operationQueue_;
}

+ (id) sharedShowDatabase;

- (void) refresh;
- (NSArray*) shows;
- (Show*) showByIdentifier: (NSString*) identifier;

@end
