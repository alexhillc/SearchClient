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

NSString * const GsearchResultClassWeb = @"GwebSearch";
NSString * const GsearchResultClassImage = @"GimageSearch";
NSString * const GsearchResultClassNews = @"GnewsSearch";

@implementation ASCSearchResultModel

+ (ASCSearchResultModel *)modelForDictionary:(NSDictionary *)dic {
    NSString *resultClass = [dic valueForKey:@"GsearchResultClass"];

    if ([resultClass isEqualToString:GsearchResultClassWeb]) {
        return [[ASCWebSearchResultModel alloc] initWithDictionary:dic];
    } else if ([resultClass isEqualToString:GsearchResultClassImage]) {
        return [[ASCImageSearchResultModel alloc] initWithDictionary:dic];
    }
    
    return nil;
}

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    
    return nil;
}

@end
