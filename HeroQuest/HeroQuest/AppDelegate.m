//
//  AppDelegate.m
//  test1
//
//  Created by Jian Yao Ang on 5/19/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    [Parse setApplicationId:@"BC9SL6f99YJHlwNneAkqnG6zJ5hZXWWPfzakDAdQ"
//                  clientKey:@"fdi7L1RiZUPsCAzlDQHejF7uyRJcrXRhs9zg2kfq"];
    
    self.window.tintColor = [UIColor colorWithRed:0.02f green:0.38 blue:0.60 alpha:1];
    
    [Parse setApplicationId:@"7LYoRlnMOgFkFkeLbxtrWspwV5ph7UTly5p6P6Ez"
                  clientKey:@"iu7Hjy3u72fs6wtqukxdFDMfr1jn7jjnNGFGGpgC"];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:[PFFacebookUtils session]];
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
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
