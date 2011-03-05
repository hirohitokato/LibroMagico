//
//  BookmarkCollector.h
//
//  Created by KatokichiSoft on 11/02/28.
//  Copyright 2011 KatokichiSoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Bookmark.h"

#define BookmarkCollector ComKatokichiSoftBookmarkCollector

@interface BookmarkCollector : NSObject {
	NSArray *_cache;
	NSDate *_lastModifiedDate;
}

+ (id)sharedInstance;
- (NSArray *)currentBookmarks;
- (Bookmark *)bookmarkAtIndex:(NSInteger)index;

@end
