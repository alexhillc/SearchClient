//
//  ASCSearchResultsViewController.h
//  SearchClient
//
//  Created by Alex Hill on 11/20/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCViewController.h"
#import "TTTAttributedLabel.h"

@class ASCSearchResultsViewModel, ASCSearchViewModel, ASCSearchTableViewDelegateAndDatasource, ASCSearchResultsTableViewDelegateAndDatasource;

@interface ASCSearchResultsViewController : ASCViewController <TTTAttributedLabelDelegate>

@property (nonatomic, strong) ASCSearchViewModel *searchViewModel;
@property (nonatomic, strong) ASCSearchResultsViewModel *searchResultsViewModel;
@property (nonatomic) ASCSearchResultsTableViewDelegateAndDatasource *searchResultsTableViewDD;
@property (nonatomic) ASCSearchTableViewDelegateAndDatasource *searchTableViewDD;

- (void)presentResultsForQuery:(NSString *)query;

@end
