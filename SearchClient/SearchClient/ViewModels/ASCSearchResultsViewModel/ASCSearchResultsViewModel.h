//
//  ASCViewModel.h
//  SearchClient
//
//  Created by Alex Hill on 10/27/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASCSearchViewModel.h"

@class ASCSearchResultsViewModel;

typedef NS_ENUM(NSInteger, ASCQueryType) {
    ASCQueryTypeWeb,
    ASCQueryypeImage
};

@interface ASCSearchResultsViewModel : ASCViewModel

@property (nonatomic, copy) NSString *query;
@property (nonatomic) ASCQueryType queryType;
@property (nonatomic, strong) NSArray *resultsData;

- (void)loadResultsWithQueryType:(ASCQueryType)queryType;

@end
