//
//  ASCSearchView.m
//  SearchClient
//
//  Created by Alex Hill on 10/19/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCCoverView.h"
#import "ASCSearchResultsView.h"
#import "ASCCollectionView.h"
#import "ASCTextField.h"

@interface ASCCoverView()

@property (nonatomic, weak) NSLayoutConstraint *titleLabelSecondaryConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *titleLabelSecondaryConstraintCenter;
@property (nonatomic, weak) NSLayoutConstraint *titleLabelPrimaryConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *titleLabelPrimaryConstraintCenter;

@end

@implementation ASCCoverView

- (void)setup {
    [super setup];
    
    self.searchHistoryTableView.alpha = 0;
    self.shadowSearchHistoryTableView.alpha = 0;
    
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
    self.titleLabelPrimary.font = [UIFont boldSystemFontOfSize:58];
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
        
        // shadowSearchBar constraints
        [self.shadowSearchBar asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeTop ofSibling:self.searchBar constant:0];
        [self.shadowSearchBar asc_pinEdge:NSLayoutAttributeLeft toEdge:NSLayoutAttributeLeft ofSibling:self.searchBar constant:0];
        [self.shadowSearchBar asc_pinEdge:NSLayoutAttributeRight toEdge:NSLayoutAttributeRight ofSibling:self.searchBar constant:0];
        [self.shadowSearchBar asc_pinEdge:NSLayoutAttributeBottom toEdge:NSLayoutAttributeBottom ofSibling:self.searchBar constant:0];
        
        // searchHistoryTableView constraints
        self.searchHistoryTableViewConstraintTop = [self.searchHistoryTableView asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeBottom
                                                                    ofSibling:self.searchBar constant:-(self.searchBarConstraintHeight.constant)];
        self.searchHistoryTableViewConstraintHeight = [self.searchHistoryTableView asc_setAttribute:NSLayoutAttributeHeight toConstant:0.];
        self.searchHistoryTableViewConstraintWidth = [self.searchHistoryTableView asc_setAttribute:NSLayoutAttributeWidth toConstant:self.bounds.size.width * ASCViewTextFieldContractedMultiplierWidth];
        self.searchHistoryTableViewConstraintCenter = [self.searchHistoryTableView asc_centerHorizontallyInParent];
        
        // shadowSearchHistoryTableView constraints
        [self.shadowSearchHistoryTableView asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeTop ofSibling:self.searchHistoryTableView constant:0];
        [self.shadowSearchHistoryTableView asc_pinEdge:NSLayoutAttributeLeft toEdge:NSLayoutAttributeLeft ofSibling:self.searchHistoryTableView constant:0];
        [self.shadowSearchHistoryTableView asc_pinEdge:NSLayoutAttributeRight toEdge:NSLayoutAttributeRight ofSibling:self.searchHistoryTableView constant:0];
        [self.shadowSearchHistoryTableView asc_pinEdge:NSLayoutAttributeBottom toEdge:NSLayoutAttributeBottom ofSibling:self.searchHistoryTableView constant:0];
        
        // titleLabelSecondary constraints
        self.titleLabelSecondaryConstraintTop = [self.titleLabelSecondary asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeTop ofSibling:self.searchBar constant:-40.];
        self.titleLabelSecondaryConstraintCenter = [self.titleLabelSecondary asc_centerHorizontallyInParent];
        
        // titleLabelPrimary constraints
        self.titleLabelPrimaryConstraintTop = [self.titleLabelPrimary asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeTop ofSibling:self.titleLabelSecondary constant:-72.];
        self.titleLabelPrimaryConstraintCenter = [self.titleLabelPrimary asc_centerHorizontallyInParent];
        
        self.isFirstLayout = NO;
    } 
}

#pragma mark - Helper methods
- (void)expandToHeight:(CGFloat)keyboardHeight completion:(void (^)(void))completion {
    [self layoutIfNeeded];
    
    CGFloat availableSpace = self.bounds.size.height - keyboardHeight - ASCViewTableViewExpandedOffsetY - 10.;
    if (availableSpace > self.searchHistoryTableView.contentSize.height) {
        self.searchHistoryTableViewConstraintHeight.constant =  self.searchHistoryTableView.contentSize.height < 50
                                                                ? 50 : self.searchHistoryTableView.contentSize.height;
    } else {
        self.searchHistoryTableViewConstraintHeight.constant = availableSpace;
    }

    self.searchBarConstraintTop.constant = ASCViewTextFieldExpandedOffsetY;
    self.searchBarConstraintWidth.constant = self.bounds.size.width * ASCViewTextFieldExpandedMultiplierWidth;
    self.searchHistoryTableViewConstraintTop.constant = 1.;
    self.searchHistoryTableViewConstraintWidth.constant = self.bounds.size.width * ASCViewTextFieldExpandedMultiplierWidth;
    
    __weak ASCCoverView *weakSelf = self;
    
    [UIView animateWithDuration:ASCViewAnimationDuration delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
        weakSelf.searchHistoryTableView.hidden = NO;
        weakSelf.searchHistoryTableView.alpha = 1;
        
        weakSelf.shadowSearchHistoryTableView.hidden = NO;
        weakSelf.shadowSearchHistoryTableView.alpha = 1;
        
        [weakSelf layoutIfNeeded];
    } completion:^(BOOL finished) {
        weakSelf.titleLabelSecondary.hidden = YES;
        weakSelf.titleLabelPrimary.hidden = YES;
        
        if (completion) {
            completion();
        }
    }];
}

- (void)contract {
    [self layoutIfNeeded];

    self.searchBarConstraintTop.constant = self.bounds.size.height * ASCViewTextFieldContractedMultiplierOffsetY;
    self.searchBarConstraintWidth.constant = self.bounds.size.width * ASCViewTextFieldContractedMultiplierWidth;
    
    __weak ASCCoverView *weakSelf = self;
    [UIView animateWithDuration:0.05 animations:^{
        weakSelf.searchHistoryTableView.alpha = 0;
        weakSelf.shadowSearchHistoryTableView.alpha = 0;
    } completion:^(BOOL finished) {
        weakSelf.searchHistoryTableView.hidden = YES;
        weakSelf.shadowSearchHistoryTableView.hidden = YES;
        weakSelf.searchHistoryTableViewConstraintTop.constant = -(weakSelf.searchBarConstraintHeight.constant);
        weakSelf.searchHistoryTableViewConstraintWidth.constant = weakSelf.bounds.size.width * ASCViewTextFieldContractedMultiplierWidth;
        weakSelf.searchHistoryTableViewConstraintHeight.constant = 0.;
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

- (void)updateLayoutWithOrientation:(CGSize)screenSize {
    if (![self isExpanded]) {
        self.searchBarConstraintTop.constant = screenSize.height * ASCViewTextFieldContractedMultiplierOffsetY;
        self.searchBarConstraintWidth.constant = screenSize.width * ASCViewTextFieldContractedMultiplierWidth;
        self.searchHistoryTableViewConstraintWidth.constant = screenSize.width * ASCViewTextFieldContractedMultiplierWidth;
    } else {
        self.searchBarConstraintWidth.constant = screenSize.width * ASCViewTextFieldExpandedMultiplierWidth;
        self.searchHistoryTableViewConstraintWidth.constant = screenSize.width * ASCViewTextFieldExpandedMultiplierWidth;
    }
}

- (void)restoreToOriginalState {
    self.searchBar.collectionView.hidden = YES;
    self.searchBar.dividerView.hidden = YES;
    self.searchBar.textField.text = @"";
    self.searchBarConstraintHeight.constant = self.searchBar.intrinsicContentSize.height;
    self.searchHistoryTableViewConstraintTop.constant = -(self.searchBarConstraintHeight.constant);
    [self contract];
}

@end
