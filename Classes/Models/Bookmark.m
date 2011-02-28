//
//  Bookmark.m
//  SafariBookmark
//
//  Created by KatokichiSoft on 11/02/28.
//  Copyright 2011 KatokichiSoft. All rights reserved.
//

#import "Bookmark.h"

@implementation Bookmark
@synthesize title=_title, url=_url;

-(id)initWithTitle:(NSString *)title url:(NSURL *)url {
	if ((self=[super init])) {
		self.title = title;
		self.url = url;
	}
	return self;
}

- (void)dealloc {
	[_title release];
	[_url release];
	[super dealloc];
}

#pragma mark -
- (NSString *)description {
	return [NSString stringWithFormat:@"{%@ : %@}", self.title, self.url];
}

@end
