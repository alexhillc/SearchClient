//
//  AppDelegate.m
//  SearchClient
//
//  Created by Alex Hill on 10/18/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCAppDelegate.h"
#import "ASCSearchViewController.h"
#import "ASCSearchViewModel.h"

@implementation ASCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ASCSearchViewController *searchViewController = [[ASCSearchViewController alloc] init];
    ASCSearchViewModel *vm = [[ASCSearchViewModel alloc] init];
    searchViewController.searchViewModel = vm;
    self.window.rootViewController = searchViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
