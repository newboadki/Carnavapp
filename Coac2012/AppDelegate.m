//
//  AppDelegate.m
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "AppDelegate.h"
#import "TodayViewController.h"
#import "ModalitiesViewController.h"




@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize dataHandler;

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [dataHandler release];
    [super dealloc];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    ModelDataHandler* dh = [[ModelDataHandler alloc] init];
    [self setDataHandler:dh];
    [dh release];    
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(handleDataIsReady:) 
                                                 name:MODEL_DATA_IS_READY_NOTIFICATION 
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(handleNoNetwork:) 
                                                 name:NO_NETWORK_NOTIFICATION 
                                               object:nil];

            
    
    loadingScreen = [[[[NSBundle mainBundle] loadNibNamed:@"LoadingScreen" owner:self options:nil] objectAtIndex:0] retain];
    loadingScreen.frame = CGRectMake(0, 20, 320, 460);
    [self.window addSubview:loadingScreen];
    
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    return YES;
}


- (void) handleDataIsReady:(NSNotification*)notif
{
    [UIView animateWithDuration:0.5 animations:^{
        [loadingScreen setAlpha:0.0];
    } completion:^(BOOL finished) {
        [loadingScreen removeFromSuperview];
        [loadingScreen release];
    }];
}

- (void) handleNoNetwork:(NSNotification*)notif
{
    UILabel* label = (UILabel*)[loadingScreen viewWithTag:LOADING_SCREEN_LABEL_TAG];
    label.text = @"No hay acceso a internet";
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Going to the background, stop download and parsing
    [self.dataHandler cancelOperations];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    UILabel* label = (UILabel*)[loadingScreen viewWithTag:LOADING_SCREEN_LABEL_TAG];
    label.text = @"Buscando conexion a internet";

    [self.dataHandler downloadAndParseModelData];
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
