//
//  ThemeManager.m
//  Coac2012
//
//  Created by Borja Arias Drake on 26/08/2013.
//  Copyright (c) 2013 Borja Arias Drake. All rights reserved.
//

#import "ThemeManager_iOS7.h"
#import "AppDelegate.h"

@implementation ThemeManager_iOS7

@synthesize theme = _theme;

- (void) applyTheme
{
    // Call Supper
    [super applyTheme];
    
    // Tint color
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIWindow *window = [appDelegate window];
    [window performSelector:@selector(tintColor) withObject:self.theme.tintColor];
}

@end
