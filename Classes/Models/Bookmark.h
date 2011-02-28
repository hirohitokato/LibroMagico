//
//  KSBookmark.h
//  SafariBookmark
//
//  Created by KatokichiSoft on 11/02/28.
//  Copyright 2011 KatokichiSoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define Bookmark ComKatokichiSoftBookmark
@interface Bookmark : NSObject {
	NSString *_title;
	NSURL *_url;
}

-(id)initWithTitle:(NSString *)title url:(NSURL *)url;

@property (nonatomic, retain)NSString *title;
@property (nonatomic, retain)NSURL *url;
@end
