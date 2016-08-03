//
//  AppDelegate.m
//  iEssentials
//
//  Created by Vikram Naik on 17/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "AppDelegate.h"

NSString * const WPWISEStoreDidRegisterForAPNNotification = @"AppDelegateDidRegisterForRemoteNotifications";

@interface AppDelegate ()
{
    NSTimer *updateUITimer;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    updateUITimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(postUpdateUINotification:) userInfo:nil repeats:YES];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [updateUITimer invalidate];
    updateUITimer = nil;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    if(!updateUITimer)
        updateUITimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(postUpdateUINotification:) userInfo:nil repeats:YES];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    NSNotification *note = [NSNotification notificationWithName:WPWISEStoreDidRegisterForAPNNotification
                                                         object:nil
                                                       userInfo:nil];
    [defaultCenter postNotification:note];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"Device Token ==> %@", deviceToken);
    [[EssentialWebServiceStore sharedStore] saveDeviceTokenForCurrentUser:deviceToken];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    NSNotification *note = [NSNotification notificationWithName:WPWISEStoreDidRegisterForAPNNotification
                                                         object:nil
                                                       userInfo:nil];
    [defaultCenter postNotification:note];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    NSNotification *note = [NSNotification notificationWithName:WPWISEStoreDidRegisterForAPNNotification
                                                         object:nil
                                                       userInfo:nil];
    [defaultCenter postNotification:note];
    
    completionHandler(UIBackgroundFetchResultNewData);
    
}

-(void)postUpdateUINotification:(NSTimer *)timer
{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    NSNotification *note = [NSNotification notificationWithName:WPWISEStoreDidRegisterForAPNNotification
                                                         object:nil
                                                       userInfo:nil];
    [defaultCenter postNotification:note];
}
@end
