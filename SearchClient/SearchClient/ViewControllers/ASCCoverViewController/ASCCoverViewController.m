//
//  ASCCoverViewController.m
//  SearchClient
//
//  Created by Alex Hill on 10/21/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCCoverViewController.h"
#import "ASCCoverView.h"
#import "ASCSearchResultsViewController.h"
#import "ASCSearchResultsViewModel.h"

@interface ASCCoverViewController ()

@property (nonatomic, strong) ASCCoverView *ascView;

@end

@implementation ASCCoverViewController

@dynamic ascView;

- (void)loadView {    
    self.view = [[ASCCoverView alloc] init];
    self.ascView = (ASCCoverView *)self.view;
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.presentedViewControllerSnapshotView = [self.view snapshotViewAfterScreenUpdates:YES];
}

- (BOOL)prefersStatusBarHidden {
    BOOL shouldHide = ![self.ascView isExpanded];
    
    return shouldHide;
}

#pragma mark - ASCTextFieldDelegate
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
    [self.ascView.searchHistoryTableView reloadData];
}

- (void)viewModelDidFailToLoadDataSet:(ASCViewModel *)viewModel error:(NSError *)error {
    // error here
}

#pragma mark - Notifications
- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    __weak ASCCoverViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.ascView expandToHeight:keyboardSize.height completion:^{
            [UIView animateWithDuration:ASCViewAnimationDuration animations:^{
                [weakSelf setNeedsStatusBarAppearanceUpdate];
            }];
        }];
    });
}

- (void)keyboardWillHide:(NSNotification *)notification {
    __weak ASCCoverViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.ascView contract];
        
        [UIView animateWithDuration:ASCViewAnimationDuration animations:^{
            [weakSelf setNeedsStatusBarAppearanceUpdate];
        }];
    });
}

- (void)presentViewControllerWithQuery:(NSString *)query {
    ASCSearchHistoryViewModel *searchHistoryViewModel = [[ASCSearchHistoryViewModel alloc] init];
    ASCSearchResultsViewModel *searchResultsViewModel = [[ASCSearchResultsViewModel alloc] init];
    searchResultsViewModel.query = query;
    
    ASCSearchResultsViewController *searchResultsViewController = [[ASCSearchResultsViewController alloc] init];
    searchResultsViewController.searchResultsViewModel = searchResultsViewModel;
    searchResultsViewController.searchHistoryViewModel = searchHistoryViewModel;
    searchResultsViewController.snapshotView = self.presentedViewControllerSnapshotView;
    
    self.ascView.searchBar.textField.text = query;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    __weak ASCCoverViewController *weakSelf = self;
    [self.ascView hideSearchHistoryTableViewAnimated:YES completion:^{
        [weakSelf presentViewController:searchResultsViewController animated:NO completion:^{
            [weakSelf.ascView restoreToOriginalState];
        }];
    }];
}

@end
