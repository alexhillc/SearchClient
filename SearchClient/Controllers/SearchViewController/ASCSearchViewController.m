//
//  ASCSearchViewController.m
//  SearchClient
//
//  Created by Alex Hill on 10/21/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchViewController.h"
#import "ASCSearchView.h"
#import "ASCTableView.h"
#import "ASCTableViewSearchCell.h"

@interface ASCSearchViewController () <UITableViewDataSource, UITableViewDelegate>

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
    
    self.searchView.searchTableView.delegate = self;
    self.searchView.searchTableView.dataSource = self;
    
    [self.searchView.searchTableView registerClass:[ASCTableViewSearchCell class] forCellReuseIdentifier:@"ASCTableViewSearchCellIdentifier"];
    
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
    BOOL shouldHide = self.searchView.state == ASCSearchViewSearchStateInactive;
    
    return shouldHide;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self.view setNeedsUpdateConstraints];
}

#pragma mark - UITableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ASCTableViewSearchCellIdentifier = @"ASCTableViewSearchCellIdentifier";
    
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
    
    [self.searchView expandToKeyboardHeight:keyboardSize.height];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    });
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self.searchView contract];

    [UIView animateWithDuration:0.2 animations:^{
        [self setNeedsStatusBarAppearanceUpdate];
    }];
}


@end
