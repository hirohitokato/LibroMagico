//
//  MenuController.h
//  SafariBookmark
//
//  Created by KatokichiSoft on 11/02/28.
//  Copyright 2011 KatokichiSoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define MenuController ComKatokichiSoftMenuController
@interface MenuController : NSObject {
}

+ (id)sharedController;
- (void)insertItemToContextMenu:(NSMenu *)menu forEvent:(NSEvent *)event;
@end
