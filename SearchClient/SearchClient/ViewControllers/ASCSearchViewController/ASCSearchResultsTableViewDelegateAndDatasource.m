//
//  ASCSearchResultsTableViewDelegate.m
//  SearchClient
//
//  Created by Alex Hill on 11/17/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchResultsTableViewDelegateAndDatasource.h"
#import "ASCTableViewSearchResultCell.h"
#import "ASCSearchResultsViewModel.h"
#import "ASCSearchResultsViewController.h"


@implementation ASCSearchResultsTableViewDelegateAndDatasource

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASCTableViewSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:ASCTableViewSearchResultCellIdentifier];
    if (!cell) {
        cell = [[ASCTableViewSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ASCTableViewSearchResultCellIdentifier];
    }
    
    cell.titleLabel.delegate = self.vc;
    cell.cellModel = [self.vc.searchResultsViewModel.resultsData objectAtIndex:indexPath.section];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.vc.searchResultsViewModel.resultsData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 7.;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASCTableViewSearchResultCell *cell = (ASCTableViewSearchResultCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.cellModel = [self.vc.searchResultsViewModel.resultsData objectAtIndex:indexPath.section];
    
    return [cell intrinsicHeightForWidth:tableView.frame.size.width];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end
