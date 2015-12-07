//
//  ASCTableViewRelatedSearchResultCellModel.m
//  SearchClient
//
//  Created by Alex Hill on 12/6/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewRelatedSearchResultCellModel.h"
#import "ASCRelatedSearchResultModel.h"

@implementation ASCTableViewRelatedSearchResultCellModel

- (instancetype)initWithModels:(NSArray *)models {
    [NSException raise:NSInternalInconsistencyException
                format:@"This should never happen. Don't call %@ here.", NSStringFromSelector(_cmd)];
    
    return nil;
}

- (instancetype)initWithModel:(ASCSearchResultModel *)model {
    NSAssert([model isKindOfClass:[ASCRelatedSearchResultModel class]], @"Invalid class type");
    if ([model isKindOfClass:[ASCRelatedSearchResultModel class]]) {
        ASCRelatedSearchResultModel *relatedSearchModel = (ASCRelatedSearchResultModel *)model;
        
        if (self = [[ASCTableViewRelatedSearchResultCellModel alloc] init]) {
            self.titleLabelText = relatedSearchModel.title;
            self.urlLabelText = relatedSearchModel.displayUrl;
            self.url = relatedSearchModel.url;
        }
    }
    
    return self;
}

@end
