//
//  WebHTMLView+KSBookmark.m
//
//  Add special item to context menu.
//
//  Created by KatokichiSoft on 11/02/28.
//  Copyright 2011 KatokichiSoft. All rights reserved.
//

#import "WebHTMLView+KSBookmark.h"
#import "MenuController.h"

@implementation WebHTMLView (KSBookmark)
- (NSMenu *)comKsMenuForEvent:(NSEvent *)event
{
    NSMenu *menu = [self comKsMenuForEvent:event];
    [[MenuController sharedController] insertItemToContextMenu:menu
													  forEvent:event];
    return menu;
}

@end
