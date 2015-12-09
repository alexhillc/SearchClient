//
//  ASCSearchViewModel.m
//  SearchClient
//
//  Created by Alex Hill on 11/17/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchHistoryViewModel.h"
#import "ASCLocalLoader.h"

@interface ASCSearchHistoryViewModel () <ASCLoaderDelegate>

@end

@implementation ASCSearchHistoryViewModel

- (void)loadSearchHistory {
    ASCLocalLoader *loader = [[ASCLocalLoader alloc] initWithDelegate:self];
    [loader startLoad];
}

- (void)loaderDidFinishLoadWithSuccess:(ASCLoader *)loader {
    self.data = (NSArray *)loader.parsedResult;
    
    if ([self.delegate respondsToSelector:@selector(viewModelDidReceiveNewDataSet:)]) {
        [self.delegate viewModelDidReceiveNewDataSet:self];
    }
}

- (void)loader:(ASCLoader *)loader didFinishWithFailure:(NSError *)error {
    // do something here
}

@end
