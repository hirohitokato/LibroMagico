//
//  MainController.m
//
//  Created by KatokichiSoft on 11/02/28.
//  Copyright 2011 KatokichiSoft. All rights reserved.
//

#import "MainController.h"

@implementation MainController

+(void)load {
	KSLog(@"Hello, SIMBL world.");
    [self swizzleInstanceMethod:@selector(menuForEvent:)
					 withMethod:@selector(comKsMenuForEvent:)
						ofClass:[WebHTMLView class]];
}

+ (void)swizzleInstanceMethod:(SEL)aSelector
                   withMethod:(SEL)otherSelector
                      ofClass:(Class)theClass
{
    Method orig = class_getInstanceMethod(theClass, aSelector);
    Method alt = class_getInstanceMethod(theClass, otherSelector);
    method_exchangeImplementations(orig, alt);
}

+ (NSImage *)preloadImage:(NSString *)name {
	NSString * imagePath = [[NSBundle bundleWithIdentifier:LIBROMAGICO_BUNDLE_ID] pathForImageResource:name];
	if (imagePath == nil) {
		NSLog(@"imagePath for %@ is nil", name);
		return nil;
	}
	NSLog(@"imagePath : %@", imagePath);
	
	NSImage * image = [[NSImage alloc] initByReferencingFile:imagePath];
	if (image == nil) {
		NSLog(@"image for %@ is nil", name);
		return nil;
	}
	
	[image setName:name];
	return image;
}

@end
