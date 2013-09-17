//
//  ThemeManager_iOS7_translucent.m
//  Coac2012
//
//  Created by Borja Arias Drake on 17/09/2013.
//  Copyright (c) 2013 Borja Arias Drake. All rights reserved.
//

#import "ThemeManager_iOS7_translucent.h"
#import "AppDelegate.h"

@implementation ThemeManager_iOS7_translucent

@synthesize theme = _theme;

- (void) applyTheme
{
    
    
    // Tint color
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIWindow *window = [appDelegate window];
    [window performSelector:@selector(tintColor) withObject:self.theme.tintColor];
    
    UITabBarController *tabBarController = [appDelegate tabBarController];
    [tabBarController.tabBar setTranslucent:YES];
    
    [[UITabBar appearance] setBarTintColor:[self.theme tabBarTintColor]];
    [[UINavigationBar appearance] setBarTintColor:[self.theme navBarTintColor]];
}


@end
