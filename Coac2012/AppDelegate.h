//
//  AppDelegate.h
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelDataHandler.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, FileDownloaderDelegateProtocol>
{
    UIView* loadingScreen;
}
@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong, nonatomic) IBOutlet UITabBarController *tabBarController;
@property (retain, nonatomic) ModelDataHandler* dataHandler;

@end
