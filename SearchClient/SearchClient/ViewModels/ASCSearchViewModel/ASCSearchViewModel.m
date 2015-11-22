//
//  ASCSearchViewModel.m
//  SearchClient
//
//  Created by Alex Hill on 11/17/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchViewModel.h"

@implementation ASCSearchViewModel

- (void)loadSearchHistory {
    self.searchHistoryData = [[NSMutableArray alloc] initWithObjects:@"One", @"Two", @"Three", @"Four", @"Five",
                              @"Six", @"Seven", @"Eight", @"Nine", @"Ten", nil];
    
    if ([self.delegate respondsToSelector:@selector(viewModelDidReceiveNewDataSet:)]) {
        [self.delegate viewModelDidReceiveNewDataSet:self];
    }
}

@end
