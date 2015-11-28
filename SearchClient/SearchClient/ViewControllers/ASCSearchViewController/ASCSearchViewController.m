//
//  ASCSearchViewController.m
//  SearchClient
//
//  Created by Alex Hill on 10/21/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchViewController.h"
#import "ASCSearchResultsViewController.h"
#import "ASCSearchResultsViewModel.h"
#import "ASCSearchView.h"

@interface ASCSearchViewController ()

@property (nonatomic, weak) ASCSearchView *searchView;

@end

@implementation ASCSearchViewController

- (void)loadView {    
    self.view = [[ASCSearchView alloc] init];
    self.searchView = (ASCSearchView *)self.view;
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
    [self presentViewControllerWithQuery:textField.text];
    
    return YES;
}

- (void)textFieldDidCancel:(ASCTextField *)textField {
    textField.text = @"";
    [textField endEditing:YES];
}

#pragma mark - ASCViewModelDelegate
- (void)viewModelDidReceiveNewDataSet:(ASCViewModel *)viewModel {
    [self.searchView.searchTableView reloadData];
}

- (void)viewModelDidFailToLoadDataSet:(ASCViewModel *)viewModel error:(NSError *)error {
    // error here
}

#pragma mark - Notifications
- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    __weak ASCSearchViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.searchView expandToKeyboardHeight:keyboardSize.height];
        
        [UIView animateWithDuration:ASCViewAnimationDuration delay:ASCViewAnimationDuration
                            options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                [weakSelf setNeedsStatusBarAppearanceUpdate];
                            } completion:nil];
    });
}

- (void)keyboardWillHide:(NSNotification *)notification {
    __weak ASCSearchViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.searchView contract];
        
        [UIView animateWithDuration:ASCViewAnimationDuration animations:^{
            [weakSelf setNeedsStatusBarAppearanceUpdate];
        }];
    });
}

- (void)presentViewControllerWithQuery:(NSString *)query {
    ASCSearchViewModel *searchViewModel = [[ASCSearchViewModel alloc] init];
    ASCSearchResultsViewModel *searchResultsViewModel = [[ASCSearchResultsViewModel alloc] init];
    searchResultsViewModel.query = query;
    
    ASCSearchResultsViewController *searchResultsViewController = [[ASCSearchResultsViewController alloc] init];
    searchResultsViewController.searchResultsViewModel = searchResultsViewModel;
    searchResultsViewController.searchViewModel = searchViewModel;
    
    self.searchView.searchBar.textField.text = query;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    __weak ASCSearchViewController *weakSelf = self;
    [self.searchView hideSearchTableViewAnimated:YES completion:^{
        [weakSelf presentViewController:searchResultsViewController animated:NO completion:nil];
    }];
}

@end
