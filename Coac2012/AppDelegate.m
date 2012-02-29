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
#import "FileSystemHelper.h"


@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize dataHandler;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
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

    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    return YES;
}


- (void) handleDataIsReady:(NSNotification*)notif
{
    [UIView animateWithDuration:1.0 animations:^{
        [loadingScreen setAlpha:0.0];
    } completion:^(BOOL finished) {
        [loadingScreen removeFromSuperview];
        loadingScreen = nil;
    }];
}

- (void) handleNoNetwork:(NSNotification*)notif
{    
    NSDictionary* data = (NSDictionary*)[FileSystemHelper unarchiveDataModel];
    
    if (!data)
    {
        loadingScreen = [[[NSBundle mainBundle] loadNibNamed:@"LoadingScreen" owner:self options:nil] objectAtIndex:0];
        loadingScreen.frame = CGRectMake(0, 0, 320, 480);        
        [self.window addSubview:loadingScreen];
        
        UILabel* label = (UILabel*)[loadingScreen viewWithTag:LOADING_SCREEN_LABEL_TAG];
        label.text = @"No hay acceso a internet";
    }
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
    
    NSDictionary* data = (NSDictionary*)[FileSystemHelper unarchiveDataModel];
    
    if (!data)
    {
        loadingScreen = [[[NSBundle mainBundle] loadNibNamed:@"LoadingScreen" owner:self options:nil] objectAtIndex:0];
        loadingScreen.frame = CGRectMake(0, 0, 320, 480);        
        [self.window addSubview:loadingScreen];
        
        UILabel* label = (UILabel*)[loadingScreen viewWithTag:LOADING_SCREEN_LABEL_TAG];
        label.text = @"Descargando Datos.";
    }
    
    [self.dataHandler downloadAndParseModelData];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [dataHandler release];
    [super dealloc];
}


@end
