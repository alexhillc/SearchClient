//
//  ASCNewsSearchResultModel.m
//  SearchClient
//
//  Created by Alex Hill on 11/29/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCNewsSearchResultModel.h"

@implementation ASCNewsSearchResultModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.bingSearchResultClass = [[dic valueForKey:@"__metadata"] valueForKey:@"type"];
        self.searchId = [dic valueForKey:@"ID"];
        self.url = [NSURL URLWithString:[dic valueForKey:@"Url"]];
        
        NSArray *keys = [[NSArray alloc] initWithObjects:NSFontAttributeName, nil];
        NSArray *objectsDesc = [[NSArray alloc] initWithObjects:[UIFont boldSystemFontOfSize:14.], nil];
        NSArray *objectsTitle = [[NSArray alloc] initWithObjects:[UIFont boldSystemFontOfSize:16.], nil];
        
        NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:[dic valueForKey:@"Title"]];
        [attributedTitle replaceOccurancesOfBeginningTag:@"\uE000" endingTag:@"\uE001" withAttributes:[NSDictionary dictionaryWithObjects:objectsTitle forKeys:keys]];
        self.title = [attributedTitle copy];
        
        NSMutableAttributedString *attributedDesc = [[NSMutableAttributedString alloc] initWithString:[dic valueForKey:@"Description"]];
        [attributedDesc replaceOccurancesOfBeginningTag:@"\uE000" endingTag:@"\uE001" withAttributes:[NSDictionary dictionaryWithObjects:objectsDesc forKeys:keys]];
        self.searchDesc = [attributedDesc copy];
        
        self.publisher = [dic valueForKey:@"Source"];
        self.publishedDate = [NSDate asc_dateFromISO8601String:[dic valueForKey:@"Date"]];
    }
    
    return self;
}

@end
