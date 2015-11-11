//
//  ASCWebSearchLoader.m
//  SearchClient
//
//  Created by Alex Hill on 11/10/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCWebSearchLoader.h"

@implementation ASCWebSearchLoader

- (ASCLoaderType)type {
    return ASCLoaderTypeWebSearch;
}

- (NSString *)createRequest {
    // Base string
    self.request = [[ASCLoader baseSearchUrl] stringByAppendingString:@"/web?v=1.0"];
    
    // Build query
    self.request = [[self.request stringByAppendingString:@"&q="]
                    stringByAppendingString:[self.requestParameters stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    
    // 8 results max
    self.request = [self.request stringByAppendingString:@"&rsz=8"];
    
    return self.request;
}

- (void)processResponse {
    // do stuff
}

@end
