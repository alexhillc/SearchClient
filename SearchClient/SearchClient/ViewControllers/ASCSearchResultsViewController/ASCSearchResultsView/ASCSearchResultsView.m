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
    self.searchResultsTableView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.searchResultsTableView];
    
    self.loadingSpinner = [[DRPLoadingSpinner alloc] init];
    self.loadingSpinner.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.loadingSpinner];
    
    [self bringSubviewToFront:self.shadowSearchTableView];
    [self bringSubviewToFront:self.searchTableView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.isFirstLayout) {
        // searchTextField constraints
        self.searchTextFieldConstraintTop = [self.searchTextField asc_pinEdge:NSLayoutAttributeTop toParentEdge:NSLayoutAttributeTop
                                                                     constant:ASCViewTextFieldExpandedOffsetY];
        self.searchTextFieldConstraintHeight = [self.searchTextField asc_setAttribute:NSLayoutAttributeHeight toConstant:ASCViewTextFieldHeight];
        self.searchTextFieldConstraintWidth = [self.searchTextField asc_setAttribute:NSLayoutAttributeWidth toConstant:self.bounds.size.width * ASCViewTextFieldExpandedMultiplierWidth];
        self.searchTextFieldConstraintCenter = [self.searchTextField asc_centerHorizontallyInParent];
        
        // searchTableView constraints
        self.searchTableViewConstraintTop = [self.searchTableView asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeBottom
                                                                    ofSibling:self.searchTextField constant:5.];
        self.searchTableViewConstraintHeight = [self.searchTableView asc_setAttribute:NSLayoutAttributeHeight toConstant:0.];
        self.searchTableViewConstraintWidth = [self.searchTableView asc_setAttribute:NSLayoutAttributeWidth toConstant:self.bounds.size.width * ASCViewTextFieldContractedMultiplierWidth];
        self.searchTableViewConstraintCenter = [self.searchTableView asc_centerHorizontallyInParent];
        
        // shadowSearchTableView constraints
        [self.shadowSearchTableView asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeTop ofSibling:self.searchTableView constant:0];
        [self.shadowSearchTableView asc_pinEdge:NSLayoutAttributeLeft toEdge:NSLayoutAttributeLeft ofSibling:self.searchTableView constant:0];
        [self.shadowSearchTableView asc_pinEdge:NSLayoutAttributeRight toEdge:NSLayoutAttributeRight ofSibling:self.searchTableView constant:0];
        [self.shadowSearchTableView asc_pinEdge:NSLayoutAttributeBottom toEdge:NSLayoutAttributeBottom ofSibling:self.searchTableView constant:0];
        
        // searchResultsTableView constraints
        self.searchResultsTableViewConstraintTop = [self.searchResultsTableView asc_pinEdge:NSLayoutAttributeTop toParentEdge:NSLayoutAttributeTop
                                                                                   constant:ASCViewTextFieldExpandedOffsetY + ASCViewTextFieldHeight + 5.];
        self.searchResultsTableViewConstraintBottom = [self.searchResultsTableView asc_pinEdge:NSLayoutAttributeBottom toParentEdge:NSLayoutAttributeBottom
                                                                                      constant:-5.];
        self.searchResultsTableViewConstraintWidth = [self.searchResultsTableView asc_setAttribute:NSLayoutAttributeWidth toConstant:self.bounds.size.width * ASCViewTextFieldExpandedMultiplierWidth];
        self.searchResultsTableViewConstraintCenter = [self.searchResultsTableView asc_centerHorizontallyInParent];
        
        [self.loadingSpinner asc_pinEdge:NSLayoutAttributeCenterX toEdge:NSLayoutAttributeCenterX ofSibling:self.searchResultsTableView constant:0.];
        [self.loadingSpinner asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeTop ofSibling:self.searchResultsTableView constant:30.];
        
        self.isFirstLayout = NO;
    }
}

- (void)expandToKeyboardHeight:(CGFloat)keyboardHeight {
    [self layoutIfNeeded];
    
    self.searchTableViewConstraintHeight.constant = self.bounds.size.height - keyboardHeight - ASCViewTableViewExpandedOffsetY - 10.0;
    self.searchTableView.hidden = NO;
    self.shadowSearchTableView.hidden = NO;
    
    __weak ASCSearchResultsView *weakSelf = self;
    
    [UIView animateWithDuration:ASCViewAnimationDuration animations:^{
        weakSelf.searchResultsTableView.alpha = 0.5;
        [weakSelf layoutIfNeeded];
    }];
}

- (void)contract {
    [self layoutIfNeeded];
    
    [self endEditing:YES];
    self.searchTableViewConstraintHeight.constant = 0;
    
    __weak ASCSearchResultsView *weakSelf = self;
    
    [UIView animateWithDuration:ASCViewAnimationDuration animations:^{
        weakSelf.searchResultsTableView.alpha = 1;
        [weakSelf layoutIfNeeded];
    } completion:^(BOOL finished) {
        weakSelf.searchTableView.hidden = YES;
        weakSelf.shadowSearchTableView.hidden = YES;
    }];
}

- (void)updateConstraints {
    [super updateConstraints];
    
    self.searchTextFieldConstraintWidth.constant = self.bounds.size.width * ASCViewTextFieldExpandedMultiplierWidth;
    self.searchTableViewConstraintWidth.constant = self.bounds.size.width * ASCViewTextFieldExpandedMultiplierWidth;
    self.searchResultsTableViewConstraintWidth.constant = self.bounds.size.width * ASCViewTextFieldExpandedMultiplierWidth;
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
    return !self.searchTableView.hidden;
}

@end
