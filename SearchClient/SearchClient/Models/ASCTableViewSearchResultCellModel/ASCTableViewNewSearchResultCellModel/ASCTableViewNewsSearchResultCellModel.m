//
//  ASCTableViewNewsSearchResultCellModel.m
//  SearchClient
//
//  Created by Alex Hill on 12/5/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewNewsSearchResultCellModel.h"
#import "ASCNewsSearchResultModel.h"

@implementation ASCTableViewNewsSearchResultCellModel

- (instancetype)initWithModels:(NSArray *)models {
    [NSException raise:NSInternalInconsistencyException
                format:@"This should never happen. Don't call %@ here.", NSStringFromSelector(_cmd)];
    
    return nil;
}

- (instancetype)initWithModel:(ASCSearchResultModel *)model {
    NSAssert([model isKindOfClass:[ASCNewsSearchResultModel class]], @"Invalid class type");
    if ([model isKindOfClass:[ASCNewsSearchResultModel class]]) {
        ASCNewsSearchResultModel *newsSearchModel = (ASCNewsSearchResultModel *)model;
        
        if (self = [[ASCTableViewNewsSearchResultCellModel alloc] init]) {
            self.titleLabelText = newsSearchModel.title;
            self.contentLabelText = newsSearchModel.searchDesc;
            self.url = newsSearchModel.url;
            self.publishedDateLabelText = [newsSearchModel.publishedDate asc_briefTimeInWords];
            self.publisherLabelText = newsSearchModel.publisher;
        }
    }
    
    return self;
}

@end
