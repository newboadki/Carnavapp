//
//  BaseThemeManager.m
//  Coac2012
//
//  Created by Borja Arias Drake on 26/08/2013.
//  Copyright (c) 2013 Borja Arias Drake. All rights reserved.
//

#import "BaseThemeManager.h"

@implementation BaseThemeManager

@synthesize theme = _theme;

- (void) applyTheme
{
    // Tab Bar
    [[UITabBar appearance] setBackgroundImage:[self.theme tabBarBackgroundImage]];
    
    // Navigation Bar
    [[UINavigationBar appearance] setBackgroundImage:[self.theme navigationBarBackgroundImage] forBarMetrics:UIBarMetricsDefault];
}

@end
