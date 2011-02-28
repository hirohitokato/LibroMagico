//
//  BookmarkCollector.m
//  SafariBookmark
//
//  Created by KatokichiSoft on 11/02/28.
//  Copyright 2011 KatokichiSoft. All rights reserved.
//

#import "BookmarkCollector.h"
#import "Bookmark.h"

@interface BookmarkCollector (private)
- (NSString *)bookmarkFilePath;
- (NSDictionary *)dictionaryForBookmarklets:(NSDictionary *)bookmarks;
- (void)recursiveReadBookmarksDict:(NSDictionary *)bookmark result:(NSMutableArray *)array;
@end

@implementation BookmarkCollector

+ (id)sharedInstance {
	static id instance = nil;
	if (!instance) {
		instance = [[[self class] alloc] init];
	}
	return instance;
}

- (NSString *)bookmarkFilePath {
	NSString *libraryDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
	NSString *safariDir = [libraryDir stringByAppendingPathComponent:@"Safari"];
	NSString *bookmarksPlist = [safariDir stringByAppendingPathComponent:@"Bookmarks.plist"];
	return bookmarksPlist;
}

- (id)init {
	if ((self=[super init])) {
	}
	return self;
}

#pragma mark -
- (NSArray *)currentBookmarks {
	NSDictionary *bookmarks = [NSDictionary dictionaryWithContentsOfFile:[self bookmarkFilePath]];

	// Read bookmarks
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
	NSDictionary *bookmarklets = [self dictionaryForBookmarklets:bookmarks];
	[self recursiveReadBookmarksDict:bookmarklets result:array];

	return array;
}

- (NSDictionary *)dictionaryForBookmarklets:(NSDictionary *)bookmarks {
	// Search "Bookmarklets" directory in Boomark Bar
	NSArray* children = [bookmarks objectForKey:@"Children"];
	if (!children)
		return nil;

	for (NSDictionary* e in children) {
		NSString* type = [e objectForKey:@"WebBookmarkType"];
		NSString* title = [e objectForKey:@"Title"];
		
		if ([type isEqualToString:@"WebBookmarkTypeList"] && [title isEqualToString:@"Title"])
			return e;
	}
	return nil;
}

- (void)recursiveReadBookmarksDict:(NSDictionary *)dict
							result:(NSMutableArray *)array {
	NSArray* children = [dict objectForKey:@"Children"];
	if (!children)
		return;

	for (NSDictionary* e in children) {
		NSString* type = [e objectForKey:@"WebBookmarkType"];
		
		if ([type isEqualToString:@"WebBookmarkTypeList"]) {
			[self recursiveReadBookmarksDict:e result:array];
		}
		
		if ([type isEqualToString:@"WebBookmarkTypeLeaf"]) {
			NSString* urlStr = [e objectForKey:@"URLString"];
			NSString* title = [[e objectForKey:@"URIDictionary"]
							   objectForKey:@"title"];
			
			if (!urlStr || !title)
				continue;
			
			Bookmark *b = [[[Bookmark alloc] initWithTitle:title url:[NSURL URLWithString:urlStr]]
						   autorelease];
			[array insertObject:b atIndex:[array count]];
		}
	}
}
@end
