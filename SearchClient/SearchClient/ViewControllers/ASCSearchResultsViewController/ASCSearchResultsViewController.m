//
//  ASCSearchResultsViewController.m
//  SearchClient
//
//  Created by Alex Hill on 11/14/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchResultsViewController.h"
#import "ASCSearchResultsView.h"
#import "ASCSearchResultsViewModel.h"
#import "ASCTableViewSearchResultCell.h"
#import "TTTAttributedLabel.h"
#import "ASCTableView.h"

#import <SafariServices/SafariServices.h>

@interface ASCSearchResultsViewController () <TTTAttributedLabelDelegate, UITableViewDataSource, UITableViewDelegate, ASCSearchResultsViewModelDelegate>

@property (weak) ASCSearchResultsView *searchResultsView;

@end

@implementation ASCSearchResultsViewController

- (void)viewDidLoad {
    [super loadView];
    
    self.view = [[ASCSearchResultsView alloc] init];
    self.searchResultsView = (ASCSearchResultsView *)self.view;
    self.searchResultsView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchResultsView.tableView.backgroundColor = [UIColor clearColor];
    self.searchResultsView.tableView.layer.borderWidth = 0.;
    self.searchResultsView.tableView.delegate = self;
    self.searchResultsView.tableView.dataSource = self;
    
    self.title = self.viewModel.title;
    self.viewModel.delegate = self;
    [self.viewModel loadResultsWithQueryType:ASCQueryTypeWeb];
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASCTableViewSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:ASCTableViewSearchResultCellIdentifier];
    if (!cell) {
        cell = [[ASCTableViewSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ASCTableViewSearchResultCellIdentifier];
        cell.titleLabel.delegate = self;
    }
    
    cell.cellModel = [self.viewModel.resultsData objectAtIndex:indexPath.section];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.resultsData.count;
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

#pragma mark - ASCSearchResultsViewModelDelegate
- (void)viewModelDidReceiveNewDataSet:(ASCSearchResultsViewModel *)viewModel {
    [self.searchResultsView.tableView reloadData];
}

#pragma mark - TTTAttributedLabelDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    if (NSClassFromString(@"SFSafariViewController") != Nil) {
        if ([url.scheme hasPrefix:@"http"]) {
            SFSafariViewController *safari = [[SFSafariViewController alloc] initWithURL:url];
            [self presentViewController:safari animated:YES completion:nil];
            
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
        
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
