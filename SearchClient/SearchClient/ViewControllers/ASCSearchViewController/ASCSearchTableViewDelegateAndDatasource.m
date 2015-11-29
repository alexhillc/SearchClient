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
    
    cell.textLabel.text = [self.vc.searchViewModel.data objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vc.searchViewModel.data.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.vc isKindOfClass:[ASCSearchViewController class]]) {
        ASCSearchViewController *searchVc = (ASCSearchViewController *)self.vc;
        [searchVc presentViewControllerWithQuery:[searchVc.searchViewModel.data objectAtIndex:indexPath.row]];
    } else if ([self.vc isKindOfClass:[ASCSearchResultsViewController class]]) {
        ASCSearchResultsViewController *searchResultsVc = (ASCSearchResultsViewController *)self.vc;
        searchResultsVc.searchResultsViewModel.query = [searchResultsVc.searchViewModel.data objectAtIndex:indexPath.row];
        [searchResultsVc presentResults];
    }
}

@end
