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
#import "ContestResultsViewController.h"
#import "ContestPhaseDatesHelper.h"
#import "LoadingScreenViewController.h"
#import "ContestPhaseViewController.h"
#import "ImageManager.h"


@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize dataHandler;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Start caching the background Images because they have filters applied
    [[ImageManager sharedInstance] setBackgroundImageInView:nil forYear:@"2012"];
    [[ImageManager sharedInstance] setBackgroundImageInView:nil forYear:@"2013"];
    
    // As of v1.0.4 there's a new parser. Therefore We need to check for the dataModel cache in the file system.
    // If it's the first time we do this check, and the file exists, we delete it.
    [self deleteParser_1_0_3_cache];
    
    // Create dataModel Handler
    ModelDataHandler* dh = [[ModelDataHandler alloc] init];
    [self setDataHandler:dh];
    [dh release];    
    
    // Subscribe to notifications
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(handleDataIsReady:) 
                                                 name:MODEL_DATA_IS_READY_NOTIFICATION
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(handleNoNetwork:) 
                                                 name:NO_NETWORK_NOTIFICATION 
                                               object:nil];

    // Set the year for the current results VC.
    UINavigationController* navController = [[self.tabBarController viewControllers] objectAtIndex:2];
    ContestResultsViewController* resultController = (ContestResultsViewController*)[navController topViewController];
    resultController.yearString = [[ContestPhaseDatesHelper yearKeys] lastObject];
    [resultController updateArrayOfElements];
    
    // Set the year for the current Contest Phases VC.
    UINavigationController* contestPhasesNavController = [[self.tabBarController viewControllers] objectAtIndex:0];
    ContestPhaseViewController* contestPhasesViewController = (ContestPhaseViewController*)[contestPhasesNavController topViewController];
    contestPhasesViewController.yearString = [[ContestPhaseDatesHelper yearKeys] lastObject];
    [contestPhasesViewController updateArrayOfElements];
    
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // As of v1.0.4 there's a new parser. Therefore We need to check for the dataModel cache in the file system.
    // If it's the first time we do this check, and the file exists, we delete it.
    [self deleteParser_1_0_3_cache];

    NSDictionary* data = (NSDictionary*)[FileSystemHelper unarchiveObjectWithFileName:MODEL_DATA_FILE_NAME];
    
    if (!data)
    {
        [self presentLoadingScreenWithLoadingMessage:@"Descargando Datos." andModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    }
    
    [self.dataHandler downloadAndParseModelData];
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


- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark - Event handlers

- (void) handleDataIsReady:(NSNotification*)notif
{
    // Fade out loading screen
    [UIView animateWithDuration:0.5 animations:^{
        self.tabBarController.presentedViewController.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.tabBarController dismissViewControllerAnimated:NO completion:nil];
    }];
}


- (void) handleNoNetwork:(NSNotification*)notif
{
    NSDictionary* data = (NSDictionary*)[FileSystemHelper unarchiveObjectWithFileName:MODEL_DATA_FILE_NAME];
    
    if (!data)
    {
        [self presentLoadingScreenWithLoadingMessage:@"No hay acceso a internet" andModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    }
}



#pragma mark - Loading Screen

- (void) presentLoadingScreenWithLoadingMessage:(NSString*)loadingMessage andModalTransitionStyle:(UIModalPresentationStyle)modalStyle
{
    // Create and set Up
    LoadingScreenViewController *loadingScreenViewController = [[LoadingScreenViewController alloc] initWithNibName:@"LoadingScreen" bundle:nil];
    loadingScreenViewController.modalPresentationStyle = modalStyle;
    UILabel* label = (UILabel*)[loadingScreenViewController.view viewWithTag:LOADING_SCREEN_LABEL_TAG];
    label.text = loadingMessage;
    
    // Fade in loading screen    
    loadingScreenViewController.view.alpha = 0.0;
    [self.tabBarController presentViewController:loadingScreenViewController animated:NO completion:^{
        [UIView animateWithDuration:2.0 animations:^{
            loadingScreenViewController.view.alpha = 1.0;
        }];
    }];
    
    // Clean up
    [loadingScreenViewController release];
}



#pragma mark - Helpers

- (void) deleteParser_1_0_3_cache
{
    // As of v1.0.4 there's a new parser. Therefore We need to check for the dataModel cache in the file system.
    // If it's the first time we do this check, and the file exists, we delete it.
    NSMutableDictionary* settings = (NSMutableDictionary*)[FileSystemHelper unarchiveObjectWithFileName:SETTINGS_FILE_NAME];
    if (!settings)
    {
        settings = [NSMutableDictionary dictionaryWithObject:@NO forKey:PARSER_1_0_3_HAS_BEEN_DELETED];
    }
    
    if (![settings[PARSER_1_0_3_HAS_BEEN_DELETED] boolValue])
    {
        BOOL deleteSuceeded = [FileSystemHelper deleteObjectWithFileName:MODEL_DATA_FILE_NAME];
        if (deleteSuceeded)
        {
            settings[PARSER_1_0_3_HAS_BEEN_DELETED] = @YES;
            [FileSystemHelper archiveObject:settings fileName:SETTINGS_FILE_NAME];
        }
    }
}



#pragma mark - Memory Management

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MODEL_DATA_IS_READY_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NO_NETWORK_NOTIFICATION object:nil];
    [_window release];
    [_tabBarController release];
    [dataHandler release];
    [super dealloc];
}


@end
