//
//  AppDelegate.h
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelDataHandler.h"
#import "ThemeProtocol.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{
    UIView* loadingScreen;
}
@property (retain, nonatomic) IBOutlet UIWindow *window;
@property (retain, nonatomic) IBOutlet UITabBarController *tabBarController;
@property (retain, nonatomic) ModelDataHandler* dataHandler;
@property (retain, nonatomic) id <ThemeProtocol> guiTheme;

@end