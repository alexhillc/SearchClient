//
//  ASCSearchResultsVIew.h
//  SearchClient
//
//  Created by Alex Hill on 11/21/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCView.h"

@interface ASCSearchResultsView : ASCView

@property ASCTableView *searchResultsTableView;

/**
 * @brief Hide results table view, show loading animation
 */
- (void)startLoadingAnimation;

/**
 * @brief Show results table view, hide loading animation
 */
- (void)stopLoadingAnimation;

/**
 * @brief Boolean that uses values of the table view and loading spinner to decide if the
 *        view is displaying results
 */
- (BOOL)isDisplayingResults;

@end
