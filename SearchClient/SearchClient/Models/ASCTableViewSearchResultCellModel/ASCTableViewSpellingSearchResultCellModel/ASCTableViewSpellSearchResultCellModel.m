//
//  ASCTableViewSpellSearchResultCellModel.m
//  SearchClient
//
//  Created by Alex Hill on 12/6/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewSpellSearchResultCellModel.h"
#import "ASCSpellSearchResultModel.h"

@implementation ASCTableViewSpellSearchResultCellModel

- (instancetype)initWithModels:(NSArray *)models {
    [NSException raise:NSInternalInconsistencyException
                format:@"This should never happen. Don't call %@ here.", NSStringFromSelector(_cmd)];
    
    return nil;
}

- (instancetype)initWithModel:(ASCSearchResultModel *)model {
    NSAssert([model isKindOfClass:[ASCSpellSearchResultModel class]], @"Invalid class type");
    if ([model isKindOfClass:[ASCSpellSearchResultModel class]]) {
        ASCSpellSearchResultModel *spellSearchModel = (ASCSpellSearchResultModel *)model;
        
        if (self = [[ASCTableViewSpellSearchResultCellModel alloc] init]) {
            self.suggestedSpellingLabelText = spellSearchModel.spellingSuggestion;
        }
    }
    
    return self;
}

@end
