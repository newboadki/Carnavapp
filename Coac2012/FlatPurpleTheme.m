//
//  FlatPurpleTheme.m
//  Coac2012
//
//  Created by Borja Arias Drake on 17/09/2013.
//  Copyright (c) 2013 Borja Arias Drake. All rights reserved.
//

#import "FlatPurpleTheme.h"

static FlatPurpleTheme *_sharedInstance;

@implementation FlatPurpleTheme

#pragma mark - Singleton

+ (id) sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[FlatPurpleTheme alloc] init];
    });
    
    return _sharedInstance;
}


- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (id)autorelease
{
    return self;
}



#pragma mark - ThemeProtocol

- (UIImage*) navigationBarBackgroundImage
{
    return [UIImage imageNamed:@"velvetThemeNavigationBarBackground.png"];
}


- (UIImage*) navigationBarBackButtonImage
{
    return [[UIImage imageNamed:@"velvetThemeNavigationBarBackButton.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:0];
}


- (UIImage*) tabBarBackgroundImage
{
    return [UIImage imageNamed:@"velvetThemeTabBarBackground.png"];
}


- (UIColor*) tabBarIconSelectedColor
{
    return [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1.0];
}

- (UIColor*) tintColor {
    return [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1.0];
}

- (UIColor*) tabBarTintColor
{
    return [UIColor colorWithRed:169.0/255.0 green:3.0/255.0 blue:79.0/255.0 alpha:1.0];
}

- (UIColor*) navBarTintColor
{
    return [UIColor colorWithRed:169.0/255.0 green:3.0/255.0 blue:79.0/255.0 alpha:1.0];
}

@end
