//
//  ASCViewModel.m
//  SearchClient
//
//  Created by Alex Hill on 10/27/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchResultsViewModel.h"
#import "ASCSearchLoader.h"
#import "ASCTableViewImageSearchResultCellModel.h"

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
    NSArray *resultData = (NSArray *)loader.parsedResult;
    self.data = [ASCTableViewSearchResultCellModel cellModelsForResultModels:resultData];
    
    if ([self.delegate respondsToSelector:@selector(viewModelDidReceiveNewDataSet:)]) {
        [self.delegate viewModelDidReceiveNewDataSet:self];
    }
}

- (NSString *)stringForQueryType:(ASCQueryType)queryType {
    NSArray *queryStrings = @[ @"Web", @"Image", @"News", @"Video", @"RelatedSearch" ];
    
    return [queryStrings objectAtIndex:queryType];
}

@end
