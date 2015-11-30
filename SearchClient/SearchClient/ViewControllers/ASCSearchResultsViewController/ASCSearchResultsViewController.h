//
//  ASCSearchResultsViewController.h
//  SearchClient
//
//  Created by Alex Hill on 11/20/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCViewController.h"
#import "TTTAttributedLabel.h"

extern NSString * const ASCSearchResultsTableViewCachedCellHeightsStringFormat;

@class ASCSearchResultsViewModel, ASCSearchHistoryTableViewDelegateAndDatasource, ASCSearchResultsTableViewDelegateAndDatasource;

@interface ASCSearchResultsViewController : ASCViewController <TTTAttributedLabelDelegate>

@property (nonatomic, strong) ASCSearchResultsViewModel *searchResultsViewModel;
@property (nonatomic) ASCSearchResultsTableViewDelegateAndDatasource *searchResultsTableViewDD;
@property (nonatomic, strong) NSMutableDictionary *cachedResultsTableViewCellHeights;

- (void)presentResults;

@end
