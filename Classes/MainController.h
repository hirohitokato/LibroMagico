//
//  MainController.h
//
//  Created by KatokichiSoft on 11/02/28.
//  Copyright 2011 KatokichiSoft. All rights reserved.
//

#import <objc/runtime.h>
#import <Cocoa/Cocoa.h>
#import "WebHTMLView+KSBookmark.h"

#define MainController ComKatokichiSoftMainController

#define LIBROMAGICO_BUNDLE_ID @"com.KatokichiSoft.LibroMagico.bundle"

@interface MainController : NSObject {

}

+ (NSImage *)preloadImage:(NSString *)name;

+ (void)swizzleInstanceMethod:(SEL)aMethod
                   withMethod:(SEL)otherMethod
                      ofClass:(Class)theClass;
@end
