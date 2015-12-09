//
//  ASCLocalLoader.m
//  SearchClient
//
//  Created by Alex Hill on 12/9/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCLocalLoader.h"

@interface ASCLocalLoader ()

@property (nonatomic, strong) NSArray *localData;

@end

@implementation ASCLocalLoader

- (void)createRequest {
    // empty impl
}

- (void)prepareForLoad {
    // empty impl
}

- (void)processResponse {
    self.parsedResult = self.localData;
    
    [self informDelegateLoadingFinished];
}

- (void)startLoad {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.localData = [defaults objectForKey:@"searchHistory"];
    
    [self processResponse];
}

- (void)saveToCache:(NSString *)query {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *queryArray = [[defaults objectForKey:@"searchHistory"] mutableCopy];
    
    if (!queryArray) {
        queryArray = [[NSMutableArray alloc] init];
    }
    
    if ([queryArray containsObject:query]) {
        [queryArray removeObject:query];
    }
    
    [queryArray insertObject:query atIndex:0];
    queryArray = [[queryArray subarrayWithRange:NSMakeRange(0, 5)] mutableCopy];
    [defaults setObject:queryArray forKey:@"searchHistory"];
    [defaults synchronize];
}

@end
