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
#import "TTTAttributedLabel.h"
#import "ASCSearchResultsViewController.h"

#import <SafariServices/SafariServices.h>

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
    return 5.;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88.;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - TTTAttributedLabelDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    if (NSClassFromString(@"SFSafariViewController") != Nil) {
        if ([url.scheme hasPrefix:@"http"]) {
            SFSafariViewController *safari = [[SFSafariViewController alloc] initWithURL:url];
            [self.vc presentViewController:safari animated:YES completion:nil];
            
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
        
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
