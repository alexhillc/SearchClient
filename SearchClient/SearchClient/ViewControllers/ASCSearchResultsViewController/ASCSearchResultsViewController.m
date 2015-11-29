//
//  ASCSearchResultsViewController.m
//  SearchClient
//
//  Created by Alex Hill on 11/20/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchResultsViewController.h"
#import "ASCSearchResultsView.h"
#import "ASCSearchResultsTableViewDelegateAndDatasource.h"
#import "ASCSearchResultsViewModel.h"
#import "ASCTextField.h"
#import "ASCTableViewWebSearchResultCell.h"
#import "ASCTableViewImageSearchResultCell.h"
#import "ASCTableViewSearchResultCell.h"
#import "ASCTableViewSearchCell.h"
#import "TTTAttributedLabel.h"
#import <SafariServices/SafariServices.h>

NSString * const ASCSearchResultsTableViewCachedCellHeightsStringFormat = @"cachedheight%@";

@interface ASCSearchResultsViewController () <TTTAttributedLabelDelegate>

@property (nonatomic, weak) ASCSearchResultsView *searchResultsView;

@end

@implementation ASCSearchResultsViewController

- (void)loadView {    
    self.view = [[ASCSearchResultsView alloc] init];
    self.searchResultsView = (ASCSearchResultsView *)self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cachedResultsTableViewCellHeights = [[NSMutableDictionary alloc] init];
    
    self.searchResultsTableViewDD = [[ASCSearchResultsTableViewDelegateAndDatasource alloc] init];
    self.searchResultsTableViewDD.vc = self;
    self.searchResultsView.searchResultsTableView.delegate = self.searchResultsTableViewDD;
    self.searchResultsView.searchResultsTableView.dataSource = self.searchResultsTableViewDD;

    self.searchResultsViewModel.delegate = self;
    
    [self.searchResultsView.searchResultsTableView registerClass:[ASCTableViewWebSearchResultCell class] forCellReuseIdentifier:ASCTableViewWebSearchResultCellIdentifier];
    [self.searchResultsView.searchResultsTableView registerClass:[ASCTableViewImageSearchResultCell class] forCellReuseIdentifier:ASCTableViewImageSearchResultCellIdentifier];
    
    [self.searchResultsView startLoadingAnimation];
    [self.searchResultsViewModel loadResultsWithQueryType:ASCQueryTypeWeb];
    self.searchResultsView.searchBar.textField.text = self.searchResultsViewModel.query;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)presentResults {
    [self.searchResultsView startLoadingAnimation];
    self.searchResultsView.searchBar.textField.text = self.searchResultsViewModel.query;
    
    [self.searchResultsView contract];
    [self.searchResultsViewModel loadResultsWithQueryType:self.searchResultsViewModel.queryType];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.searchResultsViewModel.query = textField.text;
    [self presentResults];
    
    return YES;
}

- (void)textFieldDidCancel:(ASCTextField *)textField {
    [textField endEditing:YES];
}

#pragma mark - ASCViewModelDelegate
- (void)viewModelDidReceiveNewDataSet:(ASCViewModel *)viewModel {
    if ([viewModel isKindOfClass:[ASCSearchViewModel class]]) {
        [self.searchResultsView.searchTableView reloadData];
    } else if ([viewModel isKindOfClass:[ASCSearchResultsViewModel class]]) {
        [self.cachedResultsTableViewCellHeights removeAllObjects];
        [self.searchResultsView.searchResultsTableView reloadData];
        [self.searchResultsView.searchResultsTableView setContentOffset:CGPointZero];
        [self.searchResultsView stopLoadingAnimation];
    }
}

#pragma mark - Notifications
- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    __weak ASCSearchResultsViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.searchResultsView expandToKeyboardHeight:keyboardSize.height];
    });
}

- (void)keyboardWillHide:(NSNotification *)notification {
    __weak ASCSearchResultsViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.searchResultsView contract];
    });
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

#pragma mark - ASCSearchBarDelegate
- (void)searchBar:(ASCSearchBar *)searchBar didChangeToSearchOptionIndex:(NSInteger)idx {
    self.searchResultsViewModel.queryType = idx;
    [self presentResults];
}

@end
