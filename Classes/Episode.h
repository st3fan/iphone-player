// Episode.h

#import <Foundation/Foundation.h>

@class Show;

@interface Episode : NSObject {
  @private
	NSString* path_;
	NSUInteger season_;
	NSUInteger episode_;
	NSDate* date_;
	Show* show_;
	NSString* name_;
}

@property (nonatomic,retain) NSString* path;
@property (nonatomic,retain) NSDate* date;
@property (nonatomic,assign) NSUInteger season;
@property (nonatomic,assign) NSUInteger episode;
@property (nonatomic,retain) Show* show;
@property (nonatomic,retain) NSString* name;

@end