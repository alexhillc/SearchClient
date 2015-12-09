//
//  ASCSearchTableViewDelegate.m
//  SearchClient
//
//  Created by Alex Hill on 11/17/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchHistoryTableViewDelegateAndDatasource.h"
#import "ASCTableViewSearchHistoryCell.h"
#import "ASCSearchResultsViewModel.h"
#import "ASCCoverViewController.h"
#import "ASCSearchResultsViewController.h"
#import "ASCSearchResultsView.h"

@implementation ASCSearchHistoryTableViewDelegateAndDatasource

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASCTableViewSearchHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ASCTableViewSearchCellIdentifier];
    if (!cell) {
        cell = [[ASCTableViewSearchHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ASCTableViewSearchCellIdentifier];
    }
    
    cell.textLabel.text = [self.vc.searchHistoryViewModel.data objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vc.searchHistoryViewModel.data.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.vc isKindOfClass:[ASCCoverViewController class]]) {
        ASCCoverViewController *searchVc = (ASCCoverViewController *)self.vc;
        [searchVc presentViewControllerWithQuery:[searchVc.searchHistoryViewModel.data objectAtIndex:indexPath.row]];
    } else if ([self.vc isKindOfClass:[ASCSearchResultsViewController class]]) {
        ASCSearchResultsViewController *searchResultsVc = (ASCSearchResultsViewController *)self.vc;
        [searchResultsVc presentViewControllerWithQuery:[searchResultsVc.searchHistoryViewModel.data objectAtIndex:indexPath.row]];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
