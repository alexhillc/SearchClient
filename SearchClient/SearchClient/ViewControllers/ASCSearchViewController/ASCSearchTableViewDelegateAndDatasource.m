//
//  ASCSearchTableViewDelegate.m
//  SearchClient
//
//  Created by Alex Hill on 11/17/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchTableViewDelegateAndDatasource.h"
#import "ASCTableViewSearchCell.h"
#import "ASCSearchResultsViewModel.h"
#import "ASCSearchViewController.h"
#import "ASCSearchResultsViewController.h"
#import "ASCSearchResultsView.h"

@implementation ASCSearchTableViewDelegateAndDatasource

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASCTableViewSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:ASCTableViewSearchCellIdentifier];
    if (!cell) {
        cell = [[ASCTableViewSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ASCTableViewSearchCellIdentifier];
    }
    
    if ([self.vc isKindOfClass:[ASCSearchViewController class]]) {
        ASCSearchViewController *searchVc = (ASCSearchViewController *)self.vc;
        cell.textLabel.text = [searchVc.searchViewModel.searchHistoryData objectAtIndex:indexPath.row];
    } else if ([self.vc isKindOfClass:[ASCSearchResultsViewController class]]) {
        ASCSearchResultsViewController *searchResultsVc = (ASCSearchResultsViewController *)self.vc;
        cell.textLabel.text = [searchResultsVc.searchViewModel.searchHistoryData objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.vc isKindOfClass:[ASCSearchViewController class]]) {
        ASCSearchViewController *searchVc = (ASCSearchViewController *)self.vc;
        return searchVc.searchViewModel.searchHistoryData.count;
    } else if ([self.vc isKindOfClass:[ASCSearchResultsViewController class]]) {
        ASCSearchResultsViewController *searchResultsVc = (ASCSearchResultsViewController *)self.vc;
        return searchResultsVc.searchViewModel.searchHistoryData.count;
    }
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.vc isKindOfClass:[ASCSearchViewController class]]) {
        ASCSearchViewController *searchVc = (ASCSearchViewController *)self.vc;
        [searchVc presentViewControllerWithQuery:[searchVc.searchViewModel.searchHistoryData objectAtIndex:indexPath.row]];
    } else if ([self.vc isKindOfClass:[ASCSearchResultsViewController class]]) {
        ASCSearchResultsViewController *searchResultsVc = (ASCSearchResultsViewController *)self.vc;
        [searchResultsVc presentResultsForQuery:[searchResultsVc.searchViewModel.searchHistoryData objectAtIndex:indexPath.row]];
    }
}

@end
