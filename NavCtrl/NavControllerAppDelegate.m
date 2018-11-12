//
//  NavControllerAppDelegate.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "NavControllerAppDelegate.h"
#import "HomeVC.h"

@implementation NavControllerAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    HomeVC *rootController = [[HomeVC alloc]init];
    
    _navigationController = [[UINavigationController alloc]
                            initWithRootViewController:rootController];
    
    [rootController release];
    
    _window = [[UIWindow alloc]
                   initWithFrame:[[UIScreen mainScreen] bounds]];
    [_window setRootViewController:self.navigationController];
    [self.window makeKeyAndVisible];
    return YES;
    
    
    /*
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
     */
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+(BOOL)isNetworkRechability
{
    BOOL rechable = NO;
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)
    {
        rechable = NO;
    }
    else
    {
        rechable = YES;
    }
    return rechable;
}

-(void)dealloc
{
    [_window release];
    [_rechability release];
    [_navigationController release];
    [super dealloc];
}
@end
