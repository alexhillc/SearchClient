//
//  ASCViewModel.m
//  SearchClient
//
//  Created by Alex Hill on 10/27/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchResultsViewModel.h"
#import "ASCSearchLoader.h"
#import "ASCQueryModel.h"

@interface ASCSearchResultsViewModel () <ASCLoaderDelegate>

@end

@implementation ASCSearchResultsViewModel

- (void)loadResultsWithQueryType:(ASCQueryType)queryType {
    ASCSearchLoader *loader = [[ASCSearchLoader alloc] initWithDelegate:self];
    NSString *queryTypeAsString = [self stringForQueryType:queryType];
    loader.requestParameters = [NSDictionary dictionaryWithObjects:@[queryTypeAsString, self.query] forKeys:@[@"queryType", @"queryString"]];
    
    [loader startLoad];
}

- (void)loader:(ASCLoader *)loader didFinishWithFailure:(NSError *)error {
    // do something here
}

- (void)loaderDidFinishLoadWithSuccess:(ASCLoader *)loader {
    self.resultsData = (NSArray *)loader.parsedResult;
    
    if ([self.delegate respondsToSelector:@selector(viewModelDidReceiveNewDataSet:)]) {
        [self.delegate viewModelDidReceiveNewDataSet:self];
    }
}

- (NSString *)stringForQueryType:(ASCQueryType)queryType {
    NSArray *queryStrings = @[ @"web",@"images" ];
    
    return [queryStrings objectAtIndex:queryType];
}

@end
