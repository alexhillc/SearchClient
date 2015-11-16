//
//  AppDelegate.m
//  SearchClient
//
//  Created by Alex Hill on 10/18/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCAppDelegate.h"
#import "ASCSearchViewController.h"

@interface ASCAppDelegate ()

@end

@implementation ASCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ASCSearchViewController *searchViewController = [[ASCSearchViewController alloc] init];
    self.window.rootViewController = searchViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
