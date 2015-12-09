//
//  ASCSearchResultsVIew.m
//  SearchClient
//
//  Created by Alex Hill on 11/21/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchResultsView.h"
#import "DRPLoadingSpinner.h"

@interface ASCSearchResultsView ()

@property DRPLoadingSpinner *loadingSpinner;

@property (nonatomic, weak) NSLayoutConstraint *searchResultsTableViewConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *searchResultsTableViewConstraintBottom;
@property (nonatomic, weak) NSLayoutConstraint *searchResultsTableViewConstraintWidth;
@property (nonatomic, weak) NSLayoutConstraint *searchResultsTableViewConstraintCenter;

@end

@implementation ASCSearchResultsView

- (void)setup {
    [super setup];
    
    self.searchResultsTableView = [[ASCTableView alloc] init];
    self.searchResultsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchResultsTableView.bounces = NO;
    self.searchResultsTableView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.searchResultsTableView];
    
    self.loadingSpinner = [[DRPLoadingSpinner alloc] init];
    self.loadingSpinner.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.loadingSpinner];

    [self bringSubviewToFront:self.searchBar];
    [self bringSubviewToFront:self.shadowSearchHistoryTableView];
    [self bringSubviewToFront:self.searchHistoryTableView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.isFirstLayout) {        
        // searchBar constraints
        self.searchBarConstraintTop = [self.searchBar asc_pinEdge:NSLayoutAttributeTop toParentEdge:NSLayoutAttributeTop
                                                                     constant:ASCViewTextFieldExpandedOffsetY];
        self.searchBarConstraintHeight = [self.searchBar asc_setAttribute:NSLayoutAttributeHeight toConstant:self.searchBar.intrinsicContentSize.height];
        self.searchBarConstraintWidth = [self.searchBar asc_setAttribute:NSLayoutAttributeWidth toConstant:self.bounds.size.width * ASCViewTextFieldExpandedMultiplierWidth];
        self.searchBarConstraintCenter = [self.searchBar asc_centerHorizontallyInParent];
        
        // shadowSearchBar constraints
        [self.shadowSearchBar asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeTop ofSibling:self.searchBar constant:0];
        [self.shadowSearchBar asc_pinEdge:NSLayoutAttributeLeft toEdge:NSLayoutAttributeLeft ofSibling:self.searchBar constant:0];
        [self.shadowSearchBar asc_pinEdge:NSLayoutAttributeRight toEdge:NSLayoutAttributeRight ofSibling:self.searchBar constant:0];
        [self.shadowSearchBar asc_pinEdge:NSLayoutAttributeBottom toEdge:NSLayoutAttributeBottom ofSibling:self.searchBar constant:0];
        
        // searchHistoryTableView constraints
        self.searchHistoryTableViewConstraintTop = [self.searchHistoryTableView asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeBottom
                                                                    ofSibling:self.searchBar constant:1.];
        self.searchHistoryTableViewConstraintHeight = [self.searchHistoryTableView asc_setAttribute:NSLayoutAttributeHeight toConstant:0.];
        self.searchHistoryTableViewConstraintWidth = [self.searchHistoryTableView asc_setAttribute:NSLayoutAttributeWidth toConstant:self.bounds.size.width * ASCViewTextFieldExpandedMultiplierWidth];
        self.searchHistoryTableViewConstraintCenter = [self.searchHistoryTableView asc_centerHorizontallyInParent];
        
        // shadowSearchHistoryTableView constraints
        [self.shadowSearchHistoryTableView asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeTop ofSibling:self.searchHistoryTableView constant:0];
        [self.shadowSearchHistoryTableView asc_pinEdge:NSLayoutAttributeLeft toEdge:NSLayoutAttributeLeft ofSibling:self.searchHistoryTableView constant:0];
        [self.shadowSearchHistoryTableView asc_pinEdge:NSLayoutAttributeRight toEdge:NSLayoutAttributeRight ofSibling:self.searchHistoryTableView constant:0];
        [self.shadowSearchHistoryTableView asc_pinEdge:NSLayoutAttributeBottom toEdge:NSLayoutAttributeBottom ofSibling:self.searchHistoryTableView constant:0];
        
        // searchResultsTableView constraints
        self.searchResultsTableViewConstraintTop = [self.searchResultsTableView asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeBottom
                                                                                  ofSibling:self.searchBar constant:7.];
        self.searchResultsTableViewConstraintBottom = [self.searchResultsTableView asc_pinEdge:NSLayoutAttributeBottom toParentEdge:NSLayoutAttributeBottom
                                                                                      constant:0.];
        self.searchResultsTableViewConstraintWidth = [self.searchResultsTableView asc_setAttribute:NSLayoutAttributeWidth toConstant:self.bounds.size.width * ASCViewTextFieldExpandedMultiplierWidth];
        self.searchResultsTableViewConstraintCenter = [self.searchResultsTableView asc_centerHorizontallyInParent];
        
        [self.loadingSpinner asc_pinEdge:NSLayoutAttributeCenterX toEdge:NSLayoutAttributeCenterX ofSibling:self.searchResultsTableView constant:0.];
        [self.loadingSpinner asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeTop ofSibling:self.searchResultsTableView constant:30.];
        
        self.isFirstLayout = NO;
    }
}

- (void)expandToHeight:(CGFloat)keyboardHeight completion:(void (^)(void))completion {
    [self layoutIfNeeded];
    
    CGFloat availableSpace = self.bounds.size.height - keyboardHeight - ASCViewTableViewExpandedOffsetY - 10.;
    if (availableSpace > self.searchHistoryTableView.contentSize.height) {
        self.searchHistoryTableViewConstraintHeight.constant = self.searchHistoryTableView.contentSize.height;
    } else {
        self.searchHistoryTableViewConstraintHeight.constant = availableSpace;
    }
    
    self.searchHistoryTableViewConstraintTop.constant = -40.;
    
    self.searchHistoryTableView.hidden = NO;
    self.shadowSearchHistoryTableView.hidden = NO;
    
    __weak ASCSearchResultsView *weakSelf = self;
    
    [UIView animateWithDuration:ASCViewAnimationDuration delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:1 options:0 animations:^{
        weakSelf.searchResultsTableView.alpha = 0.25;
        [weakSelf layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

- (void)contract {
    [self layoutIfNeeded];
    
    self.searchHistoryTableViewConstraintHeight.constant = 0;
    
    __weak ASCSearchResultsView *weakSelf = self;
    
    [UIView animateWithDuration:ASCViewAnimationDuration animations:^{
        weakSelf.searchResultsTableView.alpha = 1;
        [weakSelf layoutIfNeeded];
    } completion:^(BOOL finished) {
        weakSelf.searchHistoryTableView.hidden = YES;
        weakSelf.shadowSearchHistoryTableView.hidden = YES;
        weakSelf.searchHistoryTableViewConstraintTop.constant = 1.;
    }];
}

- (void)updateLayoutWithOrientation:(CGSize)screenSize {
    self.searchBarConstraintWidth.constant = screenSize.width * ASCViewTextFieldExpandedMultiplierWidth;
    self.searchHistoryTableViewConstraintWidth.constant = screenSize.width * ASCViewTextFieldExpandedMultiplierWidth;
    self.searchResultsTableViewConstraintWidth.constant = screenSize.width * ASCViewTextFieldExpandedMultiplierWidth;
}

- (void)startLoadingAnimation {
    self.searchResultsTableView.hidden = YES;
    self.loadingSpinner.hidden = NO;
    [self.loadingSpinner startAnimating];
}

- (void)stopLoadingAnimation {
    [self.loadingSpinner stopAnimating];
    self.loadingSpinner.hidden = YES;
    self.searchResultsTableView.hidden = NO;
}

- (BOOL)isDisplayingResults {
    return !self.searchResultsTableView.hidden || !self.loadingSpinner.hidden;
}

- (BOOL)isExpanded {
    return !self.searchHistoryTableView.hidden;
}

@end
