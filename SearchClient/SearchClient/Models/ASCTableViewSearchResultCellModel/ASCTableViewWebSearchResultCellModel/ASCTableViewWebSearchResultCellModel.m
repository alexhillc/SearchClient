//
//  ASCTableViewWebSearchResultCellModel.m
//  SearchClient
//
//  Created by Alex Hill on 12/3/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewWebSearchResultCellModel.h"
#import "ASCWebSearchResultModel.h"

@implementation ASCTableViewWebSearchResultCellModel

- (instancetype)initWithModels:(NSArray *)models {
    [NSException raise:NSInternalInconsistencyException
                format:@"This should never happen. Don't call %@ here.", NSStringFromSelector(_cmd)];
    
    return nil;
}

- (instancetype)initWithModel:(ASCSearchResultModel *)model {
    NSAssert([model isKindOfClass:[ASCWebSearchResultModel class]], @"Invalid class type");
    if ([model isKindOfClass:[ASCWebSearchResultModel class]]) {
        ASCWebSearchResultModel *webSearchModel = (ASCWebSearchResultModel *)model;
        
        if (self = [[ASCTableViewWebSearchResultCellModel alloc] init]) {
            self.titleLabelText = webSearchModel.title;
            self.contentLabelText = webSearchModel.searchDesc;
            self.urlLabelText = webSearchModel.displayUrl;
            self.url = webSearchModel.url;
        }
    }
    
    return self;
}

@end
