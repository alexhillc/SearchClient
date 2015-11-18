//
//  ASCSearchViewController.m
//  SearchClient
//
//  Created by Alex Hill on 10/21/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchViewController.h"
#import "ASCSearchView.h"
#import "ASCTextField.h"
#import "ASCTableView.h"

#import "ASCSearchResultsViewModel.h"
#import "ASCSearchViewModel.h"

#import "ASCTableViewSearchCell.h"
#import "ASCTableViewSearchResultCell.h"

#import "ASCSearchTableViewDelegateAndDatasource.h"
#import "ASCSearchResultsTableViewDelegateAndDatasource.h"

#import <SafariServices/SafariServices.h>

@interface ASCSearchViewController () <UITextFieldDelegate, ASCSearchResultsTableViewDDDelegate, ASCSearchTableViewDDDelegate, ASCViewModelDelegate>

@property (nonatomic) ASCSearchTableViewDelegateAndDatasource *searchTableViewDD;
@property (nonatomic) ASCSearchResultsTableViewDelegateAndDatasource *searchResultsTableViewDD;
@property (weak) ASCSearchView *searchView;

@end

@implementation ASCSearchViewController

- (void)loadView {
    [super loadView];
    
    self.view = [[ASCSearchView alloc] init];
    self.searchView = (ASCSearchView *)self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchTableViewDD = [[ASCSearchTableViewDelegateAndDatasource alloc] init];
    self.searchTableViewDD.viewModel = [[ASCSearchViewModel alloc] init];
    self.searchTableViewDD.viewModel.delegate = self;
    self.searchTableViewDD.delegate = self;
    self.searchView.searchTableView.delegate = self.searchTableViewDD;
    self.searchView.searchTableView.dataSource = self.searchTableViewDD;
    [self.searchTableViewDD.viewModel loadSearchHistory];
    
    self.searchResultsTableViewDD = [[ASCSearchResultsTableViewDelegateAndDatasource alloc] init];
    self.searchResultsTableViewDD.viewModel = [[ASCSearchResultsViewModel alloc] init];
    self.searchResultsTableViewDD.viewModel.delegate = self;
    self.searchResultsTableViewDD.delegate = self;
    self.searchView.searchResultsTableView.delegate = self.searchResultsTableViewDD;
    self.searchView.searchResultsTableView.dataSource = self.searchResultsTableViewDD;
    
    [self.searchView.searchTableView registerClass:[ASCTableViewSearchCell class] forCellReuseIdentifier:ASCTableViewSearchCellIdentifier];
    [self.searchView.searchResultsTableView registerClass:[ASCTableViewSearchResultCell class] forCellReuseIdentifier:ASCTableViewSearchResultCellIdentifier];
    
    self.searchView.searchTextField.delegate = self;
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
    BOOL shouldHide = ![self.searchView isExpanded];
    
    return shouldHide;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.searchResultsTableViewDD.viewModel.query = textField.text;
    [self.searchResultsTableViewDD.viewModel loadResultsWithQueryType:ASCQueryTypeWeb];
    self.searchView.searchTableView.hidden = YES;
    self.searchView.shadowSearchTableView.hidden = YES;
    [self.searchView startLoadingAnimation];
    
    return YES;
}

#pragma mark - Delegate and datasource delegate
- (void)ddDelegate:(ASCSearchTableViewDelegateAndDatasource *)ddDelegate didSelectText:(NSString *)text {
    self.searchResultsTableViewDD.viewModel.query = text;
    [self.searchResultsTableViewDD.viewModel loadResultsWithQueryType:ASCQueryTypeWeb];
    
    [self.searchView.searchTextField endEditing:YES];
}

- (void)ddDelegate:(ASCSearchResultsTableViewDelegateAndDatasource *)ddDelegate didSelectUrl:(NSURL *)url {
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

- (void)viewModelDidReceiveNewDataSet:(ASCViewModel *)viewModel {
    [self.searchView stopLoadingAnimation];
    [self.searchView.searchResultsTableView reloadData];
}

- (void)viewModelDidFailToLoadDataSet:(ASCViewModel *)viewModel error:(NSError *)error {
    [self.searchView stopLoadingAnimation];
}

#pragma mark - Notifications
- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    if (![self.searchView isDisplayingResults]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.searchView expandToKeyboardHeight:keyboardSize.height];
            
            __weak ASCSearchViewController *weakSelf = self;
            [UIView animateWithDuration:ASCSearchViewAnimationDuration delay:ASCSearchViewAnimationDuration
                                options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                    [weakSelf setNeedsStatusBarAppearanceUpdate];
                                } completion:nil];
        });
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    if (![self.searchView isDisplayingResults]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.searchView contract];
            
            __weak ASCSearchViewController *weakSelf = self;
            [UIView animateWithDuration:ASCSearchViewAnimationDuration animations:^{
                [weakSelf setNeedsStatusBarAppearanceUpdate];
            }];
        });
    }
}

@end
