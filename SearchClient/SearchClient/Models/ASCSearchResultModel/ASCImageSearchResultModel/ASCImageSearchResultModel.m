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
        self.imgSize = CGSizeMake([[dic valueForKey:@"width"] floatValue], [[dic valueForKey:@"height"] floatValue]);
        self.thumbSize = CGSizeMake([[dic valueForKey:@"tbWidth"] floatValue], [[dic valueForKey:@"tbHeight"] floatValue]);
        self.url = [NSURL URLWithString:[dic valueForKey:@"originalContextUrl"]];
        
        NSMutableString *thumbUrl = [[dic valueForKey:@"tbUrl"] mutableCopy];
        [thumbUrl replaceOccurrencesOfString:@"http://" withString:@"https://" options:NSCaseInsensitiveSearch range:NSMakeRange(0, thumbUrl.length)];
        self.thumbImgUrl = [NSURL URLWithString:[thumbUrl copy]];
        
        NSMutableString *imageUrl = [[dic valueForKey:@"url"] mutableCopy];
        [imageUrl replaceOccurrencesOfString:@"http://" withString:@"https://" options:NSCaseInsensitiveSearch range:NSMakeRange(0, imageUrl.length)];
        self.imgUrl = [NSURL URLWithString:[imageUrl copy]];
    }
    
    return self;
}

@end
