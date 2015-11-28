//
//  ASCSearchView.m
//  SearchClient
//
//  Created by Alex Hill on 10/19/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchView.h"
#import "ASCSearchResultsView.h"
#import "ASCCollectionView.h"

@interface ASCSearchView()

@property (nonatomic, weak) NSLayoutConstraint *titleLabelSecondaryConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *titleLabelSecondaryConstraintCenter;
@property (nonatomic, weak) NSLayoutConstraint *titleLabelPrimaryConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *titleLabelPrimaryConstraintCenter;

@end

@implementation ASCSearchView

- (void)setup {
    [super setup];
    
    self.searchTableView.alpha = 0;
    self.shadowSearchTableView.alpha = 0;
    
    self.searchBar.collectionView.hidden = YES;
    self.searchBar.dividerView.hidden = YES;
    
    self.titleLabelSecondary = [[UILabel alloc] init];
    self.titleLabelSecondary.font = [UIFont systemFontOfSize:12];
    self.titleLabelSecondary.text = @"SEARCH API";
    self.titleLabelSecondary.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.titleLabelSecondary];
    
    NSMutableAttributedString *titleLabelText = [[NSMutableAttributedString alloc] initWithString:@"Google"];
    [titleLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor googleBlueColor] range:NSMakeRange(0, 1)];
    [titleLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor googleRedColor] range:NSMakeRange(1, 1)];
    [titleLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor googleYellowColor] range:NSMakeRange(2, 1)];
    [titleLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor googleBlueColor] range:NSMakeRange(3, 1)];
    [titleLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor googleGreenColor] range:NSMakeRange(4, 1)];
    [titleLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor googleRedColor] range:NSMakeRange(5, 1)];
    
    self.titleLabelPrimary = [[UILabel alloc] init];
    self.titleLabelPrimary.font = [UIFont boldSystemFontOfSize:42];
    self.titleLabelPrimary.attributedText = [titleLabelText copy];
    self.titleLabelPrimary.translatesAutoresizingMaskIntoConstraints = NO;

    [self addSubview:self.titleLabelPrimary];    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.isFirstLayout) {
        // searchBar constraints
        self.searchBarConstraintTop = [self.searchBar asc_pinEdge:NSLayoutAttributeTop toParentEdge:NSLayoutAttributeTop
                                                                     constant:self.bounds.size.height * ASCViewTextFieldContractedMultiplierOffsetY];
        self.searchBarConstraintHeight = [self.searchBar asc_setAttribute:NSLayoutAttributeHeight toConstant:self.searchBar.intrinsicContentSize.height];
        self.searchBarConstraintWidth = [self.searchBar asc_setAttribute:NSLayoutAttributeWidth toConstant:self.bounds.size.width * ASCViewTextFieldContractedMultiplierWidth];
        self.searchBarConstraintCenter = [self.searchBar asc_centerHorizontallyInParent];
        
        // searchTableView constraints
        self.searchTableViewConstraintTop = [self.searchTableView asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeBottom
                                                                    ofSibling:self.searchBar constant:-(self.searchBarConstraintHeight.constant)];
        self.searchTableViewConstraintHeight = [self.searchTableView asc_setAttribute:NSLayoutAttributeHeight toConstant:0.];
        self.searchTableViewConstraintWidth = [self.searchTableView asc_setAttribute:NSLayoutAttributeWidth toConstant:self.bounds.size.width * ASCViewTextFieldContractedMultiplierWidth];
        self.searchTableViewConstraintCenter = [self.searchTableView asc_centerHorizontallyInParent];
        
        // shadowSearchTableView constraints
        [self.shadowSearchTableView asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeTop ofSibling:self.searchTableView constant:0];
        [self.shadowSearchTableView asc_pinEdge:NSLayoutAttributeLeft toEdge:NSLayoutAttributeLeft ofSibling:self.searchTableView constant:0];
        [self.shadowSearchTableView asc_pinEdge:NSLayoutAttributeRight toEdge:NSLayoutAttributeRight ofSibling:self.searchTableView constant:0];
        [self.shadowSearchTableView asc_pinEdge:NSLayoutAttributeBottom toEdge:NSLayoutAttributeBottom ofSibling:self.searchTableView constant:0];
        
        // titleLabelSecondary constraints
        self.titleLabelSecondaryConstraintTop = [self.titleLabelSecondary asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeTop ofSibling:self.searchBar constant:-40.];
        self.titleLabelSecondaryConstraintCenter = [self.titleLabelSecondary asc_centerHorizontallyInParent];
        
        // titleLabelPrimary constraints
        self.titleLabelPrimaryConstraintTop = [self.titleLabelPrimary asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeTop ofSibling:self.titleLabelSecondary constant:-53.];
        self.titleLabelPrimaryConstraintCenter = [self.titleLabelPrimary asc_centerHorizontallyInParent];
        
        self.isFirstLayout = NO;
    } 
}

#pragma mark - Helper methods
- (void)expandToKeyboardHeight:(CGFloat)keyboardHeight {
    [self layoutIfNeeded];
    
    CGFloat availableSpace = self.bounds.size.height - keyboardHeight - ASCViewTableViewExpandedOffsetY - 5.;
    if (availableSpace > self.searchTableView.contentSize.height) {
        self.searchTableViewConstraintHeight.constant = self.searchTableView.contentSize.height;
    } else {
        self.searchTableViewConstraintHeight.constant = availableSpace;
    }

    self.searchBarConstraintTop.constant = ASCViewTextFieldExpandedOffsetY;
    self.searchBarConstraintWidth.constant = self.bounds.size.width * ASCViewTextFieldExpandedMultiplierWidth;
    self.searchTableViewConstraintTop.constant = 1.;
    self.searchTableViewConstraintWidth.constant = self.bounds.size.width * ASCViewTextFieldExpandedMultiplierWidth;
    
    __weak ASCSearchView *weakSelf = self;
    
    [UIView animateWithDuration:ASCViewAnimationDuration delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
        weakSelf.searchTableView.hidden = NO;
        weakSelf.searchTableView.alpha = 1;
        
        weakSelf.shadowSearchTableView.hidden = NO;
        weakSelf.shadowSearchTableView.alpha = 1;
        
        [weakSelf layoutIfNeeded];
    } completion:^(BOOL finished) {
        weakSelf.titleLabelSecondary.hidden = YES;
        weakSelf.titleLabelPrimary.hidden = YES;
    }];
}

- (void)contract {
    [self layoutIfNeeded];

    self.searchBarConstraintTop.constant = self.bounds.size.height * ASCViewTextFieldContractedMultiplierOffsetY;
    self.searchBarConstraintWidth.constant = self.bounds.size.width * ASCViewTextFieldContractedMultiplierWidth;
    
    __weak ASCSearchView *weakSelf = self;
    [UIView animateWithDuration:0.05 animations:^{
        weakSelf.searchTableView.alpha = 0;
        weakSelf.shadowSearchTableView.alpha = 0;
    } completion:^(BOOL finished) {
        weakSelf.searchTableView.hidden = YES;
        weakSelf.shadowSearchTableView.hidden = YES;
        weakSelf.searchTableViewConstraintTop.constant = -(weakSelf.searchBarConstraintHeight.constant);
        weakSelf.searchTableViewConstraintWidth.constant = weakSelf.bounds.size.width * ASCViewTextFieldContractedMultiplierWidth;
        weakSelf.searchTableViewConstraintHeight.constant = 0.;
    }];
    
    self.titleLabelSecondary.hidden = NO;
    self.titleLabelPrimary.hidden = NO;
    [UIView animateWithDuration:ASCViewAnimationDuration delay:0. usingSpringWithDamping:0.8 initialSpringVelocity:0. options:0 animations:^{
        [weakSelf layoutIfNeeded];
    } completion:nil];
}

- (BOOL)isExpanded {
    return self.searchBarConstraintTop.constant == ASCViewTextFieldExpandedOffsetY;
}

- (void)updateConstraints {
    [super updateConstraints];
    
    if (![self isExpanded]) {
        self.searchBarConstraintTop.constant = self.bounds.size.height * ASCViewTextFieldContractedMultiplierOffsetY;
        self.searchBarConstraintWidth.constant = self.bounds.size.width * ASCViewTextFieldContractedMultiplierWidth;
        self.searchTableViewConstraintWidth.constant = self.bounds.size.width * ASCViewTextFieldContractedMultiplierWidth;
    } else {
        self.searchBarConstraintWidth.constant = self.bounds.size.width * ASCViewTextFieldExpandedMultiplierWidth;
        self.searchTableViewConstraintWidth.constant = self.bounds.size.width * ASCViewTextFieldExpandedMultiplierWidth;
    }
}

- (void)hideSearchTableViewAnimated:(BOOL)animated completion:(void (^)(void))completion {
    [self layoutIfNeeded];
    self.searchTableViewConstraintHeight.constant = 0;
    self.searchBar.collectionView.hidden = NO;
    self.searchBar.dividerView.hidden = NO;
    
    __weak ASCView *weakSelf = self;
    void (^animations)(void) = ^void(void) {
        [weakSelf layoutIfNeeded];
    };
    
    if (animated) {
        [UIView animateWithDuration:ASCViewAnimationDuration animations:animations completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    } else {
        animations();
        
        if (completion) {
            completion();
        }
    }
}

@end
