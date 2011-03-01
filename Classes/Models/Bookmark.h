//
//  KSBookmark.h
//
//  Created by KatokichiSoft on 11/02/28.
//  Copyright 2011 KatokichiSoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define Bookmark ComKatokichiSoftBookmark
@interface Bookmark : NSObject {
	NSString *_title;
	NSString *_urlString;
}

-(id)initWithTitle:(NSString *)title url:(NSString *)url;

@property (nonatomic, retain)NSString *title;
@property (nonatomic, retain)NSString *urlString;
@end
