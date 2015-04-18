//
//  AppDelegate.m
//  FaceForward
//
//  Created by Tim Crowley on 4/17/15.
//  Copyright (c) 2015 Tim Crowley. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "HomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    HomeViewController *viewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}
@end
