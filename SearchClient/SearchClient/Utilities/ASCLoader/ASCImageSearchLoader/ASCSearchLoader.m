//
//  ASCImageSearchLoader.m
//  SearchClient
//
//  Created by Alex Hill on 11/13/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchLoader.h"
#import "ASCSearchResultModel.h"

@implementation ASCSearchLoader

- (ASCLoaderType)type {
    return ASCLoaderTypeSearch;
}

- (NSString *)createRequest {
    NSString *queryType = [self.requestParameters valueForKey:@"queryType"];
    NSString *queryString = [self.requestParameters valueForKey:@"queryString"];
    
    // Base string
    self.request = [[[[ASCLoader baseSearchUrl] stringByAppendingString:@"/"] stringByAppendingString:queryType]
                    stringByAppendingString:@"?v=1.0"];
    
    // Build query
    self.request = [[self.request stringByAppendingString:@"&q="]
                    stringByAppendingString:[queryString stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    
    // 8 results max
    self.request = [self.request stringByAppendingString:@"&rsz=8"];
    
    return self.request;
}

- (void)processResponse {
    NSDictionary *responseDic = (NSDictionary *)self.responseObject;
    
    if (responseDic) {
        
        BOOL success = [[responseDic valueForKey:@"responseStatus"] integerValue] == 200;
        
        if (success) {
            NSArray *resultsArray = [[responseDic valueForKey:@"responseData"] valueForKey:@"results"];
            NSMutableArray *parsedResultsArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dic in resultsArray) {
                ASCSearchResultModel *model = [[ASCSearchResultModel alloc] initWithDictionary:dic];
                [parsedResultsArray addObject: model];
            }
            
            self.parsedResult = [parsedResultsArray copy];
            
            [self informDelegateLoadingFinished];
            
        } else {
            [self informDelegateLoadingFailed:[NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorDataNotAllowed userInfo:nil]];
        }
    }
}

@end
