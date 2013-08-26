//
//  ThemeManager_iOS6.m
//  Coac2012
//
//  Created by Borja Arias Drake on 26/08/2013.
//  Copyright (c) 2013 Borja Arias Drake. All rights reserved.
//

#import "ThemeManager_iOS6.h"

@implementation ThemeManager_iOS6

@synthesize theme = _theme;


- (void) applyTheme
{
    // Call Super
    [super applyTheme];
    
    // Navigation bar
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[self.theme navigationBarBackButtonImage]
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];
}

@end
