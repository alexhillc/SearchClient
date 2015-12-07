//
//  ASCTableViewSearchResultCellModel.m
//  SearchClient
//
//  Created by Alex Hill on 12/3/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewSearchResultCellModel.h"
#import "ASCWebSearchResultModel.h"
#import "ASCImageSearchResultModel.h"
#import "ASCNewsSearchResultModel.h"
#import "ASCSpellSearchResultModel.h"
#import "ASCVideoSearchResultModel.h"
#import "ASCRelatedSearchResultModel.h"

#import "ASCTableViewWebSearchResultCellModel.h"
#import "ASCTableViewImageSearchResultCellModel.h"
#import "ASCTableViewNewsSearchResultCellModel.h"
#import "ASCTableViewSpellSearchResultCellModel.h"
#import "ASCTableViewVideoSearchResultCellModel.h"
#import "ASCTableViewRelatedSearchResultCellModel.h"

@implementation ASCTableViewSearchResultCellModel

+ (NSArray *)cellModelsForResultModels:(NSArray *)models {
    NSMutableArray *cellModels = [[NSMutableArray alloc] init];
    
    if ([[models firstObject] class] == [ASCImageSearchResultModel class]) {
        CGFloat capacity = floorf(models.count / 3.);
        
        for (int i = 0; i < capacity; ++i) {
            [cellModels addObject:[[ASCTableViewImageSearchResultCellModel alloc] initWithModels:[models objectsAtIndexes:[[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(i * 3, 3)]]]];
        }
    } else {
        for (int i = 0; i < models.count; ++i) {
            Class resultModelClass = [[models objectAtIndex:i] class];
            
            if (resultModelClass == [ASCWebSearchResultModel class]) {
                [cellModels addObject:[[ASCTableViewWebSearchResultCellModel alloc] initWithModel:[models objectAtIndex:i]]];
            } else if (resultModelClass == [ASCNewsSearchResultModel class]) {
                [cellModels addObject:[[ASCTableViewNewsSearchResultCellModel alloc] initWithModel:[models objectAtIndex:i]]];
            } else if (resultModelClass == [ASCSpellSearchResultModel class]) {
                [cellModels addObject:[[ASCTableViewSpellSearchResultCellModel alloc] initWithModel:[models objectAtIndex:i]]];
            } else if (resultModelClass == [ASCVideoSearchResultModel class]) {
                [cellModels addObject:[[ASCTableViewVideoSearchResultCellModel alloc] initWithModel:[models objectAtIndex:i]]];
            } else if (resultModelClass == [ASCRelatedSearchResultModel class]) {
                [cellModels addObject:[[ASCTableViewRelatedSearchResultCellModel alloc] initWithModel:[models objectAtIndex:i]]];
            }
        }
    }
    
    return cellModels;
}

- (instancetype)initWithModel:(ASCSearchResultModel *)model {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    
    return nil;
}

- (instancetype)initWithModels:(NSArray *)models {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    
    return nil;
}

@end
