//
//  ASCImageSearchLoader.m
//  SearchClient
//
//  Created by Alex Hill on 11/13/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchLoader.h"
#import "ASCSearchResultModel.h"

NSString * const MSBingAuthKey = @"USflqpM3PEdUe3wTo2wpYxaBctru01LljMwiXuawr6g";

@implementation ASCSearchLoader

+ (NSString *)baseSearchUrl {
    return @"https://api.datamarket.azure.com/Bing/Search";
}

- (ASCLoaderType)type {
    NSString *queryType = [self.requestParameters valueForKey:@"queryType"];
    if (queryType) {
        if ([queryType isEqualToString:@"Web"]) {
            return ASCLoaderTypeWebSearch;
        } else if ([queryType isEqualToString:@"Image"]) {
            return ASCLoaderTypeImageSearch;
        } else if ([queryType isEqualToString:@"News"]) {
            return ASCLoaderTypeNewsSearch;
        } else if ([queryType isEqualToString:@"Video"]) {
            return ASCLoaderTypeVideoSearch;
        } else if ([queryType isEqualToString:@"RelatedSearch"]) {
            return ASCLoaderTypeRelatedSearch;
        }
    }
    
    return ASCLoaderTypeSearch;
}

- (void)createRequest {
    NSString *queryType = [self.requestParameters valueForKey:@"queryType"];
    NSString *queryString = [self.requestParameters valueForKey:@"queryString"];
        
    // Base string
    NSString *requestString = [[ASCSearchLoader baseSearchUrl] stringByAppendingString:@"/Composite?"];
    
    // Append json format
    requestString = [[[[requestString stringByAppendingString:@"$format=json"] stringByAppendingString:@"&Sources=%27spell%2B"] stringByAppendingString:queryType]
                     stringByAppendingString:@"%27"];
    
    // Build query
    requestString = [[requestString stringByAppendingString:@"&Query=%27"]
                     stringByAppendingString:[[queryString stringByReplacingOccurrencesOfString:@" " withString:@"%20"]
                                              stringByAppendingString:@"%27"]];
    
    // Don't correct query on server side
    requestString = [requestString stringByAppendingString:@"&WebSearchOptions=%27DisableQueryAlterations%27"];
    
    // Highlight query parameters
    requestString = [requestString stringByAppendingString:@"&Options=%27EnableHighlighting%27"];

    self.requestUrl = [NSURL URLWithString:requestString];
}

- (void)prepareForLoad {
    [super prepareForLoad];
    
    // Append Basic authorization key to http header
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.requestUrl];
    NSString *authStr = [@"accountKey:" stringByAppendingString:MSBingAuthKey];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    self.request = [request copy];
}

- (void)processResponse {
    NSError *jsonError = nil;
    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:self.responseData
                                                                options:NSJSONReadingAllowFragments
                                                                  error:&jsonError];
    
    // Check that we don't have an error and that the dictionary is serialized
    if (!jsonError && responseDic) {
        
        // Get the spelling suggestions dic
        NSArray *spelling = [[[[responseDic valueForKey:@"d"] valueForKey:@"results"] firstObject] valueForKey:@"SpellingSuggestions"];
        
        // Get the actual query response
        NSArray *responseObjects = [[[[responseDic valueForKey:@"d"] valueForKey:@"results"] firstObject] valueForKey:[self.requestParameters valueForKey:@"queryType"]];
        
        NSMutableArray *resultsArray = [[NSMutableArray alloc] init];
        
        if (self.type != ASCLoaderTypeImageSearch) {
            [resultsArray addObjectsFromArray:spelling];
        }
        
        [resultsArray addObjectsFromArray:responseObjects];
        
        // Parse the models
        NSMutableArray *parsedResultsArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in resultsArray) {
            ASCSearchResultModel *model = [ASCSearchResultModel modelForDictionary:dic];
            [parsedResultsArray addObject:model];
        }
        
        self.parsedResult = [parsedResultsArray copy];
        
        [self informDelegateLoadingFinished];
    } else {
        [self informDelegateLoadingFailed:[NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorUnknown userInfo:nil]];
    }
}

@end
