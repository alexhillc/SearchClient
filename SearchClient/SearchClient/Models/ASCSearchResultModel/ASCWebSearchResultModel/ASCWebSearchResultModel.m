//
//  ASCWebSearchResultModel.m
//  SearchClient
//
//  Created by Alex Hill on 11/16/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCWebSearchResultModel.h"

@implementation ASCWebSearchResultModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.googleSearchResultClass = [dic valueForKey:@"GsearchResultClass"];
        self.title = [dic valueForKey:@"title"];
        self.titleNoFormatting = [dic valueForKey:@"titleNoFormatting"];
        self.content = [dic valueForKey:@"content"];
        self.url = [NSURL URLWithString:[dic valueForKey:@"url"]];
    }
    
    return self;
}

@end
