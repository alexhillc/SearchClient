//
//  ASCVideoSearchResultModel.m
//  SearchClient
//
//  Created by Alex Hill on 12/6/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCVideoSearchResultModel.h"

@implementation ASCVideoSearchResultModel

- (instancetype)initWithDictionary:(NSDictionary *)dic requestParams:(NSArray *)params {
    if (self = [super init]) {
        self.bingSearchResultClass = [[dic valueForKey:@"__metadata"] valueForKey:@"type"];
        self.searchId = [dic valueForKey:@"ID"];
        self.url = [dic valueForKey:@"MediaUrl"];
        self.runTime = [dic valueForKey:@"RunTime"];

        self.displayUrl = [dic valueForKey:@"DisplayUrl"];
        self.thumbImgUrl = [NSURL URLWithString:[[dic valueForKey:@"Thumbnail"] valueForKey:@"MediaUrl"]];
        self.thumbSize = CGSizeMake([[[dic valueForKey:@"Thumbnail"] valueForKey:@"Width"] floatValue],
                                    [[[dic valueForKey:@"Thumbnail"] valueForKey:@"Height"] floatValue]);
    }
    
    return self;
}

@end
