//
//  ERAppDelegate.m
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 27..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import "ERAppDelegate.h"
#import "ERSession.h"
#import "ERSubscriptionListViewController.h"

@implementation ERAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSString *repoPath = [@"file://" stringByAppendingString:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]];
    ERPythonObject *server = [[ERPythonObject moduleWithName:"helpers"][@"new_server"] callWithArgs:"(ss)", repoPath.UTF8String, [ERSession defaultSessionID].UTF8String];
    int port = PyInt_AsLong([server[@"effective_port"]handle]);
    [NSThread detachNewThreadSelector:@selector(startServer:)
                             toTarget:self
                           withObject:server];
    
    NSLog(@"Running on %d...", port);
    ERAPIManager *manager = [[ERAPIManager alloc] initWithLocalPort:port];
    [ERAPIManager setSharedManager:manager];
    
    ERSubscriptionListViewController *vc = [[ERSubscriptionListViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    
    return YES;
}

- (void)startServer:(ERPythonObject *)server {
    [server[@"run"] callWithArgs:"()"];
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

@end
