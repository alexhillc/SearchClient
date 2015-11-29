//
//  ASCImageSearchResultModel.m
//  SearchClient
//
//  Created by Alex Hill on 11/16/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCImageSearchResultModel.h"

@implementation ASCImageSearchResultModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.googleSearchResultClass = [dic valueForKey:@"GsearchResultClass"];
        self.title = [dic valueForKey:@"title"];
        self.titleNoFormatting = [dic valueForKey:@"titleNoFormatting"];
        self.content = [dic valueForKey:@"content"];
        self.visibleUrl = [NSURL URLWithString:[dic valueForKey:@"visibleUrl"]];
        self.url = [NSURL URLWithString:[dic valueForKey:@"url"]];
        self.size = CGSizeMake([[dic valueForKey:@"width"] floatValue], [[dic valueForKey:@"height"] floatValue]);
        self.thumbUrl = [NSURL URLWithString:[dic valueForKey:@"tbUrl"]];
        self.thumbSize = CGSizeMake([[dic valueForKey:@"tbWidth"] floatValue], [[dic valueForKey:@"tbHeight"] floatValue]);
        self.contextUrl = [NSURL URLWithString:[dic valueForKey:@"originalContextUrl"]];
    }
    
    return self;
}

@end
