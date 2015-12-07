//
//  ASCSpellSearchResultModel.m
//  SearchClient
//
//  Created by Alex Hill on 12/6/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSpellSearchResultModel.h"

@implementation ASCSpellSearchResultModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.bingSearchResultClass = [[dic valueForKey:@"__metadata"] valueForKey:@"type"];
        self.searchId = [dic valueForKey:@"ID"];
        self.spellingSuggestion = [dic valueForKey:@"Value"];
    }
    
    return self;
}

@end
