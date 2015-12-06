//
//  ASCNewsSearchResultModel.m
//  SearchClient
//
//  Created by Alex Hill on 11/29/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCNewsSearchResultModel.h"

@implementation ASCNewsSearchResultModel

- (instancetype)initWithDictionary:(NSDictionary *)dic requestParams:(NSArray *)params {
    if (self = [super init]) {
        self.bingSearchResultClass = [[dic valueForKey:@"__metadata"] valueForKey:@"type"];
        self.searchId = [dic valueForKey:@"ID"];
        self.title = [dic valueForKey:@"Title"];
        self.url = [NSURL URLWithString:[dic valueForKey:@"Url"]];
        
        NSArray *keys = [[NSArray alloc] initWithObjects:NSFontAttributeName, nil];
        NSArray *objects = [[NSArray alloc] initWithObjects:[UIFont boldSystemFontOfSize:12.], nil];
        NSMutableAttributedString *attributedDesc = [[NSMutableAttributedString alloc] initWithString:[dic valueForKey:@"Description"]];
        [attributedDesc replaceOccurancesOfStrings:params withAttributes:[NSDictionary dictionaryWithObjects:objects forKeys:keys]];
        self.searchDesc = [attributedDesc copy];
        
        self.publisher = [dic valueForKey:@"Source"];
        self.publishedDate = [NSDate asc_dateFromISO8601String:[dic valueForKey:@"Date"]];
    }
    
    return self;
}

@end
