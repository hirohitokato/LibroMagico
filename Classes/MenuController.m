//
//  MenuController.m
//  SafariBookmark
//
//  Created by KatokichiSoft on 11/02/28.
//  Copyright 2011 KatokichiSoft. All rights reserved.
//

#import "MenuController.h"
#import "BookmarkCollector.h"
#import "Bookmark.h"

@implementation MenuController


+ (id)sharedController {
	static id instance = nil;
	if (!instance) {
		instance = [[[self class] alloc] init];
	}
	return instance;
}

- (void)insertItemToContextMenu:(NSMenu *)menu forEvent:(NSEvent *)event {
	NSUInteger insertPoint = 0+2; // after Spotlight/Google

	NSMenu *submenu = [[[NSMenu alloc] init] autorelease];

	// append bookmarks
	NSArray *bookmarks = [[BookmarkCollector sharedInstance] currentBookmarks];
	for (id *obj in bookmarks) {
		Bookmark *b = (Bookmark *)obj;
		NSMenuItem *abookmarkItem = [[[NSMenuItem alloc] init] autorelease];
		[abookmarkItem setTitle:b.title];
		[submenu insertItem:abookmarkItem atIndex:[submenu numberOfItems]];
	}

	NSMenuItem *submenuItem = [[[NSMenuItem alloc] init] autorelease];
	[submenuItem setTitle:@"Bookmarklets"];
	[submenuItem setSubmenu:submenu];
	[menu insertItem:[NSMenuItem separatorItem] atIndex:insertPoint];
	[menu insertItem:submenuItem atIndex:insertPoint+1];
}

@end
