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
        self.googleSearchResultClass = [dic valueForKey:@"GsearchResultClass"];
        self.title = [dic valueForKey:@"title"];
        self.titleNoFormatting = [dic valueForKey:@"titleNoFormatting"];
        self.content = [dic valueForKey:@"content"];
        self.url = [NSURL URLWithString:[dic valueForKey:@"unescapedUrl"]];
        self.publisher = [dic valueForKey:@"publisher"];
        self.clusterUrl = [NSURL URLWithString:[dic valueForKey:@"clusterUrl"]];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ"];
        self.publishedDate = [formatter dateFromString:[dic valueForKey:@"datePublished"]];
        
        NSDictionary *imageDic = [dic valueForKey:@"image"];
        self.thumbSize = CGSizeMake([[imageDic valueForKey:@"tbWidth"] floatValue], [[dic valueForKey:@"tbHeight"] floatValue]);
        
        NSMutableString *thumbUrl = [[imageDic valueForKey:@"tbUrl"] mutableCopy];
        [thumbUrl replaceOccurrencesOfString:@"http://" withString:@"https://" options:NSCaseInsensitiveSearch range:NSMakeRange(0, thumbUrl.length)];
        self.thumbImgUrl = [NSURL URLWithString:[thumbUrl copy]];
        
        NSMutableString *imageUrl = [[imageDic valueForKey:@"url"] mutableCopy];
        [imageUrl replaceOccurrencesOfString:@"http://" withString:@"https://" options:NSCaseInsensitiveSearch range:NSMakeRange(0, imageUrl.length)];
        self.imgUrl = [NSURL URLWithString:[imageUrl copy]];
    }
    
    return self;
}

@end
