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
        self.bingSearchResultClass = [[dic valueForKey:@"__metadata"] valueForKey:@"type"];
        self.searchId = [dic valueForKey:@"ID"];
        self.title = [dic valueForKey:@"Title"];
        self.displayUrl = [dic valueForKey:@"DisplayUrl"];
        self.url = [NSURL URLWithString:[dic valueForKey:@"Url"]];
        self.imgUrl = [NSURL URLWithString:[dic valueForKey:@"MediaUrl"]];
        self.thumbImgUrl = [NSURL URLWithString:[[dic valueForKey:@"Thumbnail"] valueForKey:@"MediaUrl"]];
        
        self.imgSize = CGSizeMake([[dic valueForKey:@"Width"] floatValue], [[dic valueForKey:@"Height"] floatValue]);
        self.thumbSize = CGSizeMake([[[dic valueForKey:@"Thumbnail"] valueForKey:@"Width"] floatValue],
                                    [[[dic valueForKey:@"Thumbnail"] valueForKey:@"Height"] floatValue]);
    }
    
    return self;
}

@end
