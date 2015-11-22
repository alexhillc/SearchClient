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
#import "ASCSearchTableViewDelegateAndDatasource.h"
#import "ASCSearchResultsViewModel.h"

#import "ASCTableViewSearchResultCell.h"

@interface ASCSearchResultsViewController () <UITextFieldDelegate, ASCViewModelDelegate>

@property (weak) ASCSearchResultsView *searchResultsView;

@end

@implementation ASCSearchResultsViewController

- (void)loadView {
    [super loadView];
    
    self.view = [[ASCSearchResultsView alloc] init];
    self.searchResultsView = (ASCSearchResultsView *)self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchTableViewDD = [[ASCSearchTableViewDelegateAndDatasource alloc] init];
    self.searchTableViewDD.vc = self;
    self.searchResultsView.searchTableView.delegate = self.searchTableViewDD;
    self.searchResultsView.searchTableView.dataSource = self.searchTableViewDD;
    
    self.searchResultsTableViewDD = [[ASCSearchResultsTableViewDelegateAndDatasource alloc] init];
    self.searchResultsTableViewDD.vc = self;
    self.searchResultsView.searchResultsTableView.delegate = self.searchResultsTableViewDD;
    self.searchResultsView.searchResultsTableView.dataSource = self.searchResultsTableViewDD;
    
    self.searchViewModel.delegate = self;
    self.searchResultsViewModel.delegate = self;
    
    [self.searchResultsView.searchResultsTableView registerClass:[ASCTableViewSearchResultCell class] forCellReuseIdentifier:ASCTableViewSearchResultCellIdentifier];
    
    [self.searchResultsView startLoadingAnimation];
    [self.searchResultsViewModel loadResultsWithQueryType:ASCQueryTypeWeb];
    self.searchResultsView.searchTextField.text = self.searchResultsViewModel.query;
    
    [self.searchViewModel loadSearchHistory];
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

- (void)presentResultsForQuery:(NSString *)query {
    [self.searchResultsView startLoadingAnimation];
    self.searchResultsViewModel.query = query;
    self.searchResultsView.searchTextField.text = self.searchResultsViewModel.query;
    
    [self.searchResultsView contract];
    [self.searchResultsViewModel loadResultsWithQueryType:ASCQueryTypeWeb];
}

#pragma mark - ASCViewModelDelegate
- (void)viewModelDidReceiveNewDataSet:(ASCViewModel *)viewModel {
    if ([viewModel isKindOfClass:[ASCSearchViewModel class]]) {
        [self.searchResultsView.searchTableView reloadData];
    } else if ([viewModel isKindOfClass:[ASCSearchResultsViewModel class]]) {
        [self.searchResultsView.searchResultsTableView reloadData];
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

@end
