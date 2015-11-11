//
//  ASCSearchView.m
//  SearchClient
//
//  Created by Alex Hill on 10/19/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchView.h"
#import "ASCTextField.h"
#import "ASCTableView.h"

#define GoogleBlue [UIColor colorWithRed:72.0/255.0 green:133.0/255.0 blue:237.0/255.0 alpha:1.0]
#define ASCSearchViewBackgroundColor [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0]

const CGFloat ASCSearchTextFieldHeight = 40.0;
const CGFloat ASCSearchTableViewExpandedOffsetY = 69.0;
const CGFloat ASCSearchTextFieldExpandedOffsetY = 24.0;
const CGFloat ASCSearchTextFieldContractedMultiplierOffsetY = 0.48;
const CGFloat ASCSearchTextFieldContractedMultiplierWidth = 0.75;
const CGFloat ASCSearchTextFieldExpandedMultiplierWidth = 0.95;
const NSTimeInterval ASCSearchViewAnimationDuration = 0.2;

@interface ASCSearchView()

@property (nonatomic, assign) ASCSearchViewSearchState state;
@property (nonatomic, assign) BOOL isFirstLayout;

@property (nonatomic, weak) NSLayoutConstraint *searchTextFieldConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *searchTextFieldConstraintHeight;
@property (nonatomic, weak) NSLayoutConstraint *searchTextFieldConstraintWidth;
@property (nonatomic, weak) NSLayoutConstraint *searchTextFieldConstraintCenter;
@property (nonatomic, weak) NSLayoutConstraint *searchTableViewConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *searchTableViewConstraintHeight;
@property (nonatomic, weak) NSLayoutConstraint *searchTableViewConstraintWidth;
@property (nonatomic, weak) NSLayoutConstraint *searchTableViewConstraintCenter;
@property (nonatomic, weak) NSLayoutConstraint *titleLabelSecondaryConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *titleLabelSecondaryConstraintCenter;
@property (nonatomic, weak) NSLayoutConstraint *titleLabelPrimaryConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *titleLabelPrimaryConstraintCenter;

@end

@implementation ASCSearchView

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.isFirstLayout = YES;
    
    self.backgroundColor = ASCSearchViewBackgroundColor;
    
    self.searchTextField = [[ASCTextField alloc] init];
    self.searchTextField.horizontalPadding = 10.0;
    self.searchTextField.cancelButtonColor = GoogleBlue;
    self.searchTextField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.searchTextField];
    
    self.searchTableView = [[ASCTableView alloc] init];
    self.searchTableView.alpha = 0;
    self.searchTableView.hidden = YES;
    self.searchTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.searchTableView];
    
    self.titleLabelSecondary = [[UILabel alloc] init];
    self.titleLabelSecondary.font = [UIFont systemFontOfSize:12];
    self.titleLabelSecondary.text = @"SEARCH API";
    self.titleLabelSecondary.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.titleLabelSecondary];
    
    self.titleLabelPrimary = [[UILabel alloc] init];
    self.titleLabelPrimary.font = [UIFont boldSystemFontOfSize:42];
    self.titleLabelPrimary.textColor = GoogleBlue;
    self.titleLabelPrimary.text = @"Google";
    self.titleLabelPrimary.translatesAutoresizingMaskIntoConstraints = NO;

    [self addSubview:self.titleLabelPrimary];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.isFirstLayout) {
        // searchTextField constraints
        self.searchTextFieldConstraintTop = [self.searchTextField asc_pinEdge:NSLayoutAttributeTop toParentEdge:NSLayoutAttributeTop
                                 constant:self.bounds.size.height * ASCSearchTextFieldContractedMultiplierOffsetY];
        self.searchTextFieldConstraintHeight = [self.searchTextField asc_setAttribute:NSLayoutAttributeHeight toConstant:ASCSearchTextFieldHeight];
        self.searchTextFieldConstraintWidth = [self.searchTextField asc_setAttribute:NSLayoutAttributeWidth toConstant:self.bounds.size.width * ASCSearchTextFieldContractedMultiplierWidth];
        self.searchTextFieldConstraintCenter = [self.searchTextField asc_centerHorizontallyInParent];
        
        // searchTableView constraints
        self.searchTableViewConstraintTop = [self.searchTableView asc_pinEdge:NSLayoutAttributeTop toParentEdge:NSLayoutAttributeTop constant:ASCSearchTableViewExpandedOffsetY];
        self.searchTableViewConstraintHeight = [self.searchTableView asc_setAttribute:NSLayoutAttributeHeight toConstant:self.bounds.size.height * 0.35];
        self.searchTableViewConstraintWidth = [self.searchTableView asc_setAttribute:NSLayoutAttributeWidth toConstant:self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth];
        self.searchTableViewConstraintCenter = [self.searchTableView asc_centerHorizontallyInParent];
        
        // titleLabelSecondary constraints
        self.titleLabelSecondaryConstraintTop = [self.titleLabelSecondary asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeTop ofSibling:self.searchTextField constant:-40.];
        self.titleLabelSecondaryConstraintCenter = [self.titleLabelSecondary asc_centerHorizontallyInParent];
        
        // titleLabelPrimary constraints
        self.titleLabelPrimaryConstraintTop = [self.titleLabelPrimary asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeTop ofSibling:self.titleLabelSecondary constant:-53.];
        self.titleLabelPrimaryConstraintCenter = [self.titleLabelPrimary asc_centerHorizontallyInParent];
        
        self.isFirstLayout = NO;
    } 
}

- (void)updateConstraints {
    [super updateConstraints];
    
    // Update constraints based on search state
    if (self.state == ASCSearchViewSearchStateInactive) {
        self.searchTextFieldConstraintTop.constant = self.bounds.size.height * ASCSearchTextFieldContractedMultiplierOffsetY;
        self.searchTextFieldConstraintWidth.constant = self.bounds.size.width * ASCSearchTextFieldContractedMultiplierWidth;
        self.searchTableViewConstraintWidth.constant = self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth;
    } else {
        self.searchTextFieldConstraintWidth.constant = self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth;
        self.searchTableViewConstraintWidth.constant = self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth;
    }
}

#pragma mark - Helper methods
- (void)expandToKeyboardHeight:(CGFloat)keyboardHeight {
    self.state = ASCSearchViewSearchStateActive;

    [self layoutIfNeeded];

    self.searchTextFieldConstraintTop.constant = ASCSearchTextFieldExpandedOffsetY;
    self.searchTextFieldConstraintWidth.constant = self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth;
    self.searchTableViewConstraintHeight.constant = self.bounds.size.height - keyboardHeight - ASCSearchTableViewExpandedOffsetY - 10.0;
    
    __weak ASCSearchView *weakSelf = self;
    
    [UIView animateWithDuration:ASCSearchViewAnimationDuration animations:^{
        [weakSelf layoutIfNeeded];
    } completion:^(BOOL finished) {
        weakSelf.titleLabelSecondary.hidden = YES;
        weakSelf.titleLabelPrimary.hidden = YES;
        
        [UIView animateWithDuration:ASCSearchViewAnimationDuration animations:^{
            weakSelf.searchTableView.hidden = NO;
            weakSelf.searchTableView.alpha = 1;
        }];
    }];
}

- (void)contract {
    self.state = ASCSearchViewSearchStateInactive;
    
    __weak ASCSearchView *weakSelf = self;
    [UIView animateWithDuration:ASCSearchViewAnimationDuration animations:^{
        weakSelf.searchTableView.alpha = 0;
    } completion:^(BOOL finished) {
        weakSelf.searchTableView.hidden = YES;
        
        weakSelf.titleLabelSecondary.hidden = NO;
        weakSelf.titleLabelPrimary.hidden = NO;
        
        [weakSelf layoutIfNeeded];
        
        weakSelf.searchTextFieldConstraintTop.constant = weakSelf.bounds.size.height * ASCSearchTextFieldContractedMultiplierOffsetY;
        weakSelf.searchTextFieldConstraintWidth.constant = weakSelf.bounds.size.width * ASCSearchTextFieldContractedMultiplierWidth;
        
        [UIView animateWithDuration:ASCSearchViewAnimationDuration animations:^{
            [weakSelf layoutIfNeeded];
        }];
    }];
}

@end
