//
//  WebHTMLView+KSBookmark.h
//
//  Add special item to context menu.
//
//  Created by KatokichiSoft on 11/02/28.
//  Copyright 2011 KatokichiSoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class WebView;


@interface WebHTMLView : NSControl {
}

- (WebView *)_webView;
- (NSString *)selectedString;
- (NSMenu *)menuForEvent:(NSEvent *)event;
- (NSDictionary *)elementAtPoint:(NSPoint)point
              allowShadowContent:(BOOL)yn;
- (NSPoint)convertPoint:(NSPoint)point
               fromView:(NSView *)view;

@end


@interface WebHTMLView (KSBookmark) 

- (NSMenu *)comKsMenuForEvent:(NSEvent *)event;

@end
