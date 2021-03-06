//
//  BookmarkCollector.m
//
//  Created by KatokichiSoft on 11/02/28.
//  Copyright 2011 KatokichiSoft. All rights reserved.
//

#import "BookmarkCollector.h"

@interface BookmarkCollector (private)
- (NSString *)bookmarkFilePath;
- (NSDictionary *)dictionaryForTitle:(NSString *)title type:(NSString *)type parentDict:(NSDictionary *)dictionary;
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
		_cache = nil;
		_lastModifiedDate = nil;
	}
	return self;
}

- (void)dealloc {
	[_cache release];
	[_lastModifiedDate release];
	[super dealloc];
}

#pragma mark -
- (BOOL)shouldReloadFilePath:(NSString *)path {

	// If modification date is not changed, keep using a current cache
	NSDate *modificationDate;
	NSDictionary *attributes = [[NSFileManager defaultManager]
								attributesOfItemAtPath:[self bookmarkFilePath]
								error:nil];
	modificationDate = [attributes objectForKey:NSFileModificationDate];
	if ([modificationDate isEqualToDate:_lastModifiedDate]) {
		// Do nothing
		return NO;
	} else {
		// Update cache and indicate the needs.
		[modificationDate retain];
		[_lastModifiedDate release];
		_lastModifiedDate = modificationDate;
		return YES;
	}

}
- (NSArray *)currentBookmarks {
	NSString *aPath = [self bookmarkFilePath];
	
	// Check whether I should reload the file.
	if (![self shouldReloadFilePath:aPath]) {
		return _cache;
	}

	// Read bookmarks
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
	NSDictionary *bookmarks = [NSDictionary dictionaryWithContentsOfFile:[self bookmarkFilePath]];
	NSDictionary *bookmarkBar = [self dictionaryForTitle:@"BookmarksBar"
													type:@"WebBookmarkTypeList"
											  parentDict:bookmarks];
	NSDictionary *bookmarklets = [self dictionaryForTitle:@"Bookmarklets"
													 type:@"WebBookmarkTypeList"
											   parentDict:bookmarkBar];
	[self recursiveReadBookmarksDict:bookmarklets result:array];

	// Update cache
	[array retain];
	[_cache release];
	_cache = array;

	return array;
}

- (Bookmark *)bookmarkAtIndex:(NSInteger)index {
	if (!_cache) {
		[self currentBookmarks];
	}
	return [_cache objectAtIndex:index];
}

- (NSDictionary *)dictionaryForTitle:(NSString *)title
								type:(NSString *)type
						  parentDict:(NSDictionary *)dictionary {
	// Search "Bookmarklets" directory in Boomark Bar
	NSArray* children = [dictionary objectForKey:@"Children"];
	if (!children)
		return nil;

	for (NSDictionary* e in children) {
		NSString* childtype = [e objectForKey:@"WebBookmarkType"];
		NSString* childtitle = [e objectForKey:@"Title"];
		
		if ([childtype isEqualToString:type] && [childtitle isEqualToString:title]) {
				return e;
		}
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
			
			Bookmark *b = [[[Bookmark alloc] initWithTitle:title url:urlStr]
						   autorelease];
			[array insertObject:b atIndex:[array count]];
		}
	}
}
@end
