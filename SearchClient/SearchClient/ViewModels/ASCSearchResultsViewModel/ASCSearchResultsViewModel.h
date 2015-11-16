//
//  ASCViewModel.h
//  SearchClient
//
//  Created by Alex Hill on 10/27/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASCSearchResultsViewModel;

typedef NS_ENUM(NSInteger, ASCQueryType) {
    ASCQueryTypeWeb,
    ASCQueryypeImage
};

@protocol ASCSearchResultsViewModelDelegate <NSObject>

- (void)viewModelDidReceiveNewDataSet:(ASCSearchResultsViewModel *)viewModel;

@end

@interface ASCSearchResultsViewModel : NSObject

@property (nonatomic, weak) id<ASCSearchResultsViewModelDelegate> delegate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *query;
@property (nonatomic) ASCQueryType queryType;
@property (nonatomic, strong) NSArray *recentSearches;
@property (nonatomic, strong) NSArray *resultsData;

- (void)loadResultsWithQueryType:(ASCQueryType)queryType;

@end
