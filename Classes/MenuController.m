//
//  MenuController.m
//
//  Created by KatokichiSoft on 11/02/28.
//  Copyright 2011 KatokichiSoft. All rights reserved.
//

#import "MenuController.h"
#import "BookmarkCollector.h"
#import "Bookmark.h"
#import <WebKit/WebKit.h>

@interface AppController : NSObject
{
}
- (void)openURL:(id)arg1 forcingHTMLMIMEType:(BOOL)arg2;
@end

@interface BrowserDocumentController : NSDocumentController
{
}
+ (id)sharedDocumentController;
- (id)frontmostBrowserDocument;
- (void)openLocation:(id)arg1;
@end

@interface BrowserDocument : NSDocument
{
}
- (id)evaluateJavaScript:(id)arg1;
- (id)currentBrowserWebView;
@end


@interface WebViewPlus : WebView
{
}
@end

@interface SearchableWebView : WebViewPlus
{
}
@end

@interface BrowserContentWebView : SearchableWebView
{
}
@end

@interface BrowserWebView : BrowserContentWebView
{
}
- (id)stringByEvaluatingJavaScriptFromString:(id)arg1;
@end

@interface MenuController (private)
- (void)selected:(id)sender;
@end

@implementation MenuController

+ (id)sharedController {
	static id instance = nil;
	if (!instance) {
		instance = [[[self class] alloc] init];
	}
	return instance;
}

#pragma mark -
- (void)insertItemToContextMenu:(NSMenu *)menu forEvent:(NSEvent *)event {
	NSUInteger insertPoint = 0+2; // after Spotlight/Google

	NSMenu *submenu = [[[NSMenu alloc] init] autorelease];

	// append bookmarks
	NSInteger count = 0;
	NSArray *bookmarks = [[BookmarkCollector sharedInstance] currentBookmarks];
	for (id *obj in bookmarks) {
		Bookmark *b = (Bookmark *)obj;

		NSMenuItem *abookmarkItem = [[[NSMenuItem alloc] init] autorelease];
		[abookmarkItem setTag:count++]; // Remember the index
		[abookmarkItem setTitle:b.title];
		[abookmarkItem setTarget:self];
		[abookmarkItem setAction:@selector(selected:)];

		[submenu insertItem:abookmarkItem atIndex:[submenu numberOfItems]];
	}

	NSMenuItem *submenuItem = [[[NSMenuItem alloc] init] autorelease];
	[submenuItem setTitle:@"Bookmarklets"];
	[submenuItem setSubmenu:submenu];
	[menu insertItem:[NSMenuItem separatorItem] atIndex:insertPoint];
	[menu insertItem:submenuItem atIndex:insertPoint+1];
}

- (void)selected:(NSMenuItem *)sender {
	Bookmark *b = [[BookmarkCollector sharedInstance] bookmarkAtIndex:sender.tag];

	// http, https
	NSRange range = [b.urlString rangeOfString:@"http"];
	if (range.location==0) {
		[(AppController *)[NSApplication sharedApplication].delegate
		 openURL:[NSURL URLWithString:b.urlString] forcingHTMLMIMEType:YES];
		return;
	}

	// javascript
	range = [b.urlString rangeOfString:@"javascript:"];
	if (range.location==0) {
		// remove "javascript:" prefix and un-escape.
		NSMutableString *js_escaped = [NSMutableString stringWithString:b.urlString];
		[js_escaped deleteCharactersInRange:range];
		NSString *js = [js_escaped stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		
		Class BrowserDocumentController = objc_getClass ("BrowserDocumentController");
		id browserController = [BrowserDocumentController sharedDocumentController];
		BrowserDocument *browserDocument = [browserController frontmostBrowserDocument];

		// eval!
		[browserDocument evaluateJavaScript:js];

		return;
	}
}
@end
