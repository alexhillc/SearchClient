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
#import "ASCTableViewSearchCell.h"
#import "ASCSearchResultsViewModel.h"
#import "ASCSearchResultsViewController.h"

@interface ASCSearchViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *tableData;
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
    
    self.searchView.tableView.delegate = self;
    self.searchView.tableView.dataSource = self;
    self.searchView.searchTextField.delegate = self;
    
    [self.searchView.tableView registerClass:[ASCTableViewSearchCell class] forCellReuseIdentifier:ASCTableViewSearchCellIdentifier];
    
    // Sample data
    self.tableData = [[NSMutableArray alloc] initWithObjects:@"One", @"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", @"Eight", @"Nine", @"Ten", nil];
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
    BOOL shouldHide = ![self.searchView isSearching];
    
    return shouldHide;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    ASCSearchResultsViewModel *vm = [[ASCSearchResultsViewModel alloc] init];
    vm.query = textField.text;
    vm.title = @"Results";
    
    ASCSearchResultsViewController *vc = [[ASCSearchResultsViewController alloc] init];
    vc.viewModel = vm;
    
    [self presentViewController:vc animated:YES completion:nil];
    
    return YES;
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASCTableViewSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:ASCTableViewSearchCellIdentifier];
    if (!cell) {
        cell = [[ASCTableViewSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ASCTableViewSearchCellIdentifier];
    }
    
    cell.textLabel.text = [self.tableData objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableData count];
}

#pragma mark - Notifications
- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.searchView expandToKeyboardHeight:keyboardSize.height];
        
        __weak ASCSearchViewController *weakSelf = self;
        [UIView animateWithDuration:ASCSearchViewAnimationDuration delay:ASCSearchViewAnimationDuration
                            options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [weakSelf setNeedsStatusBarAppearanceUpdate];
        } completion:nil];
    });
}

- (void)keyboardWillHide:(NSNotification *)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.searchView contract];
        
        __weak ASCSearchViewController *weakSelf = self;
        [UIView animateWithDuration:ASCSearchViewAnimationDuration animations:^{
            [weakSelf setNeedsStatusBarAppearanceUpdate];
        }];
    });
}

@end
