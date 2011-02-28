//
//  BookmarkCollector.h
//  SafariBookmark
//
//  Created by KatokichiSoft on 11/02/28.
//  Copyright 2011 KatokichiSoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define BookmarkCollector ComKatokichiSoftBookmarkCollector

@interface BookmarkCollector : NSObject {
}

+ (id)sharedInstance;
- (NSArray *)currentBookmarks;
@end
