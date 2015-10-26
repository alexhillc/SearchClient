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
        self.searchTextFieldConstraintTop = [NSLayoutConstraint constraintWithItem:self.searchTextField attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop
                                                                        multiplier:1.0 constant:self.bounds.size.height * ASCSearchTextFieldContractedMultiplierOffsetY];
        [self addConstraint:self.searchTextFieldConstraintTop];
        
        self.searchTextFieldConstraintHeight = [NSLayoutConstraint constraintWithItem:self.searchTextField attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1.0 constant:ASCSearchTextFieldHeight];
        [self addConstraint:self.searchTextFieldConstraintHeight];
        
        self.searchTextFieldConstraintWidth = [NSLayoutConstraint constraintWithItem:self.searchTextField attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                                          multiplier:1.0 constant:self.bounds.size.width * ASCSearchTextFieldContractedMultiplierWidth];
        [self addConstraint:self.searchTextFieldConstraintWidth];
        
        self.searchTextFieldConstraintCenter = [NSLayoutConstraint constraintWithItem:self.searchTextField attribute:NSLayoutAttributeCenterX
                                                                            relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX
                                                                           multiplier:1.0 constant:0];
        [self addConstraint:self.searchTextFieldConstraintCenter];
        
        // searchTableView constraints
        self.searchTableViewConstraintTop = [NSLayoutConstraint constraintWithItem:self.searchTableView attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop
                                                                        multiplier:1.0 constant:ASCSearchTableViewExpandedOffsetY];
        [self addConstraint:self.searchTableViewConstraintTop];
        
        self.searchTableViewConstraintHeight = [NSLayoutConstraint constraintWithItem:self.searchTableView attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1.0 constant:self.bounds.size.height * 0.35];
        [self addConstraint:self.searchTableViewConstraintHeight];
        
        self.searchTableViewConstraintWidth = [NSLayoutConstraint constraintWithItem:self.searchTableView attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                                          multiplier:1.0 constant:self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth];
        [self addConstraint:self.searchTableViewConstraintWidth];
        
        self.searchTableViewConstraintCenter = [NSLayoutConstraint constraintWithItem:self.searchTableView attribute:NSLayoutAttributeCenterX
                                                                            relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX
                                                                           multiplier:1.0 constant:0];
        [self addConstraint:self.searchTableViewConstraintCenter];
        
        // titleLabelSecondary constraints
        self.titleLabelSecondaryConstraintTop = [NSLayoutConstraint constraintWithItem:self.titleLabelSecondary attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual toItem:self.searchTextField attribute:NSLayoutAttributeTop
                                                                            multiplier:1.0 constant:-40.0];
        [self addConstraint:self.titleLabelSecondaryConstraintTop];
        
        self.titleLabelSecondaryConstraintCenter = [NSLayoutConstraint constraintWithItem:self.titleLabelSecondary attribute:NSLayoutAttributeCenterX
                                                                                relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX
                                                                               multiplier:1.0 constant:0];
        [self addConstraint:self.titleLabelSecondaryConstraintCenter];
        
        // titleLabelPrimary constraints
        self.titleLabelPrimaryConstraintTop = [NSLayoutConstraint constraintWithItem:self.titleLabelPrimary attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual toItem:self.titleLabelSecondary attribute:NSLayoutAttributeTop
                                                                          multiplier:1.0 constant:-53.0];
        [self addConstraint:self.titleLabelPrimaryConstraintTop];
        
        self.titleLabelPrimaryConstraintCenter = [NSLayoutConstraint constraintWithItem:self.titleLabelPrimary attribute:NSLayoutAttributeCenterX
                                                                              relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX
                                                                             multiplier:1.0 constant:0];
        [self addConstraint:self.titleLabelPrimaryConstraintCenter];
        
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
