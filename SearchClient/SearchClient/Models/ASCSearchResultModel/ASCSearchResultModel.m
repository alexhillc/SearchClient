//
//  ASCSearchResultModel.m
//  SearchClient
//
//  Created by Alex Hill on 11/14/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchResultModel.h"
#import "ASCWebSearchResultModel.h"
#import "ASCImageSearchResultModel.h"
#import "ASCNewsSearchResultModel.h"
#import "ASCSpellSearchResultModel.h"
#import "ASCVideoSearchResultModel.h"
#import "ASCRelatedSearchResultModel.h"

NSString * const BsearchResultClassWeb = @"WebResult";
NSString * const BsearchResultClassImage = @"ImageResult";
NSString * const BsearchResultClassNews = @"NewsResult";
NSString * const BsearchResultClassSpell = @"SpellResult";
NSString * const BsearchResultClassVideo = @"VideoResult";
NSString * const BsearchResultClassRelated = @"RelatedSearchResult";

@implementation ASCSearchResultModel

+ (ASCSearchResultModel *)modelForDictionary:(NSDictionary *)dic {
    NSString *resultClass = [[dic valueForKey:@"__metadata"] valueForKey:@"type"];

    if ([resultClass isEqualToString:BsearchResultClassWeb]) {
        return [[ASCWebSearchResultModel alloc] initWithDictionary:dic];
    } else if ([resultClass isEqualToString:BsearchResultClassImage]) {
        return [[ASCImageSearchResultModel alloc] initWithDictionary:dic];
    } else if ([resultClass isEqualToString:BsearchResultClassNews]) {
        return [[ASCNewsSearchResultModel alloc] initWithDictionary:dic];
    } else if ([resultClass isEqualToString:BsearchResultClassSpell]) {
        return [[ASCSpellSearchResultModel alloc] initWithDictionary:dic];
    } else if ([resultClass isEqualToString:BsearchResultClassVideo]) {
        return [[ASCVideoSearchResultModel alloc] initWithDictionary:dic];
    } else if ([resultClass isEqualToString:BsearchResultClassRelated]) {
        return [[ASCRelatedSearchResultModel alloc] initWithDictionary:dic];
    }
    
    return nil;
}

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    
    return nil;
}

@end
