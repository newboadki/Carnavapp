//
//  AppDelegate.m
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString* file_path = [NSString stringWithFormat: @"%@xml/%@", NSTemporaryDirectory(), @"file.xml"];    
    [[NSFileManager defaultManager] removeItemAtPath:file_path error:nil];
    FileDownloader* fd = [[FileDownloader alloc] initWithURL:[NSURL URLWithString:@"http://jcorralejo.googlecode.com/svn/trunk/coac2012/coac2012.xml"] 
                                                 andFilePath: nil // it won't write it to a file 
                                               andCredential: nil 
                                                 andDelegate: self];    
    [fd start];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    UIViewController *viewController1 = [[[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil] autorelease];
    UIViewController *viewController2 = [[[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil] autorelease];
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2, nil];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void) handleSuccessfullDownloadWithData:(NSData*)data
{
    NSLog(@"SUCCESS! %i", [data length]);
    NSString* file_path = [NSString stringWithFormat: @"%@xml/%@", NSTemporaryDirectory(), @"file.xml"];
    NSLog(@"exists %i", [[NSFileManager defaultManager] fileExistsAtPath:file_path]);
    NSLog(@">>>>>>>>>>> %@", [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:file_path] encoding:NSUTF8StringEncoding]);
    NSLog(@"**************************** %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

- (void) handleFailedDownloadWithError:(NSError *)error{}
- (void) handleAuthenticationFailed{}
- (void) connectionReceivedResponseWithErrorCode:(NSInteger) statusCode{}
- (void) connectionCouldNotBeCreated{}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
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
