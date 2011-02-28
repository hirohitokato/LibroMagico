//
//  Bookmark.m
//  SafariBookmark
//
//  Created by KatokichiSoft on 11/02/28.
//  Copyright 2011 KatokichiSoft. All rights reserved.
//

#import "Bookmark.h"

@implementation Bookmark
@synthesize title=_title, urlString=_urlString;

-(id)initWithTitle:(NSString *)title url:(NSString *)url {
	if ((self=[super init])) {
		self.title = title;
		self.urlString = url;
	}
	return self;
}

- (void)dealloc {
	[_title release];
	[_urlString release];
	[super dealloc];
}

#pragma mark -
- (NSString *)description {
	return [NSString stringWithFormat:@"{%@ : %@}", self.title, self.urlString];
}

@end
