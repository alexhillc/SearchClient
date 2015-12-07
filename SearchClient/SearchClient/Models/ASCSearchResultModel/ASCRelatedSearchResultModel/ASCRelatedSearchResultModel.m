//
//  ASCRelatedSearchResultModel.m
//  SearchClient
//
//  Created by Alex Hill on 12/6/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCRelatedSearchResultModel.h"

@implementation ASCRelatedSearchResultModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.bingSearchResultClass = [[dic valueForKey:@"__metadata"] valueForKey:@"type"];
        self.searchId = [dic valueForKey:@"ID"];
        self.displayUrl = [dic valueForKey:@"BingUrl"];
        self.url = [NSURL URLWithString:[dic valueForKey:@"BingUrl"]];
        
        NSArray *keys = [[NSArray alloc] initWithObjects:NSFontAttributeName, nil];
        NSArray *objectsTitle = [[NSArray alloc] initWithObjects:[UIFont boldSystemFontOfSize:16.], nil];
        
        NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:[dic valueForKey:@"Title"]];
        [attributedTitle replaceOccurancesOfBeginningTag:@"\uE000" endingTag:@"\uE001" withAttributes:[NSDictionary dictionaryWithObjects:objectsTitle forKeys:keys]];
        self.title = [attributedTitle copy];
    }
    
    return self;
}

@end
