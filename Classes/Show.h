// Show.h

#import <Foundation/Foundation.h>

@interface Show : NSObject {
  @private
	NSString* identifier_;
	NSString* name_;
    NSString* smallImageName_;
    NSString* largeImageName_;
	NSMutableArray* episodes_;
}

@property (nonatomic,retain) NSString* identifier;
@property (nonatomic,retain) NSString* smallImageName;
@property (nonatomic,retain) NSString* largeImageName;
@property (nonatomic,retain) NSString* name;
@property (nonatomic,readonly) NSMutableArray* episodes;

@end