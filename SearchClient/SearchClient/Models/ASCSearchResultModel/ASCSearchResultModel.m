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

NSString * const BsearchResultClassWeb = @"WebResult";
NSString * const BsearchResultClassImage = @"ImageResult";
NSString * const BsearchResultClassNews = @"NewsResult";
NSString * const BsearchResultClassSpell = @"SpellResult";

@implementation ASCSearchResultModel

+ (ASCSearchResultModel *)modelForDictionary:(NSDictionary *)dic requestParams:(NSArray *)params {
    NSString *resultClass = [[dic valueForKey:@"__metadata"] valueForKey:@"type"];

    if ([resultClass isEqualToString:BsearchResultClassWeb]) {
        return [[ASCWebSearchResultModel alloc] initWithDictionary:dic requestParams:params];
    } else if ([resultClass isEqualToString:BsearchResultClassImage]) {
        return [[ASCImageSearchResultModel alloc] initWithDictionary:dic requestParams:params];
    } else if ([resultClass isEqualToString:BsearchResultClassNews]) {
        return [[ASCNewsSearchResultModel alloc] initWithDictionary:dic requestParams:params];
    } else if ([resultClass isEqualToString:BsearchResultClassSpell]) {
        return [[ASCSpellSearchResultModel alloc] initWithDictionary:dic requestParams:params];
    }
    
    return nil;
}

- (instancetype)initWithDictionary:(NSDictionary *)dic requestParams:(NSArray *)params {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    
    return nil;
}

@end
