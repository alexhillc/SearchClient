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

- (void)startLoadingAnimation;
- (void)stopLoadingAnimation;
- (BOOL)isDisplayingResults;

@end
