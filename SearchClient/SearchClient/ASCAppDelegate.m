//
//  AppDelegate.m
//  SearchClient
//
//  Created by Alex Hill on 10/18/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCAppDelegate.h"
#import "ASCCoverViewController.h"
#import "ASCSearchHistoryViewModel.h"

@implementation ASCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ASCCoverViewController *coverViewController = [[ASCCoverViewController alloc] init];
    ASCSearchHistoryViewModel *vm = [[ASCSearchHistoryViewModel alloc] init];
    coverViewController.searchHistoryViewModel = vm;
    self.window.rootViewController = coverViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
