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
@end
