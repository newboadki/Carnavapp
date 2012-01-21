//
//  AppDelegate.h
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileDownloader.h"
#import "FileDownloaderDelegateProtocol.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, FileDownloaderDelegateProtocol>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

@end
