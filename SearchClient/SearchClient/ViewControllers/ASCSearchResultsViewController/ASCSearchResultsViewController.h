//
//  ASCSearchResultsViewController.h
//  SearchClient
//
//  Created by Alex Hill on 11/20/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCViewController.h"
#import "TTTAttributedLabel.h"
#import "ASCAsyncImageView.h"

extern NSString * const ASCSearchResultsTableViewCachedCellHeightsStringFormat;

@class ASCSearchResultsViewModel, ASCSearchHistoryTableViewDelegateAndDatasource, ASCSearchResultsTableViewDelegateAndDatasource;

@interface ASCSearchResultsViewController : ASCViewController <TTTAttributedLabelDelegate, ASCAsyncImageViewDelegate>

@property (nonatomic, strong) ASCSearchResultsViewModel *searchResultsViewModel;
@property (nonatomic) ASCSearchResultsTableViewDelegateAndDatasource *searchResultsTableViewDD;
@property (nonatomic, strong) NSMutableDictionary *cachedResultsTableViewCellHeights;
@property (nonatomic, strong) UIView *snapshotView;

/**
 * @brief Presents the results of the view model's current query in the current view controller
 */
- (void)presentResults;

@end
