//
//  MainController.h
//  SafariBookmark
//
//  Created by KatokichiSoft on 11/02/28.
//  Copyright 2011 KatokichiSoft. All rights reserved.
//

#import <objc/runtime.h>
#import <Cocoa/Cocoa.h>
#import "WebHTMLView+KSBookmark.h"

#define MainController ComKatokichiSoftMainController

@interface MainController : NSObject {

}

+ (void)swizzleInstanceMethod:(SEL)aMethod
                   withMethod:(SEL)otherMethod
                      ofClass:(Class)theClass;
@end
